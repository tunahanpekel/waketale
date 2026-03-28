// lib/features/progress/presentation/progress_screen.dart
// Waketale v2 — Sleep progress with 7/30/90 day trends, milestones, streaks.

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/network/supabase_client.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/sleep_check_in.dart';
import '../../../shared/widgets/premium_gate.dart';

part 'progress_screen.g.dart';

// ─── Providers ────────────────────────────────────────────────────────────────

@riverpod
Future<List<SleepCheckIn>> checkInHistory(
    Ref ref, int days) async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) return [];

  final since = DateTime.now().subtract(Duration(days: days));
  final data = await SupabaseClientService.client
      .from(SupabaseClientService.tableCheckIns)
      .select()
      .eq('user_id', userId)
      .gte('date', since.toIso8601String())
      .order('date', ascending: true);

  return (data as List).map((d) => SleepCheckIn.fromJson(d)).toList();
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> {
  int _selectedDays = 7;

  static const _periods = [7, 30, 90];

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final s = S.of(context);
    final historyAsync = ref.watch(checkInHistoryProvider(_selectedDays));

    return Scaffold(
      appBar: AppBar(title: Text(s.progressTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Period selector ───────────────────────────────────────────
            Row(
              children: _periods.map((days) {
                final isSelected = days == _selectedDays;
                final label = days == 7
                    ? s.progress7Day
                    : days == 30
                        ? s.progress30Day
                        : s.progress90Day;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedDays = days),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.sm),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primary : AppTheme.bgMid,
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primary
                              : AppTheme.bgBorder,
                        ),
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: isSelected
                                  ? AppTheme.textPrimary
                                  : AppTheme.textSecondary,
                            ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: AppTheme.lg),

            // ── Sleep score chart ─────────────────────────────────────────
            Text(s.homeSleepScoreTitle,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppTheme.sm),

            historyAsync.when(
              data: (history) => history.isEmpty
                  ? _EmptyProgress(s: s)
                  : _ScoreChart(history: history, days: _selectedDays),
              loading: () => const _SkeletonChart(),
              error: (_, __) => _ErrorView(s: s),
            ),

            const SizedBox(height: AppTheme.lg),

            // ── Key metrics ────────────────────────────────────────────────
            Text(s.progressStreak,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppTheme.sm),

            historyAsync.when(
              data: (history) => _MetricsGrid(history: history, s: s),
              loading: () => const _SkeletonChart(height: 100),
              error: (_, __) => _ErrorView(s: s),
            ),

            const SizedBox(height: AppTheme.lg),

            // ── 30/90 day locked ──────────────────────────────────────────
            if (_selectedDays > 7)
              PremiumGate(
                featureName: _selectedDays == 30
                    ? s.progress30Day
                    : s.progress90Day,
                child: const SizedBox.shrink(),
              ),

            const SizedBox(height: AppTheme.xxl),
          ],
        ),
      ),
    );
  }
}

// ─── Widgets ──────────────────────────────────────────────────────────────────

class _ScoreChart extends StatelessWidget {
  const _ScoreChart({required this.history, required this.days});
  final List<SleepCheckIn> history;
  final int days;

  @override
  Widget build(BuildContext context) {
    final spots = history.asMap().entries.map((e) {
      return FlSpot(
        e.key.toDouble(),
        (e.value.sleepScore ?? 0).toDouble(),
      );
    }).toList();

    return RepaintBoundary(
      child: SizedBox(
        height: 180,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.md),
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppTheme.primary,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppTheme.primary.withValues(alpha: 0.1),
                    ),
                  ),
                ],
                minY: 0,
                maxY: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid({required this.history, required this.s});
  final List<SleepCheckIn> history;
  final S s;

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) return const SizedBox.shrink();

    final avgScore = history
            .where((c) => c.sleepScore != null)
            .fold(0, (sum, c) => sum + c.sleepScore!) /
        history.where((c) => c.sleepScore != null).length;

    final avgEfficiency = history
            .where((c) => c.sleepEfficiency != null)
            .fold(0.0, (sum, c) => sum + c.sleepEfficiency!) /
        history.where((c) => c.sleepEfficiency != null).length;

    return Row(
      children: [
        Expanded(
          child: _MetricTile(
            label: s.homeSleepScoreTitle,
            value: '${avgScore.round()}',
            color: AppTheme.scoreColor(avgScore.round()),
          ),
        ),
        const SizedBox(width: AppTheme.sm),
        Expanded(
          child: _MetricTile(
            label: s.scoreEfficiency,
            value: '${(avgEfficiency * 100).round()}%',
            color: AppTheme.accentTeal,
          ),
        ),
        const SizedBox(width: AppTheme.sm),
        Expanded(
          child: _MetricTile(
            label: s.progressStreak,
            value: '${history.length}',
            color: AppTheme.accent,
          ),
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyProgress extends StatelessWidget {
  const _EmptyProgress({required this.s});
  final S s;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.xl),
        child: Column(
          children: [
            const Text('📈', style: TextStyle(fontSize: 48)),
            const SizedBox(height: AppTheme.md),
            Text(s.emptyProgressTitle,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: AppTheme.xs),
            Text(s.emptyProgressBody,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _SkeletonChart extends StatelessWidget {
  const _SkeletonChart({this.height = 180});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.bgMid,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.s});
  final S s;

  @override
  Widget build(BuildContext context) {
    return Text(s.errorGenericBody,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppTheme.error));
  }
}
