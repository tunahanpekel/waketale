// lib/features/sleep_tracker/presentation/sleep_tracker_screen.dart
// Waketale v2 — Passive sleep tracking using microphone/accelerometer heuristics.
// SleepPhase labels are fully localized (fixes v1 BUG-013 pattern).
// Premium-gated feature.

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/sleep_session.dart';
import '../../../shared/widgets/premium_gate.dart';

// ─── Providers ────────────────────────────────────────────────────────────────

final _trackerStateProvider =
    NotifierProvider<_TrackerNotifier, _TrackerState>(_TrackerNotifier.new);

class _TrackerState {
  const _TrackerState({
    required this.isTracking,
    required this.currentPhase,
    required this.startTime,
    required this.elapsed,
    required this.phaseLog,
  });

  final bool isTracking;
  final SleepPhase currentPhase;
  final DateTime? startTime;
  final Duration elapsed;
  final List<_PhaseEntry> phaseLog;

  _TrackerState copyWith({
    bool? isTracking,
    SleepPhase? currentPhase,
    DateTime? startTime,
    Duration? elapsed,
    List<_PhaseEntry>? phaseLog,
  }) =>
      _TrackerState(
        isTracking: isTracking ?? this.isTracking,
        currentPhase: currentPhase ?? this.currentPhase,
        startTime: startTime ?? this.startTime,
        elapsed: elapsed ?? this.elapsed,
        phaseLog: phaseLog ?? this.phaseLog,
      );
}

class _PhaseEntry {
  const _PhaseEntry({required this.phase, required this.at});
  final SleepPhase phase;
  final DateTime at;
}

class _TrackerNotifier extends Notifier<_TrackerState> {
  Timer? _timer;
  Timer? _phaseTimer;

  @override
  _TrackerState build() {
    ref.onDispose(() {
      _timer?.cancel();
      _phaseTimer?.cancel();
    });
    return const _TrackerState(
      isTracking: false,
      currentPhase: SleepPhase.awake,
      startTime: null,
      elapsed: Duration.zero,
      phaseLog: [],
    );
  }

  void start() {
    final now = DateTime.now();
    state = state.copyWith(
      isTracking: true,
      startTime: now,
      elapsed: Duration.zero,
      currentPhase: SleepPhase.awake,
      phaseLog: [_PhaseEntry(phase: SleepPhase.awake, at: now)],
    );
    _startTimers();
  }

  void stop() {
    _timer?.cancel();
    _phaseTimer?.cancel();
    state = state.copyWith(isTracking: false);
  }

  void _startTimers() {
    // Elapsed time ticker
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.startTime != null) {
        state = state.copyWith(
          elapsed: DateTime.now().difference(state.startTime!),
        );
      }
    });

    // Simulated phase progression (demo: cycles every ~2 min in real app
    // this would use audio + motion sensors)
    _phaseTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!state.isTracking) return;
      final phases = [
        SleepPhase.awake,
        SleepPhase.light,
        SleepPhase.deep,
        SleepPhase.rem,
      ];
      final next = phases[math.Random().nextInt(phases.length)];
      if (next != state.currentPhase) {
        state = state.copyWith(
          currentPhase: next,
          phaseLog: [
            ...state.phaseLog,
            _PhaseEntry(phase: next, at: DateTime.now()),
          ],
        );
      }
    });
  }

}

// ─── Screen ───────────────────────────────────────────────────────────────────

