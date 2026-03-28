// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_check_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SleepCheckIn _$SleepCheckInFromJson(Map<String, dynamic> json) =>
    _SleepCheckIn(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      bedtime: DateTime.parse(json['bedtime'] as String),
      wakeTime: DateTime.parse(json['wakeTime'] as String),
      sleepLatencyMinutes: (json['sleepLatencyMinutes'] as num).toInt(),
      wakeEpisodes: (json['wakeEpisodes'] as num).toInt(),
      moodRating: (json['moodRating'] as num).toInt(),
      sleepScore: (json['sleepScore'] as num?)?.toInt(),
      sleepEfficiency: (json['sleepEfficiency'] as num?)?.toDouble(),
      totalSleepMinutes: (json['totalSleepMinutes'] as num?)?.toInt(),
      timeInBedMinutes: (json['timeInBedMinutes'] as num?)?.toInt(),
      coachInsight: json['coachInsight'] as String?,
      isWearableData: json['isWearableData'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SleepCheckInToJson(_SleepCheckIn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'date': instance.date.toIso8601String(),
      'bedtime': instance.bedtime.toIso8601String(),
      'wakeTime': instance.wakeTime.toIso8601String(),
      'sleepLatencyMinutes': instance.sleepLatencyMinutes,
      'wakeEpisodes': instance.wakeEpisodes,
      'moodRating': instance.moodRating,
      'sleepScore': instance.sleepScore,
      'sleepEfficiency': instance.sleepEfficiency,
      'totalSleepMinutes': instance.totalSleepMinutes,
      'timeInBedMinutes': instance.timeInBedMinutes,
      'coachInsight': instance.coachInsight,
      'isWearableData': instance.isWearableData,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
