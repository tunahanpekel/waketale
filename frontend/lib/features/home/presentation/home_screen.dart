// lib/features/home/presentation/home_screen.dart
// Waketale v2 — Daily hub. Action plan first, score second (Design Principle 1).
// Shows: greeting, today's action plan, sleep score, bedtime window, coach insight.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/network/supabase_client.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/action_plan.dart';
import '../../../shared/models/sleep_check_in.dart';
import '../../../shared/models/user_profile.dart';
import '../../../shared/widgets/premium_gate.dart';

part 'home_screen.g.dart';

// ─── Providers ────────────────────────────────────────────────────────────────

@riverpod
Future<UserProfile?> currentUser(Ref ref) async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) return null;
  final data = await SupabaseClientService.client
      .from(SupabaseClientService.tableUsers)
      .select()
      .eq('id', userId)
      .maybeSingle();
  if (data == null) return null;
  return UserProfile.fromJson(data);
}

@riverpod
Future<SleepCheckIn?> todayCheckIn(Ref ref) async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) return null;
  final today = DateTime.now();
  final start = DateTime(today.year, today.month, today.day);
  final end = start.add(const Duration(days: 1));
  final data = await SupabaseClientService.client
      .from(SupabaseClientService.tableCheckIns)
      .select()
      .eq('user_id', userId)
      .gte('date', start.toIso8601String())
      .lt('date', end.toIso8601String())
      .maybeSingle();
  if (data == null) return null;
  return SleepCheckIn.fromJson(data);
}

@riverpod
Future<ActionPlan?> todayActionPlan(Ref ref) async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) return null;
  final today = DateTime.now();
  final start = DateTime(today.year, today.month, today.day);
  final end = start.add(const Duration(days: 1));
  final data = await SupabaseClientService.client
      .from(SupabaseClientService.tableActionPlans)
      .select()
      .eq('user_id', userId)
      .gte('date', start.toIso8601String())
      .lt('date', end.toIso8601String())
      .maybeSingle();
  if (data == null) return null;
  return ActionPlan.fromJson(data);
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final s = S.of(context);

    final userAsync = ref.watch(currentUserProvider);
    final checkInAsync = ref.watch(todayCheckInProvider);
    final planAsync = ref.watch(todayActionPlanProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(currentUserProvider);
            ref.invalidate(todayCheckInProvider);
            ref.invalidate(todayActionPlanProvider);
          },
          color: AppTheme.primary,
          backgroundColor: AppTheme.bgMid,
          child: CustomScrollView(
            slivers: [
              // ── App bar ────────────────────────────────────────────────────
              SliverAppBar(
                floating: true,
                backgroundColor: AppTheme.bgDeep,
                title: userAsync.when(
                  data: (user) => Text(
                    '${_greeting(s)}, ${user?.displayName?.split(' ').first ?? Supabase.instance.client.auth.currentUser?.userMetadata?['full_name']?.toString().split(' ').first ?? Supabase.instance.client.auth.currentUser?.userMetadata?['name']?.toString().split(' ').first ?? ''}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  loading: () => Text(s.homeTitle),
                  error: (_, __) => Text(s.homeTitle),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.nightlight_round_outlined,
                        color: AppTheme.primary),
                    onPressed: () => context.push(AppRoutes.sleepTracker),
                    tooltip: s.trackerTitle,
                  ),
                ],
              ),

              // ── Check-in prompt ────────────────────────────────────────────
              SliverToBoxAdapter(
                child: checkInAsync.when(
                  data: (checkIn) => checkIn == null
                      ? _CheckInBanner(s: s)
                      : const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),

              // ── Today's action plan ────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppTheme.md, AppTheme.md, AppTheme.md, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.homeActionPlanTitle,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: AppTheme.sm),
                      planAsync.when(
                        data: (plan) => plan == null
                            ? _EmptyActionPlan(s: s)
                            : _ActionPlanCard(plan: plan, s: s),
                        loading: () => const _SkeletonCard(),
                        error: (_, __) => _ErrorCard(s: s),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Sleep score ────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppTheme.md, AppTheme.lg, AppTheme.md, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.homeSleepScoreTitle,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: AppTheme.sm),
                      checkInAsync.when(
                        data: (checkIn) => checkIn != null
                            ? _SleepScoreCard(checkIn: checkIn, s: s)
                            : _NoScoreCard(s: s),
                        loading: () => const _SkeletonCard(),
                        error: (_, __) => _ErrorCard(s: s),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Sleep debt ─────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppTheme.md, AppTheme.lg, AppTheme.md, 0),
                  child: PremiumGate(
                    featureName: s.homeSleepDebt,
                    child: _SleepDebtCard(s: s),
                  ),
                ),
              ),

              // ── Bedtime window ─────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppTheme.md, AppTheme.lg, AppTheme.md, AppTheme.xxl),
                  child: userAsync.when(
                    data: (user) => user != null
                        ? _BedtimeWindowCard(user: user, s: s)
                        : const SizedBox.shrink(),
                    loading: () => const _SkeletonCard(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _greeting(S s) {
    final hour = DateTime.now().hour;
    if (hour < 12) return s.homeGreetingMorning;
    if (hour < 18) return s.homeGreetingAfternoon;
    return s.homeGreetingEvening;
  }
}

// ─── Widgets ──────────────────────────────────────────────────────────────────

class _CheckInBanner extends StatelessWidget {
  const _CheckInBanner({required this.s});
  final S s;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.checkIn),
      child: Container(
        margin: const EdgeInsets.fromLTRB(
            AppTheme.md, AppTheme.md, AppTheme.md, 0),
        padding: const EdgeInsets.all(AppTheme.md),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        child: Row(
          children: [
            const Text('🌅', style: TextStyle(fontSize: 28)),
            const SizedBox(width: AppTheme.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.homeCheckInPrompt,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    s.homeCheckInCta,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textPrimary.withValues(alpha: 0.7),
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: AppTheme.textPrimary),
          ],
        ),
      ),
    );
  }
}

