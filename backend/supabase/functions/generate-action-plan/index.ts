// supabase/functions/generate-action-plan/index.ts
// Waketale v2 — Generates a 3-step personalized action plan using Groq.
// Called after morning check-in. Considers CBT-I week, sleep data, history.

import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const GROQ_API_URL = 'https://api.groq.com/openai/v1/chat/completions';
const GROQ_MODEL = 'llama-3.3-70b-versatile';

serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', {
      headers: { 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type' },
    });
  }

  try {
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) return new Response(JSON.stringify({ error: 'Missing auth' }), { status: 401 });

    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_ANON_KEY')!,
      { global: { headers: { Authorization: authHeader } } }
    );

    const { data: { user }, error: authError } = await supabase.auth.getUser();
    if (authError || !user) return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401 });

    const body = await req.json();
    const checkInId: string | undefined = body.check_in_id;
    const date: string = body.date ?? new Date().toISOString().split('T')[0];

    // Check if plan already exists for today
    const { data: existingPlan } = await supabase
      .from('action_plans')
      .select('*')
      .eq('user_id', user.id)
      .eq('date', date)
      .maybeSingle();

    if (existingPlan) {
      return new Response(JSON.stringify({ plan: existingPlan }), {
        headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' },
      });
    }

    // Fetch check-in data
    let checkIn: Record<string, unknown> | null = null;
    if (checkInId) {
      const { data } = await supabase
        .from('sleep_check_ins')
        .select('*')
        .eq('id', checkInId)
        .eq('user_id', user.id)
        .single();
      checkIn = data;
    } else {
      // Try today's
      const { data } = await supabase
        .from('sleep_check_ins')
        .select('*')
        .eq('user_id', user.id)
        .eq('date', date)
        .maybeSingle();
      checkIn = data;
    }

    // Fetch user profile
    const { data: userProfile } = await supabase
      .from('users')
      .select('cbti_week, current_streak, bedtime_target, wake_target')
      .eq('id', user.id)
      .maybeSingle();

    const cbtiWeek = userProfile?.cbti_week ?? 1;

    // Build prompt
    const sleepContext = checkIn
      ? `Sleep score: ${checkIn.sleep_score ?? 'N/A'}/100, efficiency: ${
          checkIn.sleep_efficiency ? Math.round(Number(checkIn.sleep_efficiency) * 100) + '%' : 'N/A'
        }, total sleep: ${checkIn.total_sleep_minutes ?? 'N/A'} min, latency: ${
          checkIn.sleep_latency_minutes ?? 'N/A'
        } min, wake episodes: ${checkIn.wake_episodes ?? 'N/A'}, mood: ${
          checkIn.mood_rating ?? 'N/A'
        }/5.`
      : 'No check-in data for today.';

    const cbtiContext = `CBT-I week ${cbtiWeek}/8. Streak: ${userProfile?.current_streak ?? 0} days.`;

    const prompt = `You are a CBT-I sleep coach. Generate EXACTLY 3 action steps for today based on this data:

${sleepContext}
${cbtiContext}

Rules:
1. Each step must be SPECIFIC and ACTIONABLE (not generic advice)
2. Each step targets an area from the user's data (if score < 70: focus on biggest weakness)
3. Steps should reflect CBT-I week ${cbtiWeek} curriculum
4. Each step: 1-2 sentences max
5. Include category: one of [sleep_hygiene, stimulus_control, sleep_restriction, cognitive, relaxation, tracking]
6. Include a brief "why": one sentence explaining the CBT-I rationale

Respond ONLY with valid JSON in this exact format:
{
  "steps": [
    {"title": "string", "description": "string", "category": "string", "why": "string"},
    {"title": "string", "description": "string", "category": "string", "why": "string"},
    {"title": "string", "description": "string", "category": "string", "why": "string"}
  ]
}`;

    const groqKey = Deno.env.get('GROQ_API_KEY');
    if (!groqKey) return new Response(JSON.stringify({ error: 'GROQ_API_KEY not configured' }), { status: 500 });

    const groqRes = await fetch(GROQ_API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${groqKey}`,
      },
      body: JSON.stringify({
        model: GROQ_MODEL,
        messages: [{ role: 'user', content: prompt }],
        max_tokens: 600,
        temperature: 0.6,
        response_format: { type: 'json_object' },
      }),
    });

    if (!groqRes.ok) {
      const errText = await groqRes.text();
      console.error('Groq error:', errText);
      return new Response(JSON.stringify({ error: 'AI service error' }), { status: 502 });
    }

    const groqData = await groqRes.json();
    const rawContent = groqData.choices?.[0]?.message?.content ?? '{}';

    let steps = [];
    try {
      const parsed = JSON.parse(rawContent);
      steps = parsed.steps ?? [];
    } catch {
      console.error('Failed to parse Groq JSON:', rawContent);
      // Fallback steps
      steps = [
        { title: 'Stick to your wake time', description: 'Get up at the same time regardless of how you slept.', category: 'stimulus_control', why: 'Consistent wake time is the cornerstone of CBT-I.' },
        { title: 'No screens 1 hour before bed', description: 'Replace screens with reading or light stretching.', category: 'sleep_hygiene', why: 'Blue light suppresses melatonin and increases arousal.' },
        { title: 'Get outside for 10 minutes', description: 'Morning sunlight anchors your circadian rhythm.', category: 'sleep_hygiene', why: 'Light is the strongest circadian signal.' },
      ];
    }

    // Save plan
    const { data: savedPlan, error: saveError } = await supabase
      .from('action_plans')
      .insert({
        user_id: user.id,
        check_in_id: checkInId ?? null,
        date,
        steps,
      })
      .select()
      .single();

    if (saveError) throw saveError;

    return new Response(JSON.stringify({ plan: savedPlan }), {
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' },
    });
  } catch (err) {
    console.error('generate-action-plan error:', err);
    return new Response(JSON.stringify({ error: 'Internal error' }), { status: 500 });
  }
});
