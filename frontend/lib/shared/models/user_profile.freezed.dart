// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 String get id; String get email; String? get displayName; String? get avatarUrl; String get subscriptionTier; String get preferredLanguage; bool get analyticsConsent; bool get isEuUser;// Sleep preferences
 int? get targetBedtimeHour;// 0-23
 int? get targetBedtimeMinute;// 0-59
 int? get targetWakeHour; int? get targetWakeMinute; int? get targetSleepMinutes;// desired total sleep duration
// CBT-I program
 int? get cbtiWeek;// current week in 8-week program
 DateTime? get programStartDate;// Wearables
 bool get appleHealthEnabled; bool get googleFitEnabled;// Streaks
 int get currentStreak; int get longestStreak; DateTime? get lastCheckInDate; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.subscriptionTier, subscriptionTier) || other.subscriptionTier == subscriptionTier)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.analyticsConsent, analyticsConsent) || other.analyticsConsent == analyticsConsent)&&(identical(other.isEuUser, isEuUser) || other.isEuUser == isEuUser)&&(identical(other.targetBedtimeHour, targetBedtimeHour) || other.targetBedtimeHour == targetBedtimeHour)&&(identical(other.targetBedtimeMinute, targetBedtimeMinute) || other.targetBedtimeMinute == targetBedtimeMinute)&&(identical(other.targetWakeHour, targetWakeHour) || other.targetWakeHour == targetWakeHour)&&(identical(other.targetWakeMinute, targetWakeMinute) || other.targetWakeMinute == targetWakeMinute)&&(identical(other.targetSleepMinutes, targetSleepMinutes) || other.targetSleepMinutes == targetSleepMinutes)&&(identical(other.cbtiWeek, cbtiWeek) || other.cbtiWeek == cbtiWeek)&&(identical(other.programStartDate, programStartDate) || other.programStartDate == programStartDate)&&(identical(other.appleHealthEnabled, appleHealthEnabled) || other.appleHealthEnabled == appleHealthEnabled)&&(identical(other.googleFitEnabled, googleFitEnabled) || other.googleFitEnabled == googleFitEnabled)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,displayName,avatarUrl,subscriptionTier,preferredLanguage,analyticsConsent,isEuUser,targetBedtimeHour,targetBedtimeMinute,targetWakeHour,targetWakeMinute,targetSleepMinutes,cbtiWeek,programStartDate,appleHealthEnabled,googleFitEnabled,currentStreak,longestStreak,lastCheckInDate,createdAt,updatedAt]);

