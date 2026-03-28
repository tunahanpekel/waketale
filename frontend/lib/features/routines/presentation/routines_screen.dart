// lib/features/routines/presentation/routines_screen.dart
// Waketale v2 — Bedtime + Morning routines with step-by-step timer mode.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/network/supabase_client.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/premium_gate.dart';

part 'routines_screen.g.dart';

// ─── Models ───────────────────────────────────────────────────────────────────

class RoutineStep {
  const RoutineStep({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.isCompleted,
  });
  final String id;
  final String title;
  final int durationMinutes;
  final bool isCompleted;

  RoutineStep copyWith({bool? isCompleted}) => RoutineStep(
        id: id,
        title: title,
        durationMinutes: durationMinutes,
        isCompleted: isCompleted ?? this.isCompleted,
      );
}

// ─── Default routines ─────────────────────────────────────────────────────────

List<RoutineStep> _defaultWindDown(S s) => [
      RoutineStep(id: 'wd1', title: s.routineStepDimLights,   durationMinutes: 2, isCompleted: false),
      RoutineStep(id: 'wd2', title: s.routineStepBreathing,   durationMinutes: 3, isCompleted: false),
      RoutineStep(id: 'wd3', title: s.routineStepWriteTasks,  durationMinutes: 5, isCompleted: false),
      RoutineStep(id: 'wd4', title: s.routineStepBodyScan,    durationMinutes: 5, isCompleted: false),
      RoutineStep(id: 'wd5', title: s.routineStepSetAlarm,    durationMinutes: 2, isCompleted: false),
    ];

List<RoutineStep> _defaultMorning(S s) => [
      RoutineStep(id: 'mo1', title: s.routineStepBrightLight, durationMinutes: 2, isCompleted: false),
      RoutineStep(id: 'mo2', title: s.routineStepDrinkWater,  durationMinutes: 1, isCompleted: false),
      RoutineStep(id: 'mo3', title: s.routineStepStretch,     durationMinutes: 5, isCompleted: false),
      RoutineStep(id: 'mo4', title: s.routineStepLogCheckin,  durationMinutes: 1, isCompleted: false),
    ];

// ─── Providers ────────────────────────────────────────────────────────────────

