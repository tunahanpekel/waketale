// ignore_for_file: constant_identifier_names
//
// Waketale v2 — app_config.dart
// All values injected via --dart-define at build time. Never hard-code secrets here.
//
// Run locally:
//   flutter run \
//     --dart-define=APP_ENV=dev \
//     --dart-define=SUPABASE_URL=https://xxx.supabase.co \
//     --dart-define=SUPABASE_ANON_KEY=eyJ... \
//     --dart-define=REVENUECAT_APPLE_KEY=appl_... \
//     --dart-define=REVENUECAT_GOOGLE_KEY=goog_... \
//     --dart-define=MIXPANEL_TOKEN=abc123 \
//     --dart-define=GROQ_API_KEY=gsk_...

enum AppEnvironment { dev, staging, prod }

class AppConfig {
  AppConfig._();

  // ── Environment ───────────────────────────────────────────────────────────
  static const String _env =
      String.fromEnvironment('APP_ENV', defaultValue: 'dev');

  static AppEnvironment get environment {
    switch (_env) {
      case 'prod':    return AppEnvironment.prod;
      case 'staging': return AppEnvironment.staging;
      default:        return AppEnvironment.dev;
    }
  }

  static bool get isDev     => environment == AppEnvironment.dev;
  static bool get isStaging => environment == AppEnvironment.staging;
  static bool get isProd    => environment == AppEnvironment.prod;

  // ── App Identity ──────────────────────────────────────────────────────────
  static const String appName      = 'Waketale';
  static const String packageId    = 'com.waketale.app';
  static const String privacyUrl   = 'https://waketale.com/privacy';
  static const String termsUrl     = 'https://waketale.com/terms';
  static const String supportEmail = 'support@waketale.com';

  // ── Supabase ──────────────────────────────────────────────────────────────
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'YOUR_SUPABASE_URL',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'YOUR_SUPABASE_ANON_KEY',
  );

  // ── RevenueCat ────────────────────────────────────────────────────────────
  static const String revenueCatAppleKey = String.fromEnvironment(
    'REVENUECAT_APPLE_KEY',
    defaultValue: 'appl_YOUR_KEY',
  );

  static const String revenueCatGoogleKey = String.fromEnvironment(
    'REVENUECAT_GOOGLE_KEY',
    defaultValue: 'goog_YOUR_KEY',
  );

  /// RevenueCat entitlement ID — must match App Store Connect / Play Console
  static const String entitlementId = 'premium';

  /// Product IDs — must match App Store Connect / Play Console
  static const String productIdAnnual  = 'com.waketale.app_annual';
  static const String productIdMonthly = 'com.waketale.app_monthly';

  // ── Mixpanel ──────────────────────────────────────────────────────────────
  static const String mixpanelToken = String.fromEnvironment(
    'MIXPANEL_TOKEN',
    defaultValue: 'YOUR_MIXPANEL_TOKEN',
  );

  // ── Groq AI ───────────────────────────────────────────────────────────────
  // NOTE: In production, Groq API key is used server-side only (Edge Function).
  // This is kept here only for local dev/testing. Never expose in production builds.
  static const String groqApiKey = String.fromEnvironment(
    'GROQ_API_KEY',
    defaultValue: 'YOUR_GROQ_KEY',
  );

  // ── Groq Model ────────────────────────────────────────────────────────────
  static const String groqModel = 'llama-3.3-70b-versatile';

  // ── Validation ────────────────────────────────────────────────────────────
  static void assertProductionConfig() {
    assert(
      supabaseUrl.isNotEmpty && !supabaseUrl.startsWith('YOUR'),
      'SUPABASE_URL --dart-define not set!',
    );
    assert(
      supabaseAnonKey.isNotEmpty && !supabaseAnonKey.startsWith('YOUR'),
      'SUPABASE_ANON_KEY --dart-define not set!',
    );
  }
}
