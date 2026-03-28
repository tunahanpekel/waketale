// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActionPlan {

 String get id; String get userId; DateTime get date; List<ActionStep> get steps; String? get coachIntro;// 1-2 sentence personalized intro
 String? get cbtiPhase;// e.g. "Week 2: Sleep Restriction"
 DateTime? get createdAt;
/// Create a copy of ActionPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActionPlanCopyWith<ActionPlan> get copyWith => _$ActionPlanCopyWithImpl<ActionPlan>(this as ActionPlan, _$identity);

  /// Serializes this ActionPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActionPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.coachIntro, coachIntro) || other.coachIntro == coachIntro)&&(identical(other.cbtiPhase, cbtiPhase) || other.cbtiPhase == cbtiPhase)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,const DeepCollectionEquality().hash(steps),coachIntro,cbtiPhase,createdAt);

@override
String toString() {
  return 'ActionPlan(id: $id, userId: $userId, date: $date, steps: $steps, coachIntro: $coachIntro, cbtiPhase: $cbtiPhase, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ActionPlanCopyWith<$Res>  {
  factory $ActionPlanCopyWith(ActionPlan value, $Res Function(ActionPlan) _then) = _$ActionPlanCopyWithImpl;
@useResult
$Res call({
 String id, String userId, DateTime date, List<ActionStep> steps, String? coachIntro, String? cbtiPhase, DateTime? createdAt
});




}
/// @nodoc
class _$ActionPlanCopyWithImpl<$Res>
    implements $ActionPlanCopyWith<$Res> {
  _$ActionPlanCopyWithImpl(this._self, this._then);

  final ActionPlan _self;
  final $Res Function(ActionPlan) _then;

/// Create a copy of ActionPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? steps = null,Object? coachIntro = freezed,Object? cbtiPhase = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<ActionStep>,coachIntro: freezed == coachIntro ? _self.coachIntro : coachIntro // ignore: cast_nullable_to_non_nullable
as String?,cbtiPhase: freezed == cbtiPhase ? _self.cbtiPhase : cbtiPhase // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActionPlan].
extension ActionPlanPatterns on ActionPlan {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActionPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActionPlan() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActionPlan value)  $default,){
final _that = this;
switch (_that) {
case _ActionPlan():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActionPlan value)?  $default,){
final _that = this;
switch (_that) {
case _ActionPlan() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime date,  List<ActionStep> steps,  String? coachIntro,  String? cbtiPhase,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActionPlan() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.steps,_that.coachIntro,_that.cbtiPhase,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime date,  List<ActionStep> steps,  String? coachIntro,  String? cbtiPhase,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ActionPlan():
return $default(_that.id,_that.userId,_that.date,_that.steps,_that.coachIntro,_that.cbtiPhase,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  DateTime date,  List<ActionStep> steps,  String? coachIntro,  String? cbtiPhase,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ActionPlan() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.steps,_that.coachIntro,_that.cbtiPhase,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActionPlan implements ActionPlan {
  const _ActionPlan({required this.id, required this.userId, required this.date, required final  List<ActionStep> steps, this.coachIntro, this.cbtiPhase, this.createdAt}): _steps = steps;
  factory _ActionPlan.fromJson(Map<String, dynamic> json) => _$ActionPlanFromJson(json);

@override final  String id;
@override final  String userId;
@override final  DateTime date;
 final  List<ActionStep> _steps;
@override List<ActionStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override final  String? coachIntro;
// 1-2 sentence personalized intro
@override final  String? cbtiPhase;
// e.g. "Week 2: Sleep Restriction"
@override final  DateTime? createdAt;

/// Create a copy of ActionPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActionPlanCopyWith<_ActionPlan> get copyWith => __$ActionPlanCopyWithImpl<_ActionPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActionPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActionPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.coachIntro, coachIntro) || other.coachIntro == coachIntro)&&(identical(other.cbtiPhase, cbtiPhase) || other.cbtiPhase == cbtiPhase)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,const DeepCollectionEquality().hash(_steps),coachIntro,cbtiPhase,createdAt);

@override
String toString() {
  return 'ActionPlan(id: $id, userId: $userId, date: $date, steps: $steps, coachIntro: $coachIntro, cbtiPhase: $cbtiPhase, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ActionPlanCopyWith<$Res> implements $ActionPlanCopyWith<$Res> {
  factory _$ActionPlanCopyWith(_ActionPlan value, $Res Function(_ActionPlan) _then) = __$ActionPlanCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, DateTime date, List<ActionStep> steps, String? coachIntro, String? cbtiPhase, DateTime? createdAt
});




}
/// @nodoc
class __$ActionPlanCopyWithImpl<$Res>
    implements _$ActionPlanCopyWith<$Res> {
  __$ActionPlanCopyWithImpl(this._self, this._then);

  final _ActionPlan _self;
  final $Res Function(_ActionPlan) _then;

/// Create a copy of ActionPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? steps = null,Object? coachIntro = freezed,Object? cbtiPhase = freezed,Object? createdAt = freezed,}) {
  return _then(_ActionPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<ActionStep>,coachIntro: freezed == coachIntro ? _self.coachIntro : coachIntro // ignore: cast_nullable_to_non_nullable
as String?,cbtiPhase: freezed == cbtiPhase ? _self.cbtiPhase : cbtiPhase // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ActionStep {

 String get id; int get order; String get title; String get description; String get whyExplanation;// CBT-I rationale
 ActionCategory get category; bool get isCompleted; String? get targetTime;
/// Create a copy of ActionStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActionStepCopyWith<ActionStep> get copyWith => _$ActionStepCopyWithImpl<ActionStep>(this as ActionStep, _$identity);

  /// Serializes this ActionStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActionStep&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.whyExplanation, whyExplanation) || other.whyExplanation == whyExplanation)&&(identical(other.category, category) || other.category == category)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.targetTime, targetTime) || other.targetTime == targetTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,order,title,description,whyExplanation,category,isCompleted,targetTime);

@override
String toString() {
  return 'ActionStep(id: $id, order: $order, title: $title, description: $description, whyExplanation: $whyExplanation, category: $category, isCompleted: $isCompleted, targetTime: $targetTime)';
}


}

/// @nodoc
abstract mixin class $ActionStepCopyWith<$Res>  {
  factory $ActionStepCopyWith(ActionStep value, $Res Function(ActionStep) _then) = _$ActionStepCopyWithImpl;
@useResult
$Res call({
 String id, int order, String title, String description, String whyExplanation, ActionCategory category, bool isCompleted, String? targetTime
});




}
/// @nodoc
class _$ActionStepCopyWithImpl<$Res>
    implements $ActionStepCopyWith<$Res> {
  _$ActionStepCopyWithImpl(this._self, this._then);

  final ActionStep _self;
  final $Res Function(ActionStep) _then;

/// Create a copy of ActionStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? order = null,Object? title = null,Object? description = null,Object? whyExplanation = null,Object? category = null,Object? isCompleted = null,Object? targetTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,whyExplanation: null == whyExplanation ? _self.whyExplanation : whyExplanation // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ActionCategory,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,targetTime: freezed == targetTime ? _self.targetTime : targetTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActionStep].
extension ActionStepPatterns on ActionStep {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActionStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActionStep() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActionStep value)  $default,){
final _that = this;
switch (_that) {
case _ActionStep():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActionStep value)?  $default,){
final _that = this;
switch (_that) {
case _ActionStep() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int order,  String title,  String description,  String whyExplanation,  ActionCategory category,  bool isCompleted,  String? targetTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActionStep() when $default != null:
return $default(_that.id,_that.order,_that.title,_that.description,_that.whyExplanation,_that.category,_that.isCompleted,_that.targetTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int order,  String title,  String description,  String whyExplanation,  ActionCategory category,  bool isCompleted,  String? targetTime)  $default,) {final _that = this;
switch (_that) {
case _ActionStep():
return $default(_that.id,_that.order,_that.title,_that.description,_that.whyExplanation,_that.category,_that.isCompleted,_that.targetTime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int order,  String title,  String description,  String whyExplanation,  ActionCategory category,  bool isCompleted,  String? targetTime)?  $default,) {final _that = this;
switch (_that) {
case _ActionStep() when $default != null:
return $default(_that.id,_that.order,_that.title,_that.description,_that.whyExplanation,_that.category,_that.isCompleted,_that.targetTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActionStep implements ActionStep {
  const _ActionStep({required this.id, required this.order, required this.title, required this.description, required this.whyExplanation, required this.category, this.isCompleted = false, this.targetTime});
  factory _ActionStep.fromJson(Map<String, dynamic> json) => _$ActionStepFromJson(json);

@override final  String id;
@override final  int order;
@override final  String title;
@override final  String description;
@override final  String whyExplanation;
// CBT-I rationale
@override final  ActionCategory category;
@override@JsonKey() final  bool isCompleted;
@override final  String? targetTime;

/// Create a copy of ActionStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActionStepCopyWith<_ActionStep> get copyWith => __$ActionStepCopyWithImpl<_ActionStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActionStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActionStep&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.whyExplanation, whyExplanation) || other.whyExplanation == whyExplanation)&&(identical(other.category, category) || other.category == category)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.targetTime, targetTime) || other.targetTime == targetTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,order,title,description,whyExplanation,category,isCompleted,targetTime);

@override
String toString() {
  return 'ActionStep(id: $id, order: $order, title: $title, description: $description, whyExplanation: $whyExplanation, category: $category, isCompleted: $isCompleted, targetTime: $targetTime)';
}


}

/// @nodoc
abstract mixin class _$ActionStepCopyWith<$Res> implements $ActionStepCopyWith<$Res> {
  factory _$ActionStepCopyWith(_ActionStep value, $Res Function(_ActionStep) _then) = __$ActionStepCopyWithImpl;
@override @useResult
$Res call({
 String id, int order, String title, String description, String whyExplanation, ActionCategory category, bool isCompleted, String? targetTime
});




}
/// @nodoc
class __$ActionStepCopyWithImpl<$Res>
    implements _$ActionStepCopyWith<$Res> {
  __$ActionStepCopyWithImpl(this._self, this._then);

  final _ActionStep _self;
  final $Res Function(_ActionStep) _then;

/// Create a copy of ActionStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? order = null,Object? title = null,Object? description = null,Object? whyExplanation = null,Object? category = null,Object? isCompleted = null,Object? targetTime = freezed,}) {
  return _then(_ActionStep(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,whyExplanation: null == whyExplanation ? _self.whyExplanation : whyExplanation // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ActionCategory,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,targetTime: freezed == targetTime ? _self.targetTime : targetTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
