// lib/shared/models/action_plan.dart
// Waketale v2 — Daily action plan model (3-step CBT-I plan).

import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_plan.freezed.dart';
part 'action_plan.g.dart';

@freezed
abstract class ActionPlan with _$ActionPlan {
  const factory ActionPlan({
    required String id,
    required String userId,
    required DateTime date,
    required List<ActionStep> steps,
    String? coachIntro,     // 1-2 sentence personalized intro
    String? cbtiPhase,      // e.g. "Week 2: Sleep Restriction"
    DateTime? createdAt,
  }) = _ActionPlan;

  factory ActionPlan.fromJson(Map<String, dynamic> json) =>
      _$ActionPlanFromJson(json);
}

@freezed
abstract class ActionStep with _$ActionStep {
  const factory ActionStep({
    required String id,
    required int order,
    required String title,
    required String description,
    required String whyExplanation, // CBT-I rationale
    required ActionCategory category,
    @Default(false) bool isCompleted,
    String? targetTime,  // e.g. "10:45 PM tonight"
  }) = _ActionStep;

  factory ActionStep.fromJson(Map<String, dynamic> json) =>
      _$ActionStepFromJson(json);
}

enum ActionCategory {
  sleepSchedule,      // bedtime/wake time adjustments
  stimulusControl,    // bed = sleep only, leave bed if awake
  sleepRestriction,   // specific window
  relaxation,         // pre-sleep wind-down
  cognitiveRestructuring, // thought patterns
  sleepHygiene,       // caffeine, light, temperature
  exercise,           // timing of physical activity
}