class _ActionPlanCard extends ConsumerStatefulWidget {
  const _ActionPlanCard({required this.plan, required this.s});
  final ActionPlan plan;
  final S s;

  @override
  ConsumerState<_ActionPlanCard> createState() => _ActionPlanCardState();
}

class _ActionPlanCardState extends ConsumerState<_ActionPlanCard> {
  late List<ActionStep> _steps;

  @override
  void initState() {
    super.initState();
    _steps = List<ActionStep>.from(widget.plan.steps);
  }

  Future<void> _toggleStep(int index) async {
    final updated = _steps[index].copyWith(isCompleted: !_steps[index].isCompleted);
    setState(() {
      _steps[index] = updated;
    });

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    try {
      final stepsJson = _steps.map((s) => s.toJson()).toList();
      await SupabaseClientService.client
          .from(SupabaseClientService.tableActionPlans)
          .update({'steps': stepsJson})
          .eq('id', widget.plan.id)
          .eq('user_id', userId);
    } catch (e) {
      debugPrint('[ActionPlan] Failed to persist step completion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.plan.coachIntro != null) ...[
              Text(
                widget.plan.coachIntro!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
              ),
              const SizedBox(height: AppTheme.md),
            ],
            ..._steps.asMap().entries.map(
                  (entry) => _ActionStepTile(
                    step: entry.value,
                    s: widget.s,
                    onToggle: () => _toggleStep(entry.key),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _ActionStepTile extends StatefulWidget {
  const _ActionStepTile({
    required this.step,
    required this.s,
    required this.onToggle,
  });
  final ActionStep step;
  final S s;
  final VoidCallback onToggle;

  @override
  State<_ActionStepTile> createState() => _ActionStepTileState();
}

class _ActionStepTileState extends State<_ActionStepTile> {
  bool _showWhy = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.onToggle,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.step.isCompleted
                      ? AppTheme.success
                      : Colors.transparent,
                  border: Border.all(
                    color: widget.step.isCompleted
                        ? AppTheme.success
                        : AppTheme.bgBorder,
                    width: 1.5,
                  ),
                ),
                child: widget.step.isCompleted
                    ? const Icon(Icons.check, size: 14, color: AppTheme.bgDeep)
                    : null,
              ),
            ),
            const SizedBox(width: AppTheme.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.step.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          decoration: widget.step.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: widget.step.isCompleted
                              ? AppTheme.textHint
                              : AppTheme.textPrimary,
                        ),
                  ),
                  Text(
                    widget.step.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (widget.step.targetTime != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        widget.step.targetTime!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.accent,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  TextButton(
                    onPressed: () => setState(() => _showWhy = !_showWhy),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      _showWhy ? widget.s.actionHide : widget.s.actionWhyThis,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.primary,
                          ),
                    ),
                  ),
                  if (_showWhy)
                    Container(
                      padding: const EdgeInsets.all(AppTheme.sm),
                      decoration: BoxDecoration(
                        color: AppTheme.bgSurface,
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusSm),
                      ),
                      child: Text(
                        widget.step.whyExplanation,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        if (widget.step.order < 2)
          const Divider(height: AppTheme.lg),
      ],
    );
  }
}