@override
String toString() {
  return 'UserProfile(id: $id, email: $email, displayName: $displayName, avatarUrl: $avatarUrl, subscriptionTier: $subscriptionTier, preferredLanguage: $preferredLanguage, analyticsConsent: $analyticsConsent, isEuUser: $isEuUser, targetBedtimeHour: $targetBedtimeHour, targetBedtimeMinute: $targetBedtimeMinute, targetWakeHour: $targetWakeHour, targetWakeMinute: $targetWakeMinute, targetSleepMinutes: $targetSleepMinutes, cbtiWeek: $cbtiWeek, programStartDate: $programStartDate, appleHealthEnabled: $appleHealthEnabled, googleFitEnabled: $googleFitEnabled, currentStreak: $currentStreak, longestStreak: $longestStreak, lastCheckInDate: $lastCheckInDate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String email, String? displayName, String? avatarUrl, String subscriptionTier, String preferredLanguage, bool analyticsConsent, bool isEuUser, int? targetBedtimeHour, int? targetBedtimeMinute, int? targetWakeHour, int? targetWakeMinute, int? targetSleepMinutes, int? cbtiWeek, DateTime? programStartDate, bool appleHealthEnabled, bool googleFitEnabled, int currentStreak, int longestStreak, DateTime? lastCheckInDate, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = freezed,Object? avatarUrl = freezed,Object? subscriptionTier = null,Object? preferredLanguage = null,Object? analyticsConsent = null,Object? isEuUser = null,Object? targetBedtimeHour = freezed,Object? targetBedtimeMinute = freezed,Object? targetWakeHour = freezed,Object? targetWakeMinute = freezed,Object? targetSleepMinutes = freezed,Object? cbtiWeek = freezed,Object? programStartDate = freezed,Object? appleHealthEnabled = null,Object? googleFitEnabled = null,Object? currentStreak = null,Object? longestStreak = null,Object? lastCheckInDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,subscriptionTier: null == subscriptionTier ? _self.subscriptionTier : subscriptionTier // ignore: cast_nullable_to_non_nullable
as String,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,analyticsConsent: null == analyticsConsent ? _self.analyticsConsent : analyticsConsent // ignore: cast_nullable_to_non_nullable
as bool,isEuUser: null == isEuUser ? _self.isEuUser : isEuUser // ignore: cast_nullable_to_non_nullable
as bool,targetBedtimeHour: freezed == targetBedtimeHour ? _self.targetBedtimeHour : targetBedtimeHour // ignore: cast_nullable_to_non_nullable
as int?,targetBedtimeMinute: freezed == targetBedtimeMinute ? _self.targetBedtimeMinute : targetBedtimeMinute // ignore: cast_nullable_to_non_nullable
as int?,targetWakeHour: freezed == targetWakeHour ? _self.targetWakeHour : targetWakeHour // ignore: cast_nullable_to_non_nullable
as int?,targetWakeMinute: freezed == targetWakeMinute ? _self.targetWakeMinute : targetWakeMinute // ignore: cast_nullable_to_non_nullable
as int?,targetSleepMinutes: freezed == targetSleepMinutes ? _self.targetSleepMinutes : targetSleepMinutes // ignore: cast_nullable_to_non_nullable
as int?,cbtiWeek: freezed == cbtiWeek ? _self.cbtiWeek : cbtiWeek // ignore: cast_nullable_to_non_nullable
as int?,programStartDate: freezed == programStartDate ? _self.programStartDate : programStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,appleHealthEnabled: null == appleHealthEnabled ? _self.appleHealthEnabled : appleHealthEnabled // ignore: cast_nullable_to_non_nullable
as bool,googleFitEnabled: null == googleFitEnabled ? _self.googleFitEnabled : googleFitEnabled // ignore: cast_nullable_to_non_nullable
as bool,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? displayName,  String? avatarUrl,  String subscriptionTier,  String preferredLanguage,  bool analyticsConsent,  bool isEuUser,  int? targetBedtimeHour,  int? targetBedtimeMinute,  int? targetWakeHour,  int? targetWakeMinute,  int? targetSleepMinutes,  int? cbtiWeek,  DateTime? programStartDate,  bool appleHealthEnabled,  bool googleFitEnabled,  int currentStreak,  int longestStreak,  DateTime? lastCheckInDate,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.avatarUrl,_that.subscriptionTier,_that.preferredLanguage,_that.analyticsConsent,_that.isEuUser,_that.targetBedtimeHour,_that.targetBedtimeMinute,_that.targetWakeHour,_that.targetWakeMinute,_that.targetSleepMinutes,_that.cbtiWeek,_that.programStartDate,_that.appleHealthEnabled,_that.googleFitEnabled,_that.currentStreak,_that.longestStreak,_that.lastCheckInDate,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? displayName,  String? avatarUrl,  String subscriptionTier,  String preferredLanguage,  bool analyticsConsent,  bool isEuUser,  int? targetBedtimeHour,  int? targetBedtimeMinute,  int? targetWakeHour,  int? targetWakeMinute,  int? targetSleepMinutes,  int? cbtiWeek,  DateTime? programStartDate,  bool appleHealthEnabled,  bool googleFitEnabled,  int currentStreak,  int longestStreak,  DateTime? lastCheckInDate,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.email,_that.displayName,_that.avatarUrl,_that.subscriptionTier,_that.preferredLanguage,_that.analyticsConsent,_that.isEuUser,_that.targetBedtimeHour,_that.targetBedtimeMinute,_that.targetWakeHour,_that.targetWakeMinute,_that.targetSleepMinutes,_that.cbtiWeek,_that.programStartDate,_that.appleHealthEnabled,_that.googleFitEnabled,_that.currentStreak,_that.longestStreak,_that.lastCheckInDate,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? displayName,  String? avatarUrl,  String subscriptionTier,  String preferredLanguage,  bool analyticsConsent,  bool isEuUser,  int? targetBedtimeHour,  int? targetBedtimeMinute,  int? targetWakeHour,  int? targetWakeMinute,  int? targetSleepMinutes,  int? cbtiWeek,  DateTime? programStartDate,  bool appleHealthEnabled,  bool googleFitEnabled,  int currentStreak,  int longestStreak,  DateTime? lastCheckInDate,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.avatarUrl,_that.subscriptionTier,_that.preferredLanguage,_that.analyticsConsent,_that.isEuUser,_that.targetBedtimeHour,_that.targetBedtimeMinute,_that.targetWakeHour,_that.targetWakeMinute,_that.targetSleepMinutes,_that.cbtiWeek,_that.programStartDate,_that.appleHealthEnabled,_that.googleFitEnabled,_that.currentStreak,_that.longestStreak,_that.lastCheckInDate,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({required this.id, required this.email, this.displayName, this.avatarUrl, this.subscriptionTier = 'free', this.preferredLanguage = 'en', this.analyticsConsent = false, this.isEuUser = false, this.targetBedtimeHour, this.targetBedtimeMinute, this.targetWakeHour, this.targetWakeMinute, this.targetSleepMinutes, this.cbtiWeek, this.programStartDate, this.appleHealthEnabled = false, this.googleFitEnabled = false, this.currentStreak = 0, this.longestStreak = 0, this.lastCheckInDate, this.createdAt, this.updatedAt});
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String id;
@override final  String email;
@override final  String? displayName;
@override final  String? avatarUrl;
@override@JsonKey() final  String subscriptionTier;
@override@JsonKey() final  String preferredLanguage;
@override@JsonKey() final  bool analyticsConsent;
@override@JsonKey() final  bool isEuUser;
// Sleep preferences
@override final  int? targetBedtimeHour;
// 0-23
@override final  int? targetBedtimeMinute;
// 0-59
@override final  int? targetWakeHour;
@override final  int? targetWakeMinute;
@override final  int? targetSleepMinutes;
// desired total sleep duration
// CBT-I program
@override final  int? cbtiWeek;
// current week in 8-week program
@override final  DateTime? programStartDate;
// Wearables
@override@JsonKey() final  bool appleHealthEnabled;
@override@JsonKey() final  bool googleFitEnabled;
// Streaks
@override@JsonKey() final  int currentStreak;
@override@JsonKey() final  int longestStreak;
@override final  DateTime? lastCheckInDate;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.subscriptionTier, subscriptionTier) || other.subscriptionTier == subscriptionTier)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.analyticsConsent, analyticsConsent) || other.analyticsConsent == analyticsConsent)&&(identical(other.isEuUser, isEuUser) || other.isEuUser == isEuUser)&&(identical(other.targetBedtimeHour, targetBedtimeHour) || other.targetBedtimeHour == targetBedtimeHour)&&(identical(other.targetBedtimeMinute, targetBedtimeMinute) || other.targetBedtimeMinute == targetBedtimeMinute)&&(identical(other.targetWakeHour, targetWakeHour) || other.targetWakeHour == targetWakeHour)&&(identical(other.targetWakeMinute, targetWakeMinute) || other.targetWakeMinute == targetWakeMinute)&&(identical(other.targetSleepMinutes, targetSleepMinutes) || other.targetSleepMinutes == targetSleepMinutes)&&(identical(other.cbtiWeek, cbtiWeek) || other.cbtiWeek == cbtiWeek)&&(identical(other.programStartDate, programStartDate) || other.programStartDate == programStartDate)&&(identical(other.appleHealthEnabled, appleHealthEnabled) || other.appleHealthEnabled == appleHealthEnabled)&&(identical(other.googleFitEnabled, googleFitEnabled) || other.googleFitEnabled == googleFitEnabled)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.lastCheckInDate, lastCheckInDate) || other.lastCheckInDate == lastCheckInDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,displayName,avatarUrl,subscriptionTier,preferredLanguage,analyticsConsent,isEuUser,targetBedtimeHour,targetBedtimeMinute,targetWakeHour,targetWakeMinute,targetSleepMinutes,cbtiWeek,programStartDate,appleHealthEnabled,googleFitEnabled,currentStreak,longestStreak,lastCheckInDate,createdAt,updatedAt]);

