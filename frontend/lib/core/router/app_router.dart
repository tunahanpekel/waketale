// lib/core/router/app_router.dart
// Waketale v2 — GoRouter with Supabase auth guard + RevenueCat identity sync.
// Routes: onboarding → home (5 tabs) → paywall → check-in (modal)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../l10n/app_strings.dart';
import '../theme/app_theme.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/check_in/presentation/check_in_screen.dart';
import '../../features/coach/presentation/coach_screen.dart';
import '../../features/progress/presentation/progress_screen.dart';
import '../../features/routines/presentation/routines_screen.dart';
import '../../features/paywall/presentation/paywall_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/sleep_tracker/presentation/sleep_tracker_screen.dart';

part 'app_router.g.dart';

// ─── Route paths ──────────────────────────────────────────────────────────────

class AppRoutes {
  AppRoutes._();

  static const root         = '/';
  static const onboarding   = '/onboarding';
  static const shell        = '/shell';
  static const home         = '/shell/home';
  static const progress     = '/shell/progress';
  static const coach        = '/shell/coach';
  static const routines     = '/shell/routines';
  static const settings     = '/shell/settings';
  static const checkIn      = '/check-in';
  static const paywall      = '/paywall';
  static const sleepTracker = '/sleep-tracker';
}

// ─── Auth state stream ────────────────────────────────────────────────────────

@riverpod
Stream<AuthState> authState(Ref ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
}

// ─── Auth Change Notifier ─────────────────────────────────────────────────────

class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier(Ref ref) {
    ref.listen(authStateProvider, (_, __) => notifyListeners());
  }
}

// ─── Router ───────────────────────────────────────────────────────────────────

@riverpod
GoRouter appRouter(Ref ref) {
  final authNotifier = _AuthChangeNotifier(ref);
  late final GoRouter router;

  ref.listen(authStateProvider, (_, next) {
    final event = next.asData?.value.event;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (event == AuthChangeEvent.signedIn) {
        // Sync RevenueCat user identity
        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId != null) {
          Purchases.logIn(userId).then((_) {}, onError: (_) {});
        }
        router.go(AppRoutes.home);
      } else if (event == AuthChangeEvent.signedOut) {
        Purchases.logOut().then((_) {}, onError: (_) {});
        router.go(AppRoutes.onboarding);
      }
    });
  });

  router = GoRouter(
    initialLocation: _getInitialRoute(),
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final isAuthenticated =
          Supabase.instance.client.auth.currentUser != null;
      final isOnboarding = state.matchedLocation.startsWith('/onboarding');

      if (!isAuthenticated && !isOnboarding) return AppRoutes.onboarding;
      if (isAuthenticated && isOnboarding) return AppRoutes.home;
      return null;
    },
    routes: [
      // ── Onboarding ──────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.onboarding,
        pageBuilder: (context, state) => _fadeTransition(
          state,
          const OnboardingScreen(),
        ),
      ),

      // ── Shell (main tab navigation) ─────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) =>
            MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => _noTransition(
              state,
              const HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.progress,
            pageBuilder: (context, state) => _noTransition(
              state,
              const ProgressScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.coach,
            pageBuilder: (context, state) => _noTransition(
              state,
              const CoachScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.routines,
            pageBuilder: (context, state) => _noTransition(
              state,
              const RoutinesScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.settings,
            pageBuilder: (context, state) => _noTransition(
              state,
              const SettingsScreen(),
            ),
          ),
        ],
      ),

      // ── Modal screens ────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.checkIn,
        pageBuilder: (context, state) => _slideUpTransition(
          state,
          const CheckInScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.paywall,
        pageBuilder: (context, state) => _slideUpTransition(
          state,
          const PaywallScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.sleepTracker,
        pageBuilder: (context, state) => _slideUpTransition(
          state,
          const SleepTrackerScreen(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: _ErrorScreen(error: state.error?.message ?? 'Not found'),
    ),
  );

  return router;
}

String _getInitialRoute() {
  final isAuthenticated = Supabase.instance.client.auth.currentUser != null;
  return isAuthenticated ? AppRoutes.home : AppRoutes.onboarding;
}

// ─── Transitions ──────────────────────────────────────────────────────────────

CustomTransitionPage<void> _fadeTransition(
    GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, _, child) =>
        FadeTransition(opacity: animation, child: child),
    transitionDuration: const Duration(milliseconds: 300),
  );
}

CustomTransitionPage<void> _slideUpTransition(
    GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, _, child) {
      final tween = Tween(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 350),
  );
}

NoTransitionPage<void> _noTransition(GoRouterState state, Widget child) {
  return NoTransitionPage(key: state.pageKey, child: child);
}

// ─── Main Shell (bottom nav) ─────────────────────────────────────────────────

class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final s = S.of(context);
    final location = GoRouterState.of(context).matchedLocation;

    final tabs = [
      AppRoutes.home,
      AppRoutes.progress,
      AppRoutes.coach,
      AppRoutes.routines,
      AppRoutes.settings,
    ];

    int currentIndex = tabs.indexWhere((t) => location.startsWith(t));
    if (currentIndex < 0) currentIndex = 0;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => context.go(tabs[i]),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.wb_sunny_outlined),
            activeIcon: const Icon(Icons.wb_sunny),
            label: s.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.show_chart_outlined),
            activeIcon: const Icon(Icons.show_chart),
            label: s.navProgress,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat_bubble_outline),
            activeIcon: const Icon(Icons.chat_bubble),
            label: s.navCoach,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bedtime_outlined),
            activeIcon: const Icon(Icons.bedtime),
            label: s.navRoutines,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: s.navSettings,
          ),
        ],
      ),
    );
  }
}

// ─── Error screen ─────────────────────────────────────────────────────────────

class _ErrorScreen extends ConsumerWidget {
  const _ErrorScreen({required this.error});
  final String error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final s = S.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppTheme.error),
            const SizedBox(height: AppTheme.md),
            Text(s.commonPageNotFound,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppTheme.sm),
            Text(error,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: AppTheme.lg),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: Text(s.commonGoHome),
            ),
          ],
        ),
      ),
    );
  }
}
