// lib/main.dart
// Waketale v2 — Entry point.
// Initializes: Firebase, Supabase, RevenueCat, timezone, Mixpanel.
// All keys injected via --dart-define at build time.

import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'core/analytics/mixpanel_service.dart';
import 'core/config/app_config.dart';
import 'core/l10n/app_strings.dart';
import 'core/router/app_router.dart';
import 'core/services/notification_service.dart';
import 'core/services/revenue_cat_service.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  // ── Error handlers ─────────────────────────────────────────────────────────
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Uncaught: $error\n$stack');
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (kDebugMode) return ErrorWidget(details.exception);
    return const SizedBox.shrink();
  };

  // ── Image cache ────────────────────────────────────────────────────────────
  PaintingBinding.instance.imageCache
    ..maximumSize = 150
    ..maximumSizeBytes = 40 << 20;

  // Validate dart-defines in debug/profile mode
  AppConfig.assertProductionConfig();

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Timezone database (for local notifications)
  tz.initializeTimeZones();

  // Firebase
  await Firebase.initializeApp();

  // ── First-run secure storage wipe (iOS Keychain persists across reinstalls)
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('app_first_run') ?? true) {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    await prefs.setBool('app_first_run', false);
  }

  // Supabase — explicit PKCE flow (default in v2, but pinned for clarity)
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );

  // RevenueCat
  await RevenueCatService.initialize();

  // Local notifications — init with device locale for channel name/description
  await NotificationService.init(S.fromLangCode(deviceLang()));

  // Mixpanel (non-blocking)
  await MixpanelService.init();

  runApp(
    const ProviderScope(
      child: WaketaleApp(),
    ),
  );
}

// ─── Root App ─────────────────────────────────────────────────────────────────

class WaketaleApp extends ConsumerWidget {
  const WaketaleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Waketale',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

      // Localization
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('es'),
        Locale('de'),
        Locale('fr'),
        Locale('pt'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Router
      routerConfig: router,
    );
  }
}
