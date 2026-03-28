// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  subscriptionTier: json['subscriptionTier'] as String? ?? 'free',
  preferredLanguage: json['preferredLanguage'] as String? ?? 'en',
  analyticsConsent: json['analyticsConsent'] as bool? ?? false,
  isEuUser: json['isEuUser'] as bool? ?? false,
  targetBedtimeHour: (json['targetBedtimeHour'] as num?)?.toInt(),
  targetBedtimeMinute: (json['targetBedtimeMinute'] as num?)?.toInt(),
  targetWakeHour: (json['targetWakeHour'] as num?)?.toInt(),
  targetWakeMinute: (json['targetWakeMinute'] as num?)?.toInt(),
  targetSleepMinutes: (json['targetSleepMinutes'] as num?)?.toInt(),
  cbtiWeek: (json['cbtiWeek'] as num?)?.toInt(),
  programStartDate: json['programStartDate'] == null
      ? null
      : DateTime.parse(json['programStartDate'] as String),
  appleHealthEnabled: json['appleHealthEnabled'] as bool? ?? false,
  googleFitEnabled: json['googleFitEnabled'] as bool? ?? false,
  currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
  longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
  lastCheckInDate: json['lastCheckInDate'] == null
      ? null
      : DateTime.parse(json['lastCheckInDate'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'subscriptionTier': instance.subscriptionTier,
      'preferredLanguage': instance.preferredLanguage,
      'analyticsConsent': instance.analyticsConsent,
      'isEuUser': instance.isEuUser,
      'targetBedtimeHour': instance.targetBedtimeHour,
      'targetBedtimeMinute': instance.targetBedtimeMinute,
      'targetWakeHour': instance.targetWakeHour,
      'targetWakeMinute': instance.targetWakeMinute,
      'targetSleepMinutes': instance.targetSleepMinutes,
      'cbtiWeek': instance.cbtiWeek,
      'programStartDate': instance.programStartDate?.toIso8601String(),
      'appleHealthEnabled': instance.appleHealthEnabled,
      'googleFitEnabled': instance.googleFitEnabled,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'lastCheckInDate': instance.lastCheckInDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