@riverpod
Future<Map<String, dynamic>?> userRoutines(Ref ref) async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) return null;

  final data = await SupabaseClientService.client
      .from('bedtime_routines')
      .select()
      .eq('user_id', userId)
      .maybeSingle();

  return data;
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class RoutinesScreen extends ConsumerStatefulWidget {
  const RoutinesScreen({super.key});

  @override
  ConsumerState<RoutinesScreen> createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends ConsumerState<RoutinesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<RoutineStep>? _windDownSteps;
  List<RoutineStep>? _morningSteps;

  bool _windDownActive = false;
  bool _morningActive = false;
  bool _hydratedFromSupabase = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _hydrateFromData(Map<String, dynamic> data, S s) {
    if (_hydratedFromSupabase) return;
    _hydratedFromSupabase = true;

    final rawWind = data['wind_down_steps'];
    final rawMorning = data['morning_steps'];

    if (rawWind is List && rawWind.isNotEmpty) {
      final loaded = <RoutineStep>[];
      for (final item in rawWind) {
        if (item is Map<String, dynamic>) {
          final id = item['id'] as String? ?? '';
          final defaults = _defaultWindDown(s).firstWhere(
            (d) => d.id == id,
            orElse: () => RoutineStep(
              id: id,
              title: item['title'] as String? ?? '',
              durationMinutes: (item['durationMinutes'] as num?)?.toInt() ?? 0,
              isCompleted: false,
            ),
          );
          loaded.add(defaults.copyWith(
            isCompleted: item['isCompleted'] as bool? ?? false,
          ));
        }
      }
      if (loaded.isNotEmpty) _windDownSteps = loaded;
    }

    if (rawMorning is List && rawMorning.isNotEmpty) {
      final loaded = <RoutineStep>[];
      for (final item in rawMorning) {
        if (item is Map<String, dynamic>) {
          final id = item['id'] as String? ?? '';
          final defaults = _defaultMorning(s).firstWhere(
            (d) => d.id == id,
            orElse: () => RoutineStep(
              id: id,
              title: item['title'] as String? ?? '',
              durationMinutes: (item['durationMinutes'] as num?)?.toInt() ?? 0,
              isCompleted: false,
            ),
          );
          loaded.add(defaults.copyWith(
            isCompleted: item['isCompleted'] as bool? ?? false,
          ));
        }
      }
      if (loaded.isNotEmpty) _morningSteps = loaded;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _persistRoutines() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    try {
      final windDownJson = (_windDownSteps ?? [])
          .map((s) => {'id': s.id, 'title': s.title, 'durationMinutes': s.durationMinutes, 'isCompleted': s.isCompleted})
          .toList();
      final morningJson = (_morningSteps ?? [])
          .map((s) => {'id': s.id, 'title': s.title, 'durationMinutes': s.durationMinutes, 'isCompleted': s.isCompleted})
          .toList();

      await SupabaseClientService.client
          .from(SupabaseClientService.tableRoutines)
          .upsert(
            {
              'user_id': userId,
              'wind_down_steps': windDownJson,
              'morning_steps': morningJson,
              'updated_at': DateTime.now().toIso8601String(),
            },
            onConflict: 'user_id',
          );
    } catch (e) {
      debugPrint('[Routines] Failed to persist routine steps: $e');
    }
  }

  void _toggleStep(bool isWindDown, int index) {
    setState(() {
      if (isWindDown && _windDownSteps != null) {
        final step = _windDownSteps![index];
        _windDownSteps![index] = step.copyWith(isCompleted: !step.isCompleted);
      } else if (!isWindDown && _morningSteps != null) {
        final step = _morningSteps![index];
        _morningSteps![index] = step.copyWith(isCompleted: !step.isCompleted);
      }
    });
    _persistRoutines();
  }

  void _resetRoutine(bool isWindDown) {
    setState(() {
      if (isWindDown) {
        _windDownSteps = _windDownSteps?.map((s) => s.copyWith(isCompleted: false)).toList();
        _windDownActive = false;
      } else {
        _morningSteps = _morningSteps?.map((s) => s.copyWith(isCompleted: false)).toList();
        _morningActive = false;
      }
    });
    _persistRoutines();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final s = S.of(context);

    // Lazily initialize default steps with the current locale on first build
    _windDownSteps ??= _defaultWindDown(s);
    _morningSteps ??= _defaultMorning(s);

    ref.listen<AsyncValue<Map<String, dynamic>?>>(userRoutinesProvider, (_, next) {
      next.whenData((data) {
        if (data != null && mounted) {
          setState(() => _hydrateFromData(data, s));
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(s.routinesTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: s.routineWindDown),
            Tab(text: s.routineMorning),
          ],
          indicatorColor: AppTheme.primary,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.textSecondary,
        ),
      ),
      body: PremiumGate(
        featureName: s.routinesTitle,
        child: TabBarView(
          controller: _tabController,
          children: [
            _RoutineTab(
              steps: _windDownSteps!,
              isActive: _windDownActive,
              totalMinutes: _windDownSteps!.fold(0, (sum, s) => sum + s.durationMinutes),
              onStart: () => setState(() => _windDownActive = true),
              onReset: () => _resetRoutine(true),
              onToggleStep: (i) => _toggleStep(true, i),
              s: s,
            ),
            _RoutineTab(
              steps: _morningSteps!,
              isActive: _morningActive,
              totalMinutes: _morningSteps!.fold(0, (sum, s) => sum + s.durationMinutes),
              onStart: () => setState(() => _morningActive = true),
              onReset: () => _resetRoutine(false),
              onToggleStep: (i) => _toggleStep(false, i),
              s: s,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Widgets ──────────────────────────────────────────────────────────────────

class _RoutineTab extends StatelessWidget {
  const _RoutineTab({
    required this.steps,
    required this.isActive,
    required this.totalMinutes,
    required this.onStart,
    required this.onReset,
    required this.onToggleStep,
    required this.s,
  });

  final List<RoutineStep> steps;
  final bool isActive;
  final int totalMinutes;
  final VoidCallback onStart;
  final VoidCallback onReset;
  final ValueChanged<int> onToggleStep;
  final S s;

  int get completedCount => steps.where((s) => s.isCompleted).length;
  bool get allDone => completedCount == steps.length;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Summary card ────────────────────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.md),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$totalMinutes min',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          '${steps.length} steps',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (allDone)
                    Column(
                      children: [
                        const Text('✅', style: TextStyle(fontSize: 32)),
                        Text(s.routineComplete,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: AppTheme.success)),
                      ],
                    )
                  else
                    CircularProgressIndicator(
                      value: steps.isEmpty ? 0 : completedCount / steps.length,
                      color: AppTheme.primary,
                      backgroundColor: AppTheme.bgBorder,
                      strokeWidth: 6,
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppTheme.md),

          // ── Steps ───────────────────────────────────────────────────────────
          ...steps.asMap().entries.map((entry) {
            final i = entry.key;
            final step = entry.value;
            return _StepTile(
              step: step,
              isActive: isActive,
              onTap: isActive ? () => onToggleStep(i) : null,
            );
          }),

          const SizedBox(height: AppTheme.lg),

          // ── Action buttons ──────────────────────────────────────────────────
          if (!isActive)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStart,
                child: Text(s.routineStart),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onReset,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.bgBorder),
                ),
                child: Text(
                  s.commonDone,
                  style: const TextStyle(color: AppTheme.textSecondary),
                ),
              ),
            ),

          const SizedBox(height: AppTheme.xxl),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.step,
    required this.isActive,
    required this.onTap,
  });

  final RoutineStep step;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: AppTheme.sm),
        padding: const EdgeInsets.all(AppTheme.md),
        decoration: BoxDecoration(
          color: step.isCompleted
              ? AppTheme.success.withValues(alpha: 0.1)
              : AppTheme.bgMid,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(
            color: step.isCompleted ? AppTheme.success : AppTheme.bgBorder,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: step.isCompleted ? AppTheme.success : Colors.transparent,
                border: Border.all(
                  color: step.isCompleted ? AppTheme.success : AppTheme.bgBorder,
                  width: 2,
                ),
              ),
              child: step.isCompleted
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: AppTheme.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: step.isCompleted
                              ? AppTheme.textSecondary
                              : AppTheme.textPrimary,
                          decoration: step.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.sm, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.bgSurface,
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Text(
                '${step.durationMinutes}m',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.textHint,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
