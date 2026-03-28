// lib/shared/models/sleep_check_in.dart
// Waketale v2 — Sleep check-in data model (Riverpod v3, freezed).

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_check_in.freezed.dart';
part 'sleep_check_in.g.dart';

@freezed
abstract class SleepCheckIn with _$SleepCheckIn {
  const factory SleepCheckIn({
    required String id,
    required String userId,
    required DateTime date,
    required DateTime bedtime,
    required DateTime wakeTime,
    required int sleepLatencyMinutes,   // minutes to fall asleep
    required int wakeEpisodes,          // number of wake-ups
    required int moodRating,            // 1-5 (1=terrible, 5=great)
    int? sleepScore,                    // 0-100 calculated by backend
    double? sleepEfficiency,            // percentage
    int? totalSleepMinutes,
    int? timeInBedMinutes,
    String? coachInsight,               // AI-generated insight
    bool? isWearableData,               // true if imported from health kit
    DateTime? createdAt,
  }) = _SleepCheckIn;

  factory SleepCheckIn.fromJson(Map<String, dynamic> json) =>
      _$SleepCheckInFromJson(json);
}

// ── Mood enum helpers ─────────────────────────────────────────────────────────

enum MoodRating {
  terrible(1),
  bad(2),
  ok(3),
  good(4),
  great(5);

  const MoodRating(this.value);
  final int value;

  static MoodRating fromValue(int value) =>
      MoodRating.values.firstWhere((m) => m.value == value,
          orElse: () => MoodRating.ok);

  String emoji() {
    switch (this) {
      case MoodRating.terrible: return '😩';
      case MoodRating.bad:      return '😔';
      case MoodRating.ok:       return '😐';
      case MoodRating.good:     return '🙂';
      case MoodRating.great:    return '😄';
    }
  }
}
