// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_check_in.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SleepCheckIn {

 String get id; String get userId; DateTime get date; DateTime get bedtime; DateTime get wakeTime; int get sleepLatencyMinutes;// minutes to fall asleep
 int get wakeEpisodes;// number of wake-ups
 int get moodRating;// 1-5 (1=terrible, 5=great)
 int? get sleepScore;// 0-100 calculated by backend
 double? get sleepEfficiency;// percentage
 int? get totalSleepMinutes; int? get timeInBedMinutes; String? get coachInsight;// AI-generated insight
 bool? get isWearableData;// true if imported from health kit
 DateTime? get createdAt;
/// Create a copy of SleepCheckIn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SleepCheckInCopyWith<SleepCheckIn> get copyWith => _$SleepCheckInCopyWithImpl<SleepCheckIn>(this as SleepCheckIn, _$identity);

  /// Serializes this SleepCheckIn to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SleepCheckIn&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&(identical(other.bedtime, bedtime) || other.bedtime == bedtime)&&(identical(other.wakeTime, wakeTime) || other.wakeTime == wakeTime)&&(identical(other.sleepLatencyMinutes, sleepLatencyMinutes) || other.sleepLatencyMinutes == sleepLatencyMinutes)&&(identical(other.wakeEpisodes, wakeEpisodes) || other.wakeEpisodes == wakeEpisodes)&&(identical(other.moodRating, moodRating) || other.moodRating == moodRating)&&(identical(other.sleepScore, sleepScore) || other.sleepScore == sleepScore)&&(identical(other.sleepEfficiency, sleepEfficiency) || other.sleepEfficiency == sleepEfficiency)&&(identical(other.totalSleepMinutes, totalSleepMinutes) || other.totalSleepMinutes == totalSleepMinutes)&&(identical(other.timeInBedMinutes, timeInBedMinutes) || other.timeInBedMinutes == timeInBedMinutes)&&(identical(other.coachInsight, coachInsight) || other.coachInsight == coachInsight)&&(identical(other.isWearableData, isWearableData) || other.isWearableData == isWearableData)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,bedtime,wakeTime,sleepLatencyMinutes,wakeEpisodes,moodRating,sleepScore,sleepEfficiency,totalSleepMinutes,timeInBedMinutes,coachInsight,isWearableData,createdAt);

