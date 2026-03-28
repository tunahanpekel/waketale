// supabase/functions/ai-coach/index.ts
// Waketale v2 — AI Coach via Groq Llama 3.3 70B.
// Features: CBT-I system prompt, longitudinal memory (last 20 messages from DB),
// context injection (latest sleep check-in data).
// Auth required (JWT validation).

import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const GROQ_API_URL = 'https://api.groq.com/openai/v1/chat/completions';
const GROQ_MODEL = 'llama-3.3-70b-versatile';

const CBTI_SYSTEM_PROMPT = `You are an expert CBT-I (Cognitive Behavioral Therapy for Insomnia) sleep coach named Sage.

Your approach:
- Evidence-based CBT-I techniques: sleep restriction, stimulus control, cognitive restructuring, sleep hygiene, relaxation
- Compassionate but practical — no empty reassurance
- Short responses (2-4 sentences unless more detail is needed)
- Always personalize to the user's data when provided
- Do NOT prescribe medication or replace medical advice
- If the user reports severe symptoms (suicidal ideation, severe mental illness), refer to professional help immediately

CBT-I principles you apply:
1. Sleep restriction therapy — consolidate sleep window to build drive
2. Stimulus control — bed is only for sleep and sex
3. Cognitive restructuring — challenge catastrophic sleep thoughts
4. Sleep hygiene — consistent schedule, light, temperature, caffeine
5. Relaxation — progressive muscle relaxation, breathing, mindfulness

When the user's sleep data is provided, reference specific metrics (score, efficiency, latency) to make advice concrete.`;

serve(async (req: Request) => {
  // CORS
  if (req.method === 'OPTIONS') {
    return new Response('ok', {
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
      },
    });
  }

  try {
    // Auth
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Missing auth' }), { status: 401 });
    }

    const token = authHeader.replace('Bearer ', '');

    // Use service role key to validate user JWT reliably
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
    );
    const { data: { user }, error: authError } = await supabaseAdmin.auth.getUser(token);
    if (authError || !user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401 });
    }

    // RLS-respecting client for DB queries
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_ANON_KEY')!,
      { global: { headers: { Authorization: authHeader } } }
    );

    const body = await req.json();
    const userMessage: string = body.message ?? '';
    const clientHistory: Array<{ role: string; content: string }> = body.history ?? [];

    if (!userMessage.trim()) {
      return new Response(JSON.stringify({ error: 'Empty message' }), { status: 400 });
    }

    // Load longitudinal memory from DB (last 20 messages)
    const { data: dbHistory } = await supabase
      .from('coach_chat_history')
      .select('role, content')
      .eq('user_id', user.id)
      .order('created_at', { ascending: false })
      .limit(20);

    const longMemory = (dbHistory ?? []).reverse();

    // Load latest sleep check-in for context
    const { data: latestCheckIn } = await supabase
      .from('sleep_check_ins')
      .select('date, sleep_score, sleep_efficiency, total_sleep_minutes, sleep_latency_minutes, wake_episodes, mood_rating')
      .eq('user_id', user.id)
      .order('date', { ascending: false })
      .limit(1)
      .maybeSingle();

    // Load user profile for CBT-I week
    const { data: userProfile } = await supabase
      .from('users')
      .select('cbti_week, current_streak')
      .eq('id', user.id)
      .maybeSingle();

    // Build context string
    let contextStr = '';
    if (latestCheckIn) {
      const efficiency = latestCheckIn.sleep_efficiency
        ? `${Math.round(latestCheckIn.sleep_efficiency * 100)}%`
        : 'unknown';
      contextStr = `\n\n[User sleep data — last night (${latestCheckIn.date}): Sleep score ${latestCheckIn.sleep_score ?? 'N/A'}/100, efficiency ${efficiency}, total sleep ${latestCheckIn.total_sleep_minutes ?? 'N/A'} min, latency ${latestCheckIn.sleep_latency_minutes ?? 'N/A'} min, wake episodes ${latestCheckIn.wake_episodes ?? 'N/A'}, mood ${latestCheckIn.mood_rating ?? 'N/A'}/5. CBT-I week: ${userProfile?.cbti_week ?? 1}/8. Streak: ${userProfile?.current_streak ?? 0} days.]`;
    }

    // Merge: DB memory + client-side recent (dedup by taking client recent if DB empty)
    const mergedHistory = longMemory.length > 0 ? longMemory : clientHistory;

    // Build Groq messages
    const messages = [
      {
        role: 'system',
        content: CBTI_SYSTEM_PROMPT + contextStr,
      },
      ...mergedHistory.slice(-12).map((m) => ({
        role: m.role as 'user' | 'assistant',
        content: m.content,
      })),
      { role: 'user' as const, content: userMessage },
    ];

    // Call Groq
    const groqKey = Deno.env.get('GROQ_API_KEY');
    if (!groqKey) {
      return new Response(JSON.stringify({ error: 'GROQ_API_KEY not configured' }), { status: 500 });
    }

    const groqRes = await fetch(GROQ_API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${groqKey}`,
      },
      body: JSON.stringify({
        model: GROQ_MODEL,
        messages,
        max_tokens: 400,
        temperature: 0.7,
      }),
    });

    if (!groqRes.ok) {
      const errText = await groqRes.text();
      console.error('Groq error:', errText);
      return new Response(JSON.stringify({ error: 'AI service error' }), { status: 502 });
    }

    const groqData = await groqRes.json();
    const reply = groqData.choices?.[0]?.message?.content ?? 'I could not generate a response.';

    // Persist to longitudinal memory
    await supabase.from('coach_chat_history').insert([
      { user_id: user.id, role: 'user', content: userMessage },
      { user_id: user.id, role: 'assistant', content: reply },
    ]);

    return new Response(JSON.stringify({ reply }), {
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    });
  } catch (err) {
    console.error('ai-coach error:', err);
    return new Response(JSON.stringify({ error: 'Internal error' }), { status: 500 });
  }
});
