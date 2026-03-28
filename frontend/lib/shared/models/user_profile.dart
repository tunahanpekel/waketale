// lib/shared/models/user_profile.dart
// Waketale v2 — User profile model.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String email,
    String? displayName,
    String? avatarUrl,
    @Default('free') String subscriptionTier,
    @Default('en') String preferredLanguage,
    @Default(false) bool analyticsConsent,
    @Default(false) bool isEuUser,
    // Sleep preferences
    int? targetBedtimeHour,    // 0-23
    int? targetBedtimeMinute,  // 0-59
    int? targetWakeHour,
    int? targetWakeMinute,
    int? targetSleepMinutes,   // desired total sleep duration
    // CBT-I program
    int? cbtiWeek,             // current week in 8-week program
    DateTime? programStartDate,
    // Wearables
    @Default(false) bool appleHealthEnabled,
    @Default(false) bool googleFitEnabled,
    // Streaks
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    DateTime? lastCheckInDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