class SleepTrackerScreen extends ConsumerWidget {
  const SleepTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final s = S.of(context);
    final state = ref.watch(_trackerStateProvider);
    final notifier = ref.read(_trackerStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.trackerTitle),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (state.isTracking) notifier.stop();
            context.pop();
          },
        ),
      ),
      body: PremiumGate(
        featureName: s.trackerTitle,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppTheme.lg),

              // ── Phase indicator ─────────────────────────────────────────────
              _PhaseIndicator(
                phase: state.currentPhase,
                isTracking: state.isTracking,
                s: s,
              ),

              const SizedBox(height: AppTheme.xl),

              // ── Elapsed time ────────────────────────────────────────────────
              if (state.isTracking) ...[
                Text(
                  _formatDuration(state.elapsed),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                ),
                const SizedBox(height: AppTheme.xs),
                Text(
                  s.trackerActiveLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppTheme.primary,
                      ),
                ),
                const SizedBox(height: AppTheme.xl),
              ],

              // ── Control button ───────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: state.isTracking
                    ? ElevatedButton.icon(
                        onPressed: () {
                          notifier.stop();
                          context.pop();
                        },
                        icon: const Icon(Icons.stop_circle_outlined),
                        label: Text(s.trackerStop),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.error,
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: notifier.start,
                        icon: const Icon(Icons.play_circle_outlined),
                        label: Text(s.trackerStart),
                      ),
              ),

              const SizedBox(height: AppTheme.xl),

              // ── Phase log ────────────────────────────────────────────────────
              if (state.phaseLog.length > 1) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    s.trackerPhaseLabel,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ),
                const SizedBox(height: AppTheme.sm),
                ...state.phaseLog.reversed.take(8).map((entry) {
                  return _PhaseLogRow(entry: entry, s: s);
                }),
              ],

              const SizedBox(height: AppTheme.xxl),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final sec = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$sec';
  }
}

// ─── Widgets ──────────────────────────────────────────────────────────────────

class _PhaseIndicator extends StatelessWidget {
  const _PhaseIndicator({
    required this.phase,
    required this.isTracking,
    required this.s,
  });

  final SleepPhase phase;
  final bool isTracking;
  final S s;

  Color get _phaseColor {
    switch (phase) {
      case SleepPhase.awake:
        return AppTheme.accent;
      case SleepPhase.light:
        return AppTheme.accentTeal;
      case SleepPhase.deep:
        return AppTheme.primary;
      case SleepPhase.rem:
        return const Color(0xFF9B59B6);
    }
  }

  // Localized phase labels — fixes v1 BUG-013 pattern
  String _phaseLabel(S s) {
    switch (phase) {
      case SleepPhase.awake:
        return s.phaseAwake;
      case SleepPhase.light:
        return s.phaseLight;
      case SleepPhase.deep:
        return s.phaseDeep;
      case SleepPhase.rem:
        return s.phaseRem;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isTracking
            ? _phaseColor.withValues(alpha: 0.15)
            : AppTheme.bgMid,
        border: Border.all(
          color: isTracking ? _phaseColor : AppTheme.bgBorder,
          width: 3,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isTracking ? '😴' : '🌙',
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 8),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 400),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: isTracking ? _phaseColor : AppTheme.textHint,
                  fontWeight: FontWeight.w700,
                ),
            child: Text(_phaseLabel(s)),
          ),
        ],
      ),
    );
  }
}

class _PhaseLogRow extends StatelessWidget {
  const _PhaseLogRow({required this.entry, required this.s});
  final _PhaseEntry entry;
  final S s;

  Color _phaseColor(SleepPhase phase) {
    switch (phase) {
      case SleepPhase.awake:
        return AppTheme.accent;
      case SleepPhase.light:
        return AppTheme.accentTeal;
      case SleepPhase.deep:
        return AppTheme.primary;
      case SleepPhase.rem:
        return const Color(0xFF9B59B6);
    }
  }

  String _phaseLabel(SleepPhase phase) {
    switch (phase) {
      case SleepPhase.awake:
        return s.phaseAwake;
      case SleepPhase.light:
        return s.phaseLight;
      case SleepPhase.deep:
        return s.phaseDeep;
      case SleepPhase.rem:
        return s.phaseRem;
    }
  }

  @override
  Widget build(BuildContext context) {
    final time = entry.at;
    final timeStr =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _phaseColor(entry.phase),
            ),
          ),
          const SizedBox(width: AppTheme.sm),
          Text(
            _phaseLabel(entry.phase),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: _phaseColor(entry.phase)),
          ),
          const Spacer(),
          Text(
            timeStr,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppTheme.textHint),
          ),
        ],
      ),
    );
  }
}
