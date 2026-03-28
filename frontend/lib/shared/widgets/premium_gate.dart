// lib/shared/widgets/premium_gate.dart
// Waketale v2 — Wraps premium-only content. Shows paywall nudge if not premium.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/router/app_router.dart';
import '../../core/services/revenue_cat_service.dart';
import '../../core/theme/app_theme.dart';

class PremiumGate extends ConsumerWidget {
  const PremiumGate({
    super.key,
    required this.child,
    this.featureName,
  });

  final Widget child;
  final String? featureName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final s = S.of(context);
    final isPremium = ref.watch(isPremiumProvider);

    if (isPremium) return child;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.bgMid,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsets.all(AppTheme.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock_outline, color: AppTheme.primary, size: 32),
          const SizedBox(height: AppTheme.sm),
          Text(
            s.premiumGateTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppTheme.xs),
          Text(
            featureName != null
                ? '$featureName ${s.premiumGateBody}'
                : s.premiumGateBody,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.md),
          ElevatedButton(
            onPressed: () => context.push(AppRoutes.paywall),
            child: Text(s.premiumGateCta),
          ),
        ],
      ),
    );
  }
}
