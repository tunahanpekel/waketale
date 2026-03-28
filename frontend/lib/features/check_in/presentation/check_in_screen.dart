// lib/features/check_in/presentation/check_in_screen.dart
// Waketale v2 — Morning sleep check-in. 5 inputs, under 60 seconds.
// Design Principle 3: no keyboard for core flow. All quick-tap inputs.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/network/supabase_client.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/sleep_check_in.dart';
import '../../../features/home/presentation/home_screen.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> {
  // State
  TimeOfDay _bedtime = const TimeOfDay(hour: 23, minute: 0);
  TimeOfDay _wakeTime = const TimeOfDay(hour: 7, minute: 0);
  int _sleepLatency = 15; // minutes
  int _wakeEpisodes = 0;
  int _moodRating = 3; // 1-5

  bool _isSaving = false;

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;

      final now = DateTime.now();
      final bedtime = DateTime(
        now.year, now.month, now.day - 1,
        _bedtime.hour, _bedtime.minute,
      );
      final wakeTime = DateTime(
        now.year, now.month, now.day,
        _wakeTime.hour, _wakeTime.minute,
      );

      await SupabaseClientService.client
          .from(SupabaseClientService.tableCheckIns)
          .insert({
        'user_id': userId,
        'date': now.toIso8601String(),
        'bedtime': bedtime.toIso8601String(),
        'wake_time': wakeTime.toIso8601String(),
        'sleep_latency_minutes': _sleepLatency,
        'wake_episodes': _wakeEpisodes,
        'mood_rating': _moodRating,
      });

      // Invalidate home providers to refresh
      ref.invalidate(todayCheckInProvider);
      ref.invalidate(todayActionPlanProvider);

      if (mounted) {
        final s = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(s.checkInSuccess),
          backgroundColor: AppTheme.success,
        ));
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        final s = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(s.errorGenericBody),
          backgroundColor: AppTheme.error,
        ));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.checkInTitle),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Bedtime ─────────────────────────────────────────────────────
            _TimePickerTile(
              label: s.checkInBedtime,
              time: _bedtime,
              onChanged: (t) => setState(() => _bedtime = t),
            ),
            const SizedBox(height: AppTheme.md),

            // ── Wake time ────────────────────────────────────────────────────
            _TimePickerTile(
              label: s.checkInWakeTime,
              time: _wakeTime,
              onChanged: (t) => setState(() => _wakeTime = t),
            ),
            const SizedBox(height: AppTheme.md),

            // ── Sleep latency ────────────────────────────────────────────────
            _SliderTile(
              label: s.checkInSleepLatency,
              value: _sleepLatency.toDouble(),
              min: 0,
              max: 120,
              divisions: 24,
              displayValue: '$_sleepLatency ${s.checkInMinutes}',
              onChanged: (v) => setState(() => _sleepLatency = v.round()),
            ),
            const SizedBox(height: AppTheme.md),

            // ── Wake episodes ────────────────────────────────────────────────
            _StepperTile(
              label: s.checkInWakeEpisodes,
              value: _wakeEpisodes,
              unit: s.checkInTimes,
              min: 0,
              max: 10,
              onDecrement: () => setState(() {
                if (_wakeEpisodes > 0) _wakeEpisodes--;
              }),
              onIncrement: () => setState(() {
                if (_wakeEpisodes < 10) _wakeEpisodes++;
              }),
            ),
            const SizedBox(height: AppTheme.md),

            // ── Mood ─────────────────────────────────────────────────────────
            _MoodSelector(
              label: s.checkInMood,
              value: _moodRating,
              s: s,
              onChanged: (v) => setState(() => _moodRating = v),
            ),
            const SizedBox(height: AppTheme.xl),

            // ── Save button ──────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppTheme.textPrimary,
                        ),
                      )
                    : Text(s.checkInSubmit),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}

// ─── Input widgets ─────────────────────────────────────────────────────────────

class _TimePickerTile extends StatelessWidget {
  const _TimePickerTile({
    required this.label,
    required this.time,
    required this.onChanged,
  });

  final String label;
  final TimeOfDay time;
  final ValueChanged<TimeOfDay> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: time,
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: AppTheme.primary,
                    surface: AppTheme.bgMid,
                  ),
            ),
            child: child!,
          ),
        );
        if (picked != null) onChanged(picked);
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.md),
        decoration: BoxDecoration(
          color: AppTheme.bgMid,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: AppTheme.bgBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: Theme.of(context).textTheme.bodyMedium),
            Text(
              time.format(context),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliderTile extends StatelessWidget {
  const _SliderTile({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.displayValue,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String displayValue;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.md),
      decoration: BoxDecoration(
        color: AppTheme.bgMid,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: AppTheme.bgBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
              Text(
                displayValue,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.primary,
                    ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppTheme.primary,
              thumbColor: AppTheme.primary,
              inactiveTrackColor: AppTheme.bgBorder,
              trackHeight: 3,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepperTile extends StatelessWidget {
  const _StepperTile({
    required this.label,
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.onDecrement,
    required this.onIncrement,
  });

  final String label;
  final int value;
  final String unit;
  final int min;
  final int max;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.md),
      decoration: BoxDecoration(
        color: AppTheme.bgMid,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: AppTheme.bgBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: value > min ? onDecrement : null,
                color: AppTheme.primary,
                iconSize: 28,
              ),
              SizedBox(
                width: 40,
                child: Text(
                  '$value $unit',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: value < max ? onIncrement : null,
                color: AppTheme.primary,
                iconSize: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MoodSelector extends StatelessWidget {
  const _MoodSelector({
    required this.label,
    required this.value,
    required this.s,
    required this.onChanged,
  });

  final String label;
  final int value;
  final S s;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final moods = [
      (1, MoodRating.terrible.emoji(), s.moodTerrible),
      (2, MoodRating.bad.emoji(), s.moodBad),
      (3, MoodRating.ok.emoji(), s.moodOk),
      (4, MoodRating.good.emoji(), s.moodGood),
      (5, MoodRating.great.emoji(), s.moodGreat),
    ];

    return Container(
      padding: const EdgeInsets.all(AppTheme.md),
      decoration: BoxDecoration(
        color: AppTheme.bgMid,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: AppTheme.bgBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: AppTheme.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: moods.map((m) {
              final (rating, emoji, name) = m;
              final isSelected = value == rating;
              return GestureDetector(
                onTap: () => onChanged(rating),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppTheme.primary.withValues(alpha: 0.2)
                            : Colors.transparent,
                        border: isSelected
                            ? Border.all(color: AppTheme.primary, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(emoji,
                            style: TextStyle(
                                fontSize: isSelected ? 28 : 22)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      name,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: isSelected
                                ? AppTheme.primary
                                : AppTheme.textHint,
                          ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
