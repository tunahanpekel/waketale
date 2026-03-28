// lib/shared/models/sleep_session.dart
// Waketale v2 — Passive sleep tracking session model.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_session.freezed.dart';
part 'sleep_session.g.dart';

/// Detected sleep phase during passive tracking.
enum SleepPhase { awake, light, deep, rem }

@freezed
abstract class SleepPhaseEvent with _$SleepPhaseEvent {
  const factory SleepPhaseEvent({
    required SleepPhase phase,
    required DateTime startTime,
    DateTime? endTime,
  }) = _SleepPhaseEvent;

  factory SleepPhaseEvent.fromJson(Map<String, dynamic> json) =>
      _$SleepPhaseEventFromJson(json);
}

@freezed
abstract class SmartAlarmConfig with _$SmartAlarmConfig {
  const factory SmartAlarmConfig({
    required DateTime targetWakeTime,
    @Default(30) int windowMinutes,  // wake window before targetWakeTime
    @Default(true) bool enabled,
  }) = _SmartAlarmConfig;

  factory SmartAlarmConfig.fromJson(Map<String, dynamic> json) =>
      _$SmartAlarmConfigFromJson(json);
}

@freezed
abstract class SleepSession with _$SleepSession {
  const factory SleepSession({
    required String id,
    required String userId,
    required DateTime startTime,
    DateTime? endTime,
    @Default([]) List<SleepPhaseEvent> phases,
    SmartAlarmConfig? smartAlarm,
    @Default(SleepSessionStatus.active) SleepSessionStatus status,
    @Default(false) bool isWearableSession,
    // Post-session summary
    int? totalSleepMinutes,
    int? remMinutes,
    int? deepMinutes,
    int? lightMinutes,
    int? awakeMinutes,
    SleepPhase? currentPhase,
    DateTime? createdAt,
  }) = _SleepSession;

  factory SleepSession.fromJson(Map<String, dynamic> json) =>
      _$SleepSessionFromJson(json);
}

enum SleepSessionStatus { active, completed, cancelled }