@override
String toString() {
  return 'UserProfile(id: $id, email: $email, displayName: $displayName, avatarUrl: $avatarUrl, subscriptionTier: $subscriptionTier, preferredLanguage: $preferredLanguage, analyticsConsent: $analyticsConsent, isEuUser: $isEuUser, targetBedtimeHour: $targetBedtimeHour, targetBedtimeMinute: $targetBedtimeMinute, targetWakeHour: $targetWakeHour, targetWakeMinute: $targetWakeMinute, targetSleepMinutes: $targetSleepMinutes, cbtiWeek: $cbtiWeek, programStartDate: $programStartDate, appleHealthEnabled: $appleHealthEnabled, googleFitEnabled: $googleFitEnabled, currentStreak: $currentStreak, longestStreak: $longestStreak, lastCheckInDate: $lastCheckInDate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String? displayName, String? avatarUrl, String subscriptionTier, String preferredLanguage, bool analyticsConsent, bool isEuUser, int? targetBedtimeHour, int? targetBedtimeMinute, int? targetWakeHour, int? targetWakeMinute, int? targetSleepMinutes, int? cbtiWeek, DateTime? programStartDate, bool appleHealthEnabled, bool googleFitEnabled, int currentStreak, int longestStreak, DateTime? lastCheckInDate, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = freezed,Object? avatarUrl = freezed,Object? subscriptionTier = null,Object? preferredLanguage = null,Object? analyticsConsent = null,Object? isEuUser = null,Object? targetBedtimeHour = freezed,Object? targetBedtimeMinute = freezed,Object? targetWakeHour = freezed,Object? targetWakeMinute = freezed,Object? targetSleepMinutes = freezed,Object? cbtiWeek = freezed,Object? programStartDate = freezed,Object? appleHealthEnabled = null,Object? googleFitEnabled = null,Object? currentStreak = null,Object? longestStreak = null,Object? lastCheckInDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,subscriptionTier: null == subscriptionTier ? _self.subscriptionTier : subscriptionTier // ignore: cast_nullable_to_non_nullable
as String,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,analyticsConsent: null == analyticsConsent ? _self.analyticsConsent : analyticsConsent // ignore: cast_nullable_to_non_nullable
as bool,isEuUser: null == isEuUser ? _self.isEuUser : isEuUser // ignore: cast_nullable_to_non_nullable
as bool,targetBedtimeHour: freezed == targetBedtimeHour ? _self.targetBedtimeHour : targetBedtimeHour // ignore: cast_nullable_to_non_nullable
as int?,targetBedtimeMinute: freezed == targetBedtimeMinute ? _self.targetBedtimeMinute : targetBedtimeMinute // ignore: cast_nullable_to_non_nullable
as int?,targetWakeHour: freezed == targetWakeHour ? _self.targetWakeHour : targetWakeHour // ignore: cast_nullable_to_non_nullable
as int?,targetWakeMinute: freezed == targetWakeMinute ? _self.targetWakeMinute : targetWakeMinute // ignore: cast_nullable_to_non_nullable
as int?,targetSleepMinutes: freezed == targetSleepMinutes ? _self.targetSleepMinutes : targetSleepMinutes // ignore: cast_nullable_to_non_nullable
as int?,cbtiWeek: freezed == cbtiWeek ? _self.cbtiWeek : cbtiWeek // ignore: cast_nullable_to_non_nullable
as int?,programStartDate: freezed == programStartDate ? _self.programStartDate : programStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,appleHealthEnabled: null == appleHealthEnabled ? _self.appleHealthEnabled : appleHealthEnabled // ignore: cast_nullable_to_non_nullable
as bool,googleFitEnabled: null == googleFitEnabled ? _self.googleFitEnabled : googleFitEnabled // ignore: cast_nullable_to_non_nullable
as bool,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastCheckInDate: freezed == lastCheckInDate ? _self.lastCheckInDate : lastCheckInDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