class _SleepScoreCard extends StatelessWidget {
  const _SleepScoreCard({required this.checkIn, required this.s});
  final SleepCheckIn checkIn;
  final S s;

  @override
  Widget build(BuildContext context) {
    final score = checkIn.sleepScore ?? 0;
    final scoreColor = AppTheme.scoreColor(score);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Row(
          children: [
            // Score dial
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: scoreColor, width: 3),
              ),
              child: Center(
                child: Text(
                  '$score',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: scoreColor,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _scoreLabel(score, s),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: scoreColor,
                        ),
                  ),
                  const SizedBox(height: 4),
                  _MetricRow(
                    label: s.scoreEfficiency,
                    value: checkIn.sleepEfficiency != null
                        ? '${(checkIn.sleepEfficiency! * 100).round()}%'
                        : '—',
                  ),
                  if (checkIn.totalSleepMinutes != null)
                    _MetricRow(
                      label: s.homeTotalSleep,
                      value:
                          '${checkIn.totalSleepMinutes! ~/ 60}h ${checkIn.totalSleepMinutes! % 60}m',
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _scoreLabel(int score, S s) {
    if (score < 40) return s.scorePoor;
    if (score < 60) return s.scoreFair;
    if (score < 80) return s.scoreGood;
    if (score < 90) return s.scoreGreat;
    return s.scoreExcellent;
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppTheme.textPrimary),
        ),
      ],
    );
  }
}

class _SleepDebtCard extends StatelessWidget {
  const _SleepDebtCard({required this.s});
  final S s;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s.homeSleepDebt,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppTheme.sm),
            Text(
              s.homeComingSoon,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppTheme.textHint),
            ),
          ],
        ),
      ),
    );
  }
}

class _BedtimeWindowCard extends StatelessWidget {
  const _BedtimeWindowCard({required this.user, required this.s});
  final UserProfile user;
  final S s;

  @override
  Widget build(BuildContext context) {
    if (user.targetBedtimeHour == null) return const SizedBox.shrink();
    final bedtime = _formatTime(user.targetBedtimeHour!, user.targetBedtimeMinute ?? 0);
    final wakeTime = user.targetWakeHour != null
        ? _formatTime(user.targetWakeHour!, user.targetWakeMinute ?? 0)
        : null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Row(
          children: [
            const Text('🌙', style: TextStyle(fontSize: 28)),
            const SizedBox(width: AppTheme.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.homeBedtimeTitle,
                    style: Theme.of(context).textTheme.labelMedium),
                Text(
                  wakeTime != null ? '$bedtime — $wakeTime' : bedtime,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.primary,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int hour, int minute) {
    final h = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final m = minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $period';
  }
}

class _NoScoreCard extends StatelessWidget {
  const _NoScoreCard({required this.s});
  final S s;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Text(
          s.homeNoCheckIn,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppTheme.textHint),
        ),
      ),
    );
  }
}

class _EmptyActionPlan extends StatelessWidget {
  const _EmptyActionPlan({required this.s});
  final S s;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Text(
          s.homeNoCheckIn,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppTheme.textHint),
        ),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppTheme.bgMid,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.s});
  final S s;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Text(
          s.errorGenericBody,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppTheme.error),
        ),
      ),
    );
  }
}
