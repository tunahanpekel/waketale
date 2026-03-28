// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SleepPhaseEvent _$SleepPhaseEventFromJson(Map<String, dynamic> json) =>
    _SleepPhaseEvent(
      phase: $enumDecode(_$SleepPhaseEnumMap, json['phase']),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$SleepPhaseEventToJson(_SleepPhaseEvent instance) =>
    <String, dynamic>{
      'phase': _$SleepPhaseEnumMap[instance.phase]!,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
    };

const _$SleepPhaseEnumMap = {
  SleepPhase.awake: 'awake',
  SleepPhase.light: 'light',
  SleepPhase.deep: 'deep',
  SleepPhase.rem: 'rem',
};

_SmartAlarmConfig _$SmartAlarmConfigFromJson(Map<String, dynamic> json) =>
    _SmartAlarmConfig(
      targetWakeTime: DateTime.parse(json['targetWakeTime'] as String),
      windowMinutes: (json['windowMinutes'] as num?)?.toInt() ?? 30,
      enabled: json['enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$SmartAlarmConfigToJson(_SmartAlarmConfig instance) =>
    <String, dynamic>{
      'targetWakeTime': instance.targetWakeTime.toIso8601String(),
      'windowMinutes': instance.windowMinutes,
      'enabled': instance.enabled,
    };

_SleepSession _$SleepSessionFromJson(
  Map<String, dynamic> json,
) => _SleepSession(
  id: json['id'] as String,
  userId: json['userId'] as String,
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  phases:
      (json['phases'] as List<dynamic>?)
          ?.map((e) => SleepPhaseEvent.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  smartAlarm: json['smartAlarm'] == null
      ? null
      : SmartAlarmConfig.fromJson(json['smartAlarm'] as Map<String, dynamic>),
  status:
      $enumDecodeNullable(_$SleepSessionStatusEnumMap, json['status']) ??
      SleepSessionStatus.active,
  isWearableSession: json['isWearableSession'] as bool? ?? false,
  totalSleepMinutes: (json['totalSleepMinutes'] as num?)?.toInt(),
  remMinutes: (json['remMinutes'] as num?)?.toInt(),
  deepMinutes: (json['deepMinutes'] as num?)?.toInt(),
  lightMinutes: (json['lightMinutes'] as num?)?.toInt(),
  awakeMinutes: (json['awakeMinutes'] as num?)?.toInt(),
  currentPhase: $enumDecodeNullable(_$SleepPhaseEnumMap, json['currentPhase']),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$SleepSessionToJson(_SleepSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'phases': instance.phases,
      'smartAlarm': instance.smartAlarm,
      'status': _$SleepSessionStatusEnumMap[instance.status]!,
      'isWearableSession': instance.isWearableSession,
      'totalSleepMinutes': instance.totalSleepMinutes,
      'remMinutes': instance.remMinutes,
      'deepMinutes': instance.deepMinutes,
      'lightMinutes': instance.lightMinutes,
      'awakeMinutes': instance.awakeMinutes,
      'currentPhase': _$SleepPhaseEnumMap[instance.currentPhase],
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$SleepSessionStatusEnumMap = {
  SleepSessionStatus.active: 'active',
  SleepSessionStatus.completed: 'completed',
  SleepSessionStatus.cancelled: 'cancelled',
};
