// supabase/functions/calculate-sleep-score/index.ts
// Waketale v2 — Calculates sleep score (0-100) from check-in data.
// Algorithm based on CBT-I research metrics.
// Called after check-in submission to update the check-in row.

import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

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
    const checkInId: string = body.check_in_id;

    if (!checkInId) return new Response(JSON.stringify({ error: 'check_in_id required' }), { status: 400 });

    // Fetch check-in
    const { data: checkIn, error: fetchError } = await supabase
      .from('sleep_check_ins')
      .select('*')
      .eq('id', checkInId)
      .eq('user_id', user.id)
      .single();

    if (fetchError || !checkIn) return new Response(JSON.stringify({ error: 'Check-in not found' }), { status: 404 });

    // ── Score calculation algorithm ─────────────────────────────────────────
    // Based on: total sleep time, sleep efficiency, latency, wake episodes, mood
    // Max points per component:
    //   Sleep efficiency:    35 pts  (target ≥ 85%)
    //   Total sleep time:    30 pts  (target 7-9 hrs)
    //   Sleep latency:       20 pts  (target ≤ 20 min)
    //   Wake episodes:       10 pts  (target 0-1)
    //   Mood rating:          5 pts  (bonus)

    let score = 0;

    // 1. Sleep efficiency (35 pts)
    if (checkIn.sleep_efficiency != null) {
      const eff = Number(checkIn.sleep_efficiency);
      if (eff >= 0.90) score += 35;
      else if (eff >= 0.85) score += 30;
      else if (eff >= 0.75) score += 22;
      else if (eff >= 0.65) score += 14;
      else score += 6;
    } else {
      // If no efficiency data, derive from times
      if (checkIn.bedtime && checkIn.wake_time && checkIn.sleep_latency_minutes != null) {
        const bed = new Date(checkIn.bedtime).getTime();
        const wake = new Date(checkIn.wake_time).getTime();
        const totalMinutes = (wake - bed) / 60000;
        const asleepMinutes = totalMinutes - checkIn.sleep_latency_minutes
          - (checkIn.wake_episodes ?? 0) * 15;
        const efficiency = Math.max(0, asleepMinutes / totalMinutes);

        const totalSleepMinutes = Math.max(0, asleepMinutes);

        if (efficiency >= 0.90) score += 35;
        else if (efficiency >= 0.85) score += 30;
        else if (efficiency >= 0.75) score += 22;
        else if (efficiency >= 0.65) score += 14;
        else score += 6;

        // Update derived values
        await supabase.from('sleep_check_ins').update({
          sleep_efficiency: efficiency,
          total_sleep_minutes: Math.round(totalSleepMinutes),
        }).eq('id', checkInId);
      } else {
        score += 18; // neutral if no data
      }
    }

    // 2. Total sleep time (30 pts) — target 7-9 hrs (420-540 min)
    const tst = checkIn.total_sleep_minutes;
    if (tst != null) {
      if (tst >= 420 && tst <= 540) score += 30;
      else if (tst >= 360 && tst < 420) score += 22; // 6-7 hrs
      else if (tst > 540 && tst <= 600) score += 22; // 9-10 hrs
      else if (tst >= 300 && tst < 360) score += 14; // 5-6 hrs
      else if (tst > 600) score += 14;               // >10 hrs
      else score += 6;                               // <5 hrs
    } else {
      score += 15; // neutral
    }

    // 3. Sleep latency (20 pts) — target ≤ 20 min
    const latency = checkIn.sleep_latency_minutes;
    if (latency != null) {
      if (latency <= 10) score += 20;
      else if (latency <= 20) score += 17;
      else if (latency <= 30) score += 12;
      else if (latency <= 45) score += 7;
      else score += 2;
    } else {
      score += 10; // neutral
    }

    // 4. Wake episodes (10 pts) — target 0-1
    const wakeEp = checkIn.wake_episodes;
    if (wakeEp != null) {
      if (wakeEp === 0) score += 10;
      else if (wakeEp === 1) score += 8;
      else if (wakeEp <= 3) score += 5;
      else if (wakeEp <= 5) score += 2;
      else score += 0;
    } else {
      score += 5; // neutral
    }

    // 5. Mood bonus (5 pts)
    const mood = checkIn.mood_rating;
    if (mood != null) {
      score += Math.round((mood / 5) * 5);
    }

    const finalScore = Math.min(100, Math.max(0, Math.round(score)));

    // Update check-in with calculated score
    const { error: updateError } = await supabase
      .from('sleep_check_ins')
      .update({ sleep_score: finalScore })
      .eq('id', checkInId)
      .eq('user_id', user.id);

    if (updateError) throw updateError;

    // Update user streak
    await _updateStreak(supabase, user.id);

    return new Response(JSON.stringify({ score: finalScore }), {
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' },
    });
  } catch (err) {
    console.error('calculate-sleep-score error:', err);
    return new Response(JSON.stringify({ error: 'Internal error' }), { status: 500 });
  }
});

async function _updateStreak(supabase: ReturnType<typeof createClient>, userId: string) {
  try {
    const today = new Date().toISOString().split('T')[0];
    const yesterday = new Date(Date.now() - 86400000).toISOString().split('T')[0];

    // Check yesterday's check-in (streak continues if yesterday also had check-in)
    const { data: prevCheckIn } = await supabase
      .from('sleep_check_ins')
      .select('id')
      .eq('user_id', userId)
      .eq('date', yesterday)
      .maybeSingle();

    const { data: user } = await supabase
      .from('users')
      .select('current_streak, longest_streak')
      .eq('id', userId)
      .single();

    const currentStreak = prevCheckIn ? (user?.current_streak ?? 0) + 1 : 1;
    const longestStreak = Math.max(currentStreak, user?.longest_streak ?? 0);

    await supabase.from('users').update({
      current_streak: currentStreak,
      longest_streak: longestStreak,
    }).eq('id', userId);

    await supabase.from('streaks').upsert({
      user_id: userId,
      streak_date: today,
      streak_count: currentStreak,
    }, { onConflict: 'user_id,streak_date' });
  } catch (e) {
    console.error('streak update error:', e);
  }
}
