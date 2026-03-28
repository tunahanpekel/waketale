// lib/core/network/supabase_client.dart
// Supabase client wrapper for Waketale v2.
// Initialized in main.dart via AppConfig dart-defines.

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientService {
  SupabaseClientService._();

  static SupabaseClient get client => Supabase.instance.client;
  static GoTrueClient   get auth   => Supabase.instance.client.auth;

  // ── Table names ─────────────────────────────────────────────────────────────
  static const String tableUsers        = 'users';
  static const String tableCheckIns     = 'sleep_check_ins';
  static const String tableActionPlans  = 'action_plans';
  static const String tableChatHistory  = 'coach_chat_history';
  static const String tableRoutines     = 'bedtime_routines';
  static const String tableSleepSessions = 'sleep_sessions';
  static const String tableStreaks      = 'streaks';

  // ── Edge Function names ──────────────────────────────────────────────────────
  static const String fnAiCoach       = 'ai-coach';
  static const String fnActionPlan    = 'generate-action-plan';
  static const String fnDeleteAccount = 'delete-account';
  static const String fnSleepScore    = 'calculate-sleep-score';
}
