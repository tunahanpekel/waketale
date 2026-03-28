// lib/features/onboarding/presentation/onboarding_screen.dart
// Waketale v2 — 3-slide onboarding with Google + Apple Sign-In.
// v2 design: faster (no 7-screen flow), persona-captured in first check-in.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/theme/app_theme.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;
  bool _isSigningIn = false;

  static const _deepLinkScheme = 'com.waketale.app://login-callback';

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _continueWithGoogle() async {
    setState(() => _isSigningIn = true);
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: _deepLinkScheme,
        authScreenLaunchMode: LaunchMode.externalApplication,
      );
      // GoRouter handles redirect on auth state change
    } catch (e) {
      if (mounted) {
        final s = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${s.onboardingSignInError}: $e'),
          backgroundColor: AppTheme.error,
        ));
      }
    } finally {
      if (mounted) setState(() => _isSigningIn = false);
    }
  }

  Future<void> _continueWithApple() async {
    setState(() => _isSigningIn = true);
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: _deepLinkScheme,
        authScreenLaunchMode: LaunchMode.externalApplication,
      );
    } catch (e) {
      if (mounted) {
        final s = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${s.onboardingSignInError}: $e'),
          backgroundColor: AppTheme.error,
        ));
      }
    } finally {
      if (mounted) setState(() => _isSigningIn = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final s = S.of(context);

    final slides = [
      _SlideData(
        emoji: '🌙',
        title: s.onboardingSlide1Title,
        body: s.onboardingSlide1Body,
        gradient: const [Color(0xFF080E1A), Color(0xFF0F1927)],
      ),
      _SlideData(
        emoji: '📊',
        title: s.onboardingSlide2Title,
        body: s.onboardingSlide2Body,
        gradient: const [Color(0xFF0F1927), Color(0xFF162234)],
      ),
      _SlideData(
        emoji: '⭐',
        title: s.onboardingSlide3Title,
        body: s.onboardingSlide3Body,
        gradient: const [Color(0xFF162234), Color(0xFF080E1A)],
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // ── Page view ──────────────────────────────────────────────────────
          PageView.builder(
            controller: _pageController,
            itemCount: slides.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, i) => _SlidePage(data: slides[i]),
          ),

          // ── Bottom section ─────────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                AppTheme.lg,
                AppTheme.lg,
                AppTheme.lg,
                MediaQuery.of(context).padding.bottom + AppTheme.lg,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, AppTheme.bgDeep],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      slides.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: i == _page ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: i == _page
                              ? AppTheme.primary
                              : AppTheme.textHint,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.lg),

                  // Google sign-in
                  _SignInButton(
                    icon: Icons.g_mobiledata_rounded,
                    label: s.onboardingSignIn,
                    onTap: _isSigningIn ? null : _continueWithGoogle,
                    isLoading: _isSigningIn,
                    isPrimary: true,
                  ),

                  // Apple sign-in (iOS only)
                  if (Platform.isIOS) ...[
                    const SizedBox(height: AppTheme.sm),
                    _SignInButton(
                      icon: Icons.apple,
                      label: s.onboardingSignInApple,
                      onTap: _isSigningIn ? null : _continueWithApple,
                      isLoading: false,
                      isPrimary: false,
                    ),
                  ],

                  const SizedBox(height: AppTheme.sm),
                  TextButton(
                    onPressed: _page < slides.length - 1
                        ? () => _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOutCubic,
                            )
                        : null,
                    child: Text(
                      _page < slides.length - 1 ? s.commonNext : '',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppTheme.textHint),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideData {
  const _SlideData({
    required this.emoji,
    required this.title,
    required this.body,
    required this.gradient,
  });
  final String emoji;
  final String title;
  final String body;
  final List<Color> gradient;
}

class _SlidePage extends StatelessWidget {
  const _SlidePage({required this.data});
  final _SlideData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: data.gradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(data.emoji, style: const TextStyle(fontSize: 72)),
              const SizedBox(height: AppTheme.xl),
              Text(
                data.title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.md),
              Text(
                data.body,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 200), // space for bottom CTAs
            ],
          ),
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isLoading,
    required this.isPrimary,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return ElevatedButton.icon(
        onPressed: onTap,
        icon: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppTheme.textPrimary,
                ),
              )
            : Icon(icon, size: 20),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          backgroundColor: AppTheme.primary,
        ),
      );
    }

    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        side: const BorderSide(color: AppTheme.bgBorder),
      ),
    );
  }
}
