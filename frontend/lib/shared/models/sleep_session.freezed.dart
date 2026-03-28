// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SleepPhaseEvent {

 SleepPhase get phase; DateTime get startTime; DateTime? get endTime;
/// Create a copy of SleepPhaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SleepPhaseEventCopyWith<SleepPhaseEvent> get copyWith => _$SleepPhaseEventCopyWithImpl<SleepPhaseEvent>(this as SleepPhaseEvent, _$identity);

  /// Serializes this SleepPhaseEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SleepPhaseEvent&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phase,startTime,endTime);

@override
String toString() {
  return 'SleepPhaseEvent(phase: $phase, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $SleepPhaseEventCopyWith<$Res>  {
  factory $SleepPhaseEventCopyWith(SleepPhaseEvent value, $Res Function(SleepPhaseEvent) _then) = _$SleepPhaseEventCopyWithImpl;
@useResult
$Res call({
 SleepPhase phase, DateTime startTime, DateTime? endTime
});




}
/// @nodoc
class _$SleepPhaseEventCopyWithImpl<$Res>
    implements $SleepPhaseEventCopyWith<$Res> {
  _$SleepPhaseEventCopyWithImpl(this._self, this._then);

  final SleepPhaseEvent _self;
  final $Res Function(SleepPhaseEvent) _then;

/// Create a copy of SleepPhaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? startTime = null,Object? endTime = freezed,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SleepPhase,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SleepPhaseEvent].
extension SleepPhaseEventPatterns on SleepPhaseEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SleepPhaseEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SleepPhaseEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SleepPhaseEvent value)  $default,){
final _that = this;
switch (_that) {
case _SleepPhaseEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SleepPhaseEvent value)?  $default,){
final _that = this;
switch (_that) {
case _SleepPhaseEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SleepPhase phase,  DateTime startTime,  DateTime? endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SleepPhaseEvent() when $default != null:
return $default(_that.phase,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SleepPhase phase,  DateTime startTime,  DateTime? endTime)  $default,) {final _that = this;
switch (_that) {
case _SleepPhaseEvent():
return $default(_that.phase,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SleepPhase phase,  DateTime startTime,  DateTime? endTime)?  $default,) {final _that = this;
switch (_that) {
case _SleepPhaseEvent() when $default != null:
return $default(_that.phase,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SleepPhaseEvent implements SleepPhaseEvent {
  const _SleepPhaseEvent({required this.phase, required this.startTime, this.endTime});
  factory _SleepPhaseEvent.fromJson(Map<String, dynamic> json) => _$SleepPhaseEventFromJson(json);

@override final  SleepPhase phase;
@override final  DateTime startTime;
@override final  DateTime? endTime;

/// Create a copy of SleepPhaseEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SleepPhaseEventCopyWith<_SleepPhaseEvent> get copyWith => __$SleepPhaseEventCopyWithImpl<_SleepPhaseEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SleepPhaseEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SleepPhaseEvent&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phase,startTime,endTime);

@override
String toString() {
  return 'SleepPhaseEvent(phase: $phase, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$SleepPhaseEventCopyWith<$Res> implements $SleepPhaseEventCopyWith<$Res> {
  factory _$SleepPhaseEventCopyWith(_SleepPhaseEvent value, $Res Function(_SleepPhaseEvent) _then) = __$SleepPhaseEventCopyWithImpl;
@override @useResult
$Res call({
 SleepPhase phase, DateTime startTime, DateTime? endTime
});




}
/// @nodoc
class __$SleepPhaseEventCopyWithImpl<$Res>
    implements _$SleepPhaseEventCopyWith<$Res> {
  __$SleepPhaseEventCopyWithImpl(this._self, this._then);

  final _SleepPhaseEvent _self;
  final $Res Function(_SleepPhaseEvent) _then;

/// Create a copy of SleepPhaseEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? startTime = null,Object? endTime = freezed,}) {
  return _then(_SleepPhaseEvent(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SleepPhase,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$SmartAlarmConfig {

 DateTime get targetWakeTime; int get windowMinutes;// wake window before targetWakeTime
 bool get enabled;
/// Create a copy of SmartAlarmConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmartAlarmConfigCopyWith<SmartAlarmConfig> get copyWith => _$SmartAlarmConfigCopyWithImpl<SmartAlarmConfig>(this as SmartAlarmConfig, _$identity);

  /// Serializes this SmartAlarmConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmartAlarmConfig&&(identical(other.targetWakeTime, targetWakeTime) || other.targetWakeTime == targetWakeTime)&&(identical(other.windowMinutes, windowMinutes) || other.windowMinutes == windowMinutes)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetWakeTime,windowMinutes,enabled);

@override
String toString() {
  return 'SmartAlarmConfig(targetWakeTime: $targetWakeTime, windowMinutes: $windowMinutes, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $SmartAlarmConfigCopyWith<$Res>  {
  factory $SmartAlarmConfigCopyWith(SmartAlarmConfig value, $Res Function(SmartAlarmConfig) _then) = _$SmartAlarmConfigCopyWithImpl;
@useResult
$Res call({
 DateTime targetWakeTime, int windowMinutes, bool enabled
});




}
/// @nodoc
class _$SmartAlarmConfigCopyWithImpl<$Res>
    implements $SmartAlarmConfigCopyWith<$Res> {
  _$SmartAlarmConfigCopyWithImpl(this._self, this._then);

  final SmartAlarmConfig _self;
  final $Res Function(SmartAlarmConfig) _then;

/// Create a copy of SmartAlarmConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetWakeTime = null,Object? windowMinutes = null,Object? enabled = null,}) {
  return _then(_self.copyWith(
targetWakeTime: null == targetWakeTime ? _self.targetWakeTime : targetWakeTime // ignore: cast_nullable_to_non_nullable
as DateTime,windowMinutes: null == windowMinutes ? _self.windowMinutes : windowMinutes // ignore: cast_nullable_to_non_nullable
as int,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SmartAlarmConfig].
extension SmartAlarmConfigPatterns on SmartAlarmConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SmartAlarmConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SmartAlarmConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SmartAlarmConfig value)  $default,){
final _that = this;
switch (_that) {
case _SmartAlarmConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SmartAlarmConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SmartAlarmConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime targetWakeTime,  int windowMinutes,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SmartAlarmConfig() when $default != null:
return $default(_that.targetWakeTime,_that.windowMinutes,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime targetWakeTime,  int windowMinutes,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _SmartAlarmConfig():
return $default(_that.targetWakeTime,_that.windowMinutes,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime targetWakeTime,  int windowMinutes,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _SmartAlarmConfig() when $default != null:
return $default(_that.targetWakeTime,_that.windowMinutes,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SmartAlarmConfig implements SmartAlarmConfig {
  const _SmartAlarmConfig({required this.targetWakeTime, this.windowMinutes = 30, this.enabled = true});
  factory _SmartAlarmConfig.fromJson(Map<String, dynamic> json) => _$SmartAlarmConfigFromJson(json);

@override final  DateTime targetWakeTime;
@override@JsonKey() final  int windowMinutes;
// wake window before targetWakeTime
@override@JsonKey() final  bool enabled;

/// Create a copy of SmartAlarmConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SmartAlarmConfigCopyWith<_SmartAlarmConfig> get copyWith => __$SmartAlarmConfigCopyWithImpl<_SmartAlarmConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SmartAlarmConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SmartAlarmConfig&&(identical(other.targetWakeTime, targetWakeTime) || other.targetWakeTime == targetWakeTime)&&(identical(other.windowMinutes, windowMinutes) || other.windowMinutes == windowMinutes)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetWakeTime,windowMinutes,enabled);

@override
String toString() {
  return 'SmartAlarmConfig(targetWakeTime: $targetWakeTime, windowMinutes: $windowMinutes, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$SmartAlarmConfigCopyWith<$Res> implements $SmartAlarmConfigCopyWith<$Res> {
  factory _$SmartAlarmConfigCopyWith(_SmartAlarmConfig value, $Res Function(_SmartAlarmConfig) _then) = __$SmartAlarmConfigCopyWithImpl;
@override @useResult
$Res call({
 DateTime targetWakeTime, int windowMinutes, bool enabled
});




}
/// @nodoc
class __$SmartAlarmConfigCopyWithImpl<$Res>
    implements _$SmartAlarmConfigCopyWith<$Res> {
  __$SmartAlarmConfigCopyWithImpl(this._self, this._then);

  final _SmartAlarmConfig _self;
  final $Res Function(_SmartAlarmConfig) _then;

/// Create a copy of SmartAlarmConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetWakeTime = null,Object? windowMinutes = null,Object? enabled = null,}) {
  return _then(_SmartAlarmConfig(
targetWakeTime: null == targetWakeTime ? _self.targetWakeTime : targetWakeTime // ignore: cast_nullable_to_non_nullable
as DateTime,windowMinutes: null == windowMinutes ? _self.windowMinutes : windowMinutes // ignore: cast_nullable_to_non_nullable
as int,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SleepSession {

 String get id; String get userId; DateTime get startTime; DateTime? get endTime; List<SleepPhaseEvent> get phases; SmartAlarmConfig? get smartAlarm; SleepSessionStatus get status; bool get isWearableSession;// Post-session summary
 int? get totalSleepMinutes; int? get remMinutes; int? get deepMinutes; int? get lightMinutes; int? get awakeMinutes; SleepPhase? get currentPhase; DateTime? get createdAt;
/// Create a copy of SleepSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SleepSessionCopyWith<SleepSession> get copyWith => _$SleepSessionCopyWithImpl<SleepSession>(this as SleepSession, _$identity);

  /// Serializes this SleepSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SleepSession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other.phases, phases)&&(identical(other.smartAlarm, smartAlarm) || other.smartAlarm == smartAlarm)&&(identical(other.status, status) || other.status == status)&&(identical(other.isWearableSession, isWearableSession) || other.isWearableSession == isWearableSession)&&(identical(other.totalSleepMinutes, totalSleepMinutes) || other.totalSleepMinutes == totalSleepMinutes)&&(identical(other.remMinutes, remMinutes) || other.remMinutes == remMinutes)&&(identical(other.deepMinutes, deepMinutes) || other.deepMinutes == deepMinutes)&&(identical(other.lightMinutes, lightMinutes) || other.lightMinutes == lightMinutes)&&(identical(other.awakeMinutes, awakeMinutes) || other.awakeMinutes == awakeMinutes)&&(identical(other.currentPhase, currentPhase) || other.currentPhase == currentPhase)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,startTime,endTime,const DeepCollectionEquality().hash(phases),smartAlarm,status,isWearableSession,totalSleepMinutes,remMinutes,deepMinutes,lightMinutes,awakeMinutes,currentPhase,createdAt);

@override
String toString() {
  return 'SleepSession(id: $id, userId: $userId, startTime: $startTime, endTime: $endTime, phases: $phases, smartAlarm: $smartAlarm, status: $status, isWearableSession: $isWearableSession, totalSleepMinutes: $totalSleepMinutes, remMinutes: $remMinutes, deepMinutes: $deepMinutes, lightMinutes: $lightMinutes, awakeMinutes: $awakeMinutes, currentPhase: $currentPhase, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SleepSessionCopyWith<$Res>  {
  factory $SleepSessionCopyWith(SleepSession value, $Res Function(SleepSession) _then) = _$SleepSessionCopyWithImpl;
@useResult
$Res call({
 String id, String userId, DateTime startTime, DateTime? endTime, List<SleepPhaseEvent> phases, SmartAlarmConfig? smartAlarm, SleepSessionStatus status, bool isWearableSession, int? totalSleepMinutes, int? remMinutes, int? deepMinutes, int? lightMinutes, int? awakeMinutes, SleepPhase? currentPhase, DateTime? createdAt
});


$SmartAlarmConfigCopyWith<$Res>? get smartAlarm;

}
/// @nodoc
class _$SleepSessionCopyWithImpl<$Res>
    implements $SleepSessionCopyWith<$Res> {
  _$SleepSessionCopyWithImpl(this._self, this._then);

  final SleepSession _self;
  final $Res Function(SleepSession) _then;

/// Create a copy of SleepSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? startTime = null,Object? endTime = freezed,Object? phases = null,Object? smartAlarm = freezed,Object? status = null,Object? isWearableSession = null,Object? totalSleepMinutes = freezed,Object? remMinutes = freezed,Object? deepMinutes = freezed,Object? lightMinutes = freezed,Object? awakeMinutes = freezed,Object? currentPhase = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,phases: null == phases ? _self.phases : phases // ignore: cast_nullable_to_non_nullable
as List<SleepPhaseEvent>,smartAlarm: freezed == smartAlarm ? _self.smartAlarm : smartAlarm // ignore: cast_nullable_to_non_nullable
as SmartAlarmConfig?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SleepSessionStatus,isWearableSession: null == isWearableSession ? _self.isWearableSession : isWearableSession // ignore: cast_nullable_to_non_nullable
as bool,totalSleepMinutes: freezed == totalSleepMinutes ? _self.totalSleepMinutes : totalSleepMinutes // ignore: cast_nullable_to_non_nullable
as int?,remMinutes: freezed == remMinutes ? _self.remMinutes : remMinutes // ignore: cast_nullable_to_non_nullable
as int?,deepMinutes: freezed == deepMinutes ? _self.deepMinutes : deepMinutes // ignore: cast_nullable_to_non_nullable
as int?,lightMinutes: freezed == lightMinutes ? _self.lightMinutes : lightMinutes // ignore: cast_nullable_to_non_nullable
as int?,awakeMinutes: freezed == awakeMinutes ? _self.awakeMinutes : awakeMinutes // ignore: cast_nullable_to_non_nullable
as int?,currentPhase: freezed == currentPhase ? _self.currentPhase : currentPhase // ignore: cast_nullable_to_non_nullable
as SleepPhase?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SleepSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SmartAlarmConfigCopyWith<$Res>? get smartAlarm {
    if (_self.smartAlarm == null) {
    return null;
  }

  return $SmartAlarmConfigCopyWith<$Res>(_self.smartAlarm!, (value) {
    return _then(_self.copyWith(smartAlarm: value));
  });
}
}


/// Adds pattern-matching-related methods to [SleepSession].
extension SleepSessionPatterns on SleepSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SleepSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SleepSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SleepSession value)  $default,){
final _that = this;
switch (_that) {
case _SleepSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SleepSession value)?  $default,){
final _that = this;
switch (_that) {
case _SleepSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime startTime,  DateTime? endTime,  List<SleepPhaseEvent> phases,  SmartAlarmConfig? smartAlarm,  SleepSessionStatus status,  bool isWearableSession,  int? totalSleepMinutes,  int? remMinutes,  int? deepMinutes,  int? lightMinutes,  int? awakeMinutes,  SleepPhase? currentPhase,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SleepSession() when $default != null:
return $default(_that.id,_that.userId,_that.startTime,_that.endTime,_that.phases,_that.smartAlarm,_that.status,_that.isWearableSession,_that.totalSleepMinutes,_that.remMinutes,_that.deepMinutes,_that.lightMinutes,_that.awakeMinutes,_that.currentPhase,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime startTime,  DateTime? endTime,  List<SleepPhaseEvent> phases,  SmartAlarmConfig? smartAlarm,  SleepSessionStatus status,  bool isWearableSession,  int? totalSleepMinutes,  int? remMinutes,  int? deepMinutes,  int? lightMinutes,  int? awakeMinutes,  SleepPhase? currentPhase,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _SleepSession():
return $default(_that.id,_that.userId,_that.startTime,_that.endTime,_that.phases,_that.smartAlarm,_that.status,_that.isWearableSession,_that.totalSleepMinutes,_that.remMinutes,_that.deepMinutes,_that.lightMinutes,_that.awakeMinutes,_that.currentPhase,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  DateTime startTime,  DateTime? endTime,  List<SleepPhaseEvent> phases,  SmartAlarmConfig? smartAlarm,  SleepSessionStatus status,  bool isWearableSession,  int? totalSleepMinutes,  int? remMinutes,  int? deepMinutes,  int? lightMinutes,  int? awakeMinutes,  SleepPhase? currentPhase,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SleepSession() when $default != null:
return $default(_that.id,_that.userId,_that.startTime,_that.endTime,_that.phases,_that.smartAlarm,_that.status,_that.isWearableSession,_that.totalSleepMinutes,_that.remMinutes,_that.deepMinutes,_that.lightMinutes,_that.awakeMinutes,_that.currentPhase,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SleepSession implements SleepSession {
  const _SleepSession({required this.id, required this.userId, required this.startTime, this.endTime, final  List<SleepPhaseEvent> phases = const [], this.smartAlarm, this.status = SleepSessionStatus.active, this.isWearableSession = false, this.totalSleepMinutes, this.remMinutes, this.deepMinutes, this.lightMinutes, this.awakeMinutes, this.currentPhase, this.createdAt}): _phases = phases;
  factory _SleepSession.fromJson(Map<String, dynamic> json) => _$SleepSessionFromJson(json);

@override final  String id;
@override final  String userId;
@override final  DateTime startTime;
@override final  DateTime? endTime;
 final  List<SleepPhaseEvent> _phases;
@override@JsonKey() List<SleepPhaseEvent> get phases {
  if (_phases is EqualUnmodifiableListView) return _phases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_phases);
}

@override final  SmartAlarmConfig? smartAlarm;
@override@JsonKey() final  SleepSessionStatus status;
@override@JsonKey() final  bool isWearableSession;
// Post-session summary
@override final  int? totalSleepMinutes;
@override final  int? remMinutes;
@override final  int? deepMinutes;
@override final  int? lightMinutes;
@override final  int? awakeMinutes;
@override final  SleepPhase? currentPhase;
@override final  DateTime? createdAt;

/// Create a copy of SleepSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SleepSessionCopyWith<_SleepSession> get copyWith => __$SleepSessionCopyWithImpl<_SleepSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SleepSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SleepSession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other._phases, _phases)&&(identical(other.smartAlarm, smartAlarm) || other.smartAlarm == smartAlarm)&&(identical(other.status, status) || other.status == status)&&(identical(other.isWearableSession, isWearableSession) || other.isWearableSession == isWearableSession)&&(identical(other.totalSleepMinutes, totalSleepMinutes) || other.totalSleepMinutes == totalSleepMinutes)&&(identical(other.remMinutes, remMinutes) || other.remMinutes == remMinutes)&&(identical(other.deepMinutes, deepMinutes) || other.deepMinutes == deepMinutes)&&(identical(other.lightMinutes, lightMinutes) || other.lightMinutes == lightMinutes)&&(identical(other.awakeMinutes, awakeMinutes) || other.awakeMinutes == awakeMinutes)&&(identical(other.currentPhase, currentPhase) || other.currentPhase == currentPhase)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,startTime,endTime,const DeepCollectionEquality().hash(_phases),smartAlarm,status,isWearableSession,totalSleepMinutes,remMinutes,deepMinutes,lightMinutes,awakeMinutes,currentPhase,createdAt);

@override
String toString() {
  return 'SleepSession(id: $id, userId: $userId, startTime: $startTime, endTime: $endTime, phases: $phases, smartAlarm: $smartAlarm, status: $status, isWearableSession: $isWearableSession, totalSleepMinutes: $totalSleepMinutes, remMinutes: $remMinutes, deepMinutes: $deepMinutes, lightMinutes: $lightMinutes, awakeMinutes: $awakeMinutes, currentPhase: $currentPhase, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SleepSessionCopyWith<$Res> implements $SleepSessionCopyWith<$Res> {
  factory _$SleepSessionCopyWith(_SleepSession value, $Res Function(_SleepSession) _then) = __$SleepSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, DateTime startTime, DateTime? endTime, List<SleepPhaseEvent> phases, SmartAlarmConfig? smartAlarm, SleepSessionStatus status, bool isWearableSession, int? totalSleepMinutes, int? remMinutes, int? deepMinutes, int? lightMinutes, int? awakeMinutes, SleepPhase? currentPhase, DateTime? createdAt
});


@override $SmartAlarmConfigCopyWith<$Res>? get smartAlarm;

}
/// @nodoc
class __$SleepSessionCopyWithImpl<$Res>
    implements _$SleepSessionCopyWith<$Res> {
  __$SleepSessionCopyWithImpl(this._self, this._then);

  final _SleepSession _self;
  final $Res Function(_SleepSession) _then;

/// Create a copy of SleepSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? startTime = null,Object? endTime = freezed,Object? phases = null,Object? smartAlarm = freezed,Object? status = null,Object? isWearableSession = null,Object? totalSleepMinutes = freezed,Object? remMinutes = freezed,Object? deepMinutes = freezed,Object? lightMinutes = freezed,Object? awakeMinutes = freezed,Object? currentPhase = freezed,Object? createdAt = freezed,}) {
  return _then(_SleepSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,phases: null == phases ? _self._phases : phases // ignore: cast_nullable_to_non_nullable
as List<SleepPhaseEvent>,smartAlarm: freezed == smartAlarm ? _self.smartAlarm : smartAlarm // ignore: cast_nullable_to_non_nullable
as SmartAlarmConfig?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SleepSessionStatus,isWearableSession: null == isWearableSession ? _self.isWearableSession : isWearableSession // ignore: cast_nullable_to_non_nullable
as bool,totalSleepMinutes: freezed == totalSleepMinutes ? _self.totalSleepMinutes : totalSleepMinutes // ignore: cast_nullable_to_non_nullable
as int?,remMinutes: freezed == remMinutes ? _self.remMinutes : remMinutes // ignore: cast_nullable_to_non_nullable
as int?,deepMinutes: freezed == deepMinutes ? _self.deepMinutes : deepMinutes // ignore: cast_nullable_to_non_nullable
as int?,lightMinutes: freezed == lightMinutes ? _self.lightMinutes : lightMinutes // ignore: cast_nullable_to_non_nullable
as int?,awakeMinutes: freezed == awakeMinutes ? _self.awakeMinutes : awakeMinutes // ignore: cast_nullable_to_non_nullable
as int?,currentPhase: freezed == currentPhase ? _self.currentPhase : currentPhase // ignore: cast_nullable_to_non_nullable
as SleepPhase?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SleepSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SmartAlarmConfigCopyWith<$Res>? get smartAlarm {
    if (_self.smartAlarm == null) {
    return null;
  }

  return $SmartAlarmConfigCopyWith<$Res>(_self.smartAlarm!, (value) {
    return _then(_self.copyWith(smartAlarm: value));
  });
}
}

// dart format on
