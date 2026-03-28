// lib/features/paywall/presentation/paywall_screen.dart
// Waketale v2 — Full-screen paywall with monthly/annual plans and 7-day trial.
// v2: No kDebugMode bypass (fixed v1 BUG-019).

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/services/revenue_cat_service.dart'
    show RevenueCatService, offeringsProvider;
import '../../../core/theme/app_theme.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

// Fallback prices from project-config.json — shown while loading or on error.
const _kFallbackAnnual   = '\$59.99/yr';
const _kFallbackMonthly  = '\$7.99/mo';

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  bool _annualSelected = true;
  bool _isPurchasing = false;
  bool _isRestoring = false;

  Future<void> _purchase() async {
    setState(() => _isPurchasing = true);
    try {
      final ok = await RevenueCatService.purchasePremium(annual: _annualSelected);
      if (ok && mounted) {
        context.pop();
      } else if (mounted) {
        final s = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(s.errorGenericBody),
          backgroundColor: AppTheme.error,
        ));
      }
    } catch (_) {
      if (mounted) {
        final s = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(s.errorGenericBody),
          backgroundColor: AppTheme.error,
        ));
      }
    } finally {
      if (mounted) setState(() => _isPurchasing = false);
    }
  }

  Future<void> _restore() async {
    setState(() => _isRestoring = true);
    try {
      final ok = await RevenueCatService.restorePurchases();
      if (mounted) {
        final s = S.of(context);
        if (ok) {
          context.pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(s.errorGenericBody),
            backgroundColor: AppTheme.error,
          ));
        }
      }
    } finally {
      if (mounted) setState(() => _isRestoring = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final s = S.of(context);

    // AsyncValue from offeringsProvider — drives price strings + loading state
    final offeringsAsync = ref.watch(offeringsProvider);
    final annualPrice = offeringsAsync.asData?.value?.annual?.storeProduct.priceString
        ?? _kFallbackAnnual;
    final monthlyPrice = offeringsAsync.asData?.value?.monthly?.storeProduct.priceString
        ?? _kFallbackMonthly;
    final pricesLoading = offeringsAsync.isLoading;

    final features = [
      s.paywallFeature1,
      s.paywallFeature2,
      s.paywallFeature3,
      s.paywallFeature4,
      s.paywallFeature5,
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.bgDeep, Color(0xFF0E1B32)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Close button ───────────────────────────────────────────────
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppTheme.textSecondary),
                  onPressed: () => context.pop(),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('⭐', style: TextStyle(fontSize: 48)),
                      const SizedBox(height: AppTheme.md),
                      Text(
                        s.paywallTitle,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppTheme.xs),
                      Text(
                        s.paywallSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: AppTheme.lg),

                      // ── Feature list ────────────────────────────────────────
                      ...features.map((f) => _FeatureRow(text: f)),

                      const SizedBox(height: AppTheme.lg),

                      // ── Plan selector ────────────────────────────────────────
                      pricesLoading
                          ? const _PlanCardSkeleton()
                          : Row(
                              children: [
                                Expanded(
                                  child: _PlanCard(
                                    label: s.paywallAnnual,
                                    price: annualPrice,
                                    badge: s.paywallSavePercent,
                                    isSelected: _annualSelected,
                                    onTap: () =>
                                        setState(() => _annualSelected = true),
                                  ),
                                ),
                                const SizedBox(width: AppTheme.sm),
                                Expanded(
                                  child: _PlanCard(
                                    label: s.paywallMonthly,
                                    price: monthlyPrice,
                                    badge: null,
                                    isSelected: !_annualSelected,
                                    onTap: () =>
                                        setState(() => _annualSelected = false),
                                  ),
                                ),
                              ],
                            ),

                      const SizedBox(height: AppTheme.lg),

                      // ── CTA ─────────────────────────────────────────────────
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isPurchasing ? null : _purchase,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                          ),
                          child: _isPurchasing
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppTheme.textPrimary,
                                  ),
                                )
                              : Text(
                                  s.paywallCta,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: AppTheme.sm),

                      Text(
                        s.paywallCancelAnytime,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppTheme.textHint,
                            ),
                      ),

                      const SizedBox(height: AppTheme.md),

                      TextButton(
                        onPressed: _isRestoring ? null : _restore,
                        child: _isRestoring
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppTheme.textHint,
                                ),
                              )
                            : Text(
                                s.paywallRestore,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppTheme.textHint),
                              ),
                      ),

                      const SizedBox(height: AppTheme.sm),

                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppTheme.md),
                        child: Text(
                          s.paywallTrialDisclosure,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppTheme.textHint,
                                fontSize: 10,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: AppTheme.xl),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Widgets ──────────────────────────────────────────────────────────────────

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppTheme.success, size: 18),
          const SizedBox(width: AppTheme.sm),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppTheme.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCardSkeleton extends StatelessWidget {
  const _PlanCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _SkeletonBox(height: 80)),
        const SizedBox(width: AppTheme.sm),
        Expanded(child: _SkeletonBox(height: 80)),
      ],
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.bgMid,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppTheme.textHint,
          ),
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.label,
    required this.price,
    required this.badge,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String price;
  final String? badge;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppTheme.md),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primary.withValues(alpha: 0.15)
              : AppTheme.bgMid,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.bgBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (badge != null)
              Container(
                margin: const EdgeInsets.only(bottom: AppTheme.xs),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.sm, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.accent,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Text(
                  badge!,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: isSelected
                        ? AppTheme.primary
                        : AppTheme.textSecondary,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
