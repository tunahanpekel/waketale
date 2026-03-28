// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActionPlan _$ActionPlanFromJson(Map<String, dynamic> json) => _ActionPlan(
  id: json['id'] as String,
  userId: json['userId'] as String,
  date: DateTime.parse(json['date'] as String),
  steps: (json['steps'] as List<dynamic>)
      .map((e) => ActionStep.fromJson(e as Map<String, dynamic>))
      .toList(),
  coachIntro: json['coachIntro'] as String?,
  cbtiPhase: json['cbtiPhase'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ActionPlanToJson(_ActionPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'date': instance.date.toIso8601String(),
      'steps': instance.steps,
      'coachIntro': instance.coachIntro,
      'cbtiPhase': instance.cbtiPhase,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_ActionStep _$ActionStepFromJson(Map<String, dynamic> json) => _ActionStep(
  id: json['id'] as String,
  order: (json['order'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  whyExplanation: json['whyExplanation'] as String,
  category: $enumDecode(_$ActionCategoryEnumMap, json['category']),
  isCompleted: json['isCompleted'] as bool? ?? false,
  targetTime: json['targetTime'] as String?,
);

Map<String, dynamic> _$ActionStepToJson(_ActionStep instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'title': instance.title,
      'description': instance.description,
      'whyExplanation': instance.whyExplanation,
      'category': _$ActionCategoryEnumMap[instance.category]!,
      'isCompleted': instance.isCompleted,
      'targetTime': instance.targetTime,
    };

const _$ActionCategoryEnumMap = {
  ActionCategory.sleepSchedule: 'sleepSchedule',
  ActionCategory.stimulusControl: 'stimulusControl',
  ActionCategory.sleepRestriction: 'sleepRestriction',
  ActionCategory.relaxation: 'relaxation',
  ActionCategory.cognitiveRestructuring: 'cognitiveRestructuring',
  ActionCategory.sleepHygiene: 'sleepHygiene',
  ActionCategory.exercise: 'exercise',
};