@override
String toString() {
  return 'SleepCheckIn(id: $id, userId: $userId, date: $date, bedtime: $bedtime, wakeTime: $wakeTime, sleepLatencyMinutes: $sleepLatencyMinutes, wakeEpisodes: $wakeEpisodes, moodRating: $moodRating, sleepScore: $sleepScore, sleepEfficiency: $sleepEfficiency, totalSleepMinutes: $totalSleepMinutes, timeInBedMinutes: $timeInBedMinutes, coachInsight: $coachInsight, isWearableData: $isWearableData, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SleepCheckInCopyWith<$Res>  {
  factory $SleepCheckInCopyWith(SleepCheckIn value, $Res Function(SleepCheckIn) _then) = _$SleepCheckInCopyWithImpl;
@useResult
$Res call({
 String id, String userId, DateTime date, DateTime bedtime, DateTime wakeTime, int sleepLatencyMinutes, int wakeEpisodes, int moodRating, int? sleepScore, double? sleepEfficiency, int? totalSleepMinutes, int? timeInBedMinutes, String? coachInsight, bool? isWearableData, DateTime? createdAt
});




}
/// @nodoc
class _$SleepCheckInCopyWithImpl<$Res>
    implements $SleepCheckInCopyWith<$Res> {
  _$SleepCheckInCopyWithImpl(this._self, this._then);

  final SleepCheckIn _self;
  final $Res Function(SleepCheckIn) _then;

/// Create a copy of SleepCheckIn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? bedtime = null,Object? wakeTime = null,Object? sleepLatencyMinutes = null,Object? wakeEpisodes = null,Object? moodRating = null,Object? sleepScore = freezed,Object? sleepEfficiency = freezed,Object? totalSleepMinutes = freezed,Object? timeInBedMinutes = freezed,Object? coachInsight = freezed,Object? isWearableData = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,bedtime: null == bedtime ? _self.bedtime : bedtime // ignore: cast_nullable_to_non_nullable
as DateTime,wakeTime: null == wakeTime ? _self.wakeTime : wakeTime // ignore: cast_nullable_to_non_nullable
as DateTime,sleepLatencyMinutes: null == sleepLatencyMinutes ? _self.sleepLatencyMinutes : sleepLatencyMinutes // ignore: cast_nullable_to_non_nullable
as int,wakeEpisodes: null == wakeEpisodes ? _self.wakeEpisodes : wakeEpisodes // ignore: cast_nullable_to_non_nullable
as int,moodRating: null == moodRating ? _self.moodRating : moodRating // ignore: cast_nullable_to_non_nullable
as int,sleepScore: freezed == sleepScore ? _self.sleepScore : sleepScore // ignore: cast_nullable_to_non_nullable
as int?,sleepEfficiency: freezed == sleepEfficiency ? _self.sleepEfficiency : sleepEfficiency // ignore: cast_nullable_to_non_nullable
as double?,totalSleepMinutes: freezed == totalSleepMinutes ? _self.totalSleepMinutes : totalSleepMinutes // ignore: cast_nullable_to_non_nullable
as int?,timeInBedMinutes: freezed == timeInBedMinutes ? _self.timeInBedMinutes : timeInBedMinutes // ignore: cast_nullable_to_non_nullable
as int?,coachInsight: freezed == coachInsight ? _self.coachInsight : coachInsight // ignore: cast_nullable_to_non_nullable
as String?,isWearableData: freezed == isWearableData ? _self.isWearableData : isWearableData // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SleepCheckIn].
extension SleepCheckInPatterns on SleepCheckIn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SleepCheckIn value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SleepCheckIn() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SleepCheckIn value)  $default,){
final _that = this;
switch (_that) {
case _SleepCheckIn():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SleepCheckIn value)?  $default,){
final _that = this;
switch (_that) {
case _SleepCheckIn() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime date,  DateTime bedtime,  DateTime wakeTime,  int sleepLatencyMinutes,  int wakeEpisodes,  int moodRating,  int? sleepScore,  double? sleepEfficiency,  int? totalSleepMinutes,  int? timeInBedMinutes,  String? coachInsight,  bool? isWearableData,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SleepCheckIn() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.bedtime,_that.wakeTime,_that.sleepLatencyMinutes,_that.wakeEpisodes,_that.moodRating,_that.sleepScore,_that.sleepEfficiency,_that.totalSleepMinutes,_that.timeInBedMinutes,_that.coachInsight,_that.isWearableData,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime date,  DateTime bedtime,  DateTime wakeTime,  int sleepLatencyMinutes,  int wakeEpisodes,  int moodRating,  int? sleepScore,  double? sleepEfficiency,  int? totalSleepMinutes,  int? timeInBedMinutes,  String? coachInsight,  bool? isWearableData,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _SleepCheckIn():
return $default(_that.id,_that.userId,_that.date,_that.bedtime,_that.wakeTime,_that.sleepLatencyMinutes,_that.wakeEpisodes,_that.moodRating,_that.sleepScore,_that.sleepEfficiency,_that.totalSleepMinutes,_that.timeInBedMinutes,_that.coachInsight,_that.isWearableData,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  DateTime date,  DateTime bedtime,  DateTime wakeTime,  int sleepLatencyMinutes,  int wakeEpisodes,  int moodRating,  int? sleepScore,  double? sleepEfficiency,  int? totalSleepMinutes,  int? timeInBedMinutes,  String? coachInsight,  bool? isWearableData,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SleepCheckIn() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.bedtime,_that.wakeTime,_that.sleepLatencyMinutes,_that.wakeEpisodes,_that.moodRating,_that.sleepScore,_that.sleepEfficiency,_that.totalSleepMinutes,_that.timeInBedMinutes,_that.coachInsight,_that.isWearableData,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SleepCheckIn implements SleepCheckIn {
  const _SleepCheckIn({required this.id, required this.userId, required this.date, required this.bedtime, required this.wakeTime, required this.sleepLatencyMinutes, required this.wakeEpisodes, required this.moodRating, this.sleepScore, this.sleepEfficiency, this.totalSleepMinutes, this.timeInBedMinutes, this.coachInsight, this.isWearableData, this.createdAt});
  factory _SleepCheckIn.fromJson(Map<String, dynamic> json) => _$SleepCheckInFromJson(json);

@override final  String id;
@override final  String userId;
@override final  DateTime date;
@override final  DateTime bedtime;
@override final  DateTime wakeTime;
@override final  int sleepLatencyMinutes;
// minutes to fall asleep
@override final  int wakeEpisodes;
// number of wake-ups
@override final  int moodRating;
// 1-5 (1=terrible, 5=great)
@override final  int? sleepScore;
// 0-100 calculated by backend
@override final  double? sleepEfficiency;
// percentage
@override final  int? totalSleepMinutes;
@override final  int? timeInBedMinutes;
@override final  String? coachInsight;
// AI-generated insight
@override final  bool? isWearableData;
// true if imported from health kit
@override final  DateTime? createdAt;

/// Create a copy of SleepCheckIn
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SleepCheckInCopyWith<_SleepCheckIn> get copyWith => __$SleepCheckInCopyWithImpl<_SleepCheckIn>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SleepCheckInToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SleepCheckIn&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&(identical(other.bedtime, bedtime) || other.bedtime == bedtime)&&(identical(other.wakeTime, wakeTime) || other.wakeTime == wakeTime)&&(identical(other.sleepLatencyMinutes, sleepLatencyMinutes) || other.sleepLatencyMinutes == sleepLatencyMinutes)&&(identical(other.wakeEpisodes, wakeEpisodes) || other.wakeEpisodes == wakeEpisodes)&&(identical(other.moodRating, moodRating) || other.moodRating == moodRating)&&(identical(other.sleepScore, sleepScore) || other.sleepScore == sleepScore)&&(identical(other.sleepEfficiency, sleepEfficiency) || other.sleepEfficiency == sleepEfficiency)&&(identical(other.totalSleepMinutes, totalSleepMinutes) || other.totalSleepMinutes == totalSleepMinutes)&&(identical(other.timeInBedMinutes, timeInBedMinutes) || other.timeInBedMinutes == timeInBedMinutes)&&(identical(other.coachInsight, coachInsight) || other.coachInsight == coachInsight)&&(identical(other.isWearableData, isWearableData) || other.isWearableData == isWearableData)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,bedtime,wakeTime,sleepLatencyMinutes,wakeEpisodes,moodRating,sleepScore,sleepEfficiency,totalSleepMinutes,timeInBedMinutes,coachInsight,isWearableData,createdAt);

@override
String toString() {
  return 'SleepCheckIn(id: $id, userId: $userId, date: $date, bedtime: $bedtime, wakeTime: $wakeTime, sleepLatencyMinutes: $sleepLatencyMinutes, wakeEpisodes: $wakeEpisodes, moodRating: $moodRating, sleepScore: $sleepScore, sleepEfficiency: $sleepEfficiency, totalSleepMinutes: $totalSleepMinutes, timeInBedMinutes: $timeInBedMinutes, coachInsight: $coachInsight, isWearableData: $isWearableData, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SleepCheckInCopyWith<$Res> implements $SleepCheckInCopyWith<$Res> {
  factory _$SleepCheckInCopyWith(_SleepCheckIn value, $Res Function(_SleepCheckIn) _then) = __$SleepCheckInCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, DateTime date, DateTime bedtime, DateTime wakeTime, int sleepLatencyMinutes, int wakeEpisodes, int moodRating, int? sleepScore, double? sleepEfficiency, int? totalSleepMinutes, int? timeInBedMinutes, String? coachInsight, bool? isWearableData, DateTime? createdAt
});




}
/// @nodoc
class __$SleepCheckInCopyWithImpl<$Res>
    implements _$SleepCheckInCopyWith<$Res> {
  __$SleepCheckInCopyWithImpl(this._self, this._then);

  final _SleepCheckIn _self;
  final $Res Function(_SleepCheckIn) _then;

/// Create a copy of SleepCheckIn
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? bedtime = null,Object? wakeTime = null,Object? sleepLatencyMinutes = null,Object? wakeEpisodes = null,Object? moodRating = null,Object? sleepScore = freezed,Object? sleepEfficiency = freezed,Object? totalSleepMinutes = freezed,Object? timeInBedMinutes = freezed,Object? coachInsight = freezed,Object? isWearableData = freezed,Object? createdAt = freezed,}) {
  return _then(_SleepCheckIn(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,bedtime: null == bedtime ? _self.bedtime : bedtime // ignore: cast_nullable_to_non_nullable
as DateTime,wakeTime: null == wakeTime ? _self.wakeTime : wakeTime // ignore: cast_nullable_to_non_nullable
as DateTime,sleepLatencyMinutes: null == sleepLatencyMinutes ? _self.sleepLatencyMinutes : sleepLatencyMinutes // ignore: cast_nullable_to_non_nullable
as int,wakeEpisodes: null == wakeEpisodes ? _self.wakeEpisodes : wakeEpisodes // ignore: cast_nullable_to_non_nullable
as int,moodRating: null == moodRating ? _self.moodRating : moodRating // ignore: cast_nullable_to_non_nullable
as int,sleepScore: freezed == sleepScore ? _self.sleepScore : sleepScore // ignore: cast_nullable_to_non_nullable
as int?,sleepEfficiency: freezed == sleepEfficiency ? _self.sleepEfficiency : sleepEfficiency // ignore: cast_nullable_to_non_nullable
as double?,totalSleepMinutes: freezed == totalSleepMinutes ? _self.totalSleepMinutes : totalSleepMinutes // ignore: cast_nullable_to_non_nullable
as int?,timeInBedMinutes: freezed == timeInBedMinutes ? _self.timeInBedMinutes : timeInBedMinutes // ignore: cast_nullable_to_non_nullable
as int?,coachInsight: freezed == coachInsight ? _self.coachInsight : coachInsight // ignore: cast_nullable_to_non_nullable
as String?,isWearableData: freezed == isWearableData ? _self.isWearableData : isWearableData // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
