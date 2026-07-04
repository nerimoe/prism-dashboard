// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrentStaff {

 String get id; String get displayName;@JsonKey(unknownEnumValue: StaffRole.viewer) StaffRole get role; bool get canWrite;
/// Create a copy of CurrentStaff
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentStaffCopyWith<CurrentStaff> get copyWith => _$CurrentStaffCopyWithImpl<CurrentStaff>(this as CurrentStaff, _$identity);

  /// Serializes this CurrentStaff to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentStaff&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.role, role) || other.role == role)&&(identical(other.canWrite, canWrite) || other.canWrite == canWrite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,role,canWrite);

@override
String toString() {
  return 'CurrentStaff(id: $id, displayName: $displayName, role: $role, canWrite: $canWrite)';
}


}

/// @nodoc
abstract mixin class $CurrentStaffCopyWith<$Res>  {
  factory $CurrentStaffCopyWith(CurrentStaff value, $Res Function(CurrentStaff) _then) = _$CurrentStaffCopyWithImpl;
@useResult
$Res call({
 String id, String displayName,@JsonKey(unknownEnumValue: StaffRole.viewer) StaffRole role, bool canWrite
});




}
/// @nodoc
class _$CurrentStaffCopyWithImpl<$Res>
    implements $CurrentStaffCopyWith<$Res> {
  _$CurrentStaffCopyWithImpl(this._self, this._then);

  final CurrentStaff _self;
  final $Res Function(CurrentStaff) _then;

/// Create a copy of CurrentStaff
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? role = null,Object? canWrite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as StaffRole,canWrite: null == canWrite ? _self.canWrite : canWrite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentStaff].
extension CurrentStaffPatterns on CurrentStaff {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentStaff value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentStaff() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentStaff value)  $default,){
final _that = this;
switch (_that) {
case _CurrentStaff():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentStaff value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentStaff() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName, @JsonKey(unknownEnumValue: StaffRole.viewer)  StaffRole role,  bool canWrite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentStaff() when $default != null:
return $default(_that.id,_that.displayName,_that.role,_that.canWrite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName, @JsonKey(unknownEnumValue: StaffRole.viewer)  StaffRole role,  bool canWrite)  $default,) {final _that = this;
switch (_that) {
case _CurrentStaff():
return $default(_that.id,_that.displayName,_that.role,_that.canWrite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName, @JsonKey(unknownEnumValue: StaffRole.viewer)  StaffRole role,  bool canWrite)?  $default,) {final _that = this;
switch (_that) {
case _CurrentStaff() when $default != null:
return $default(_that.id,_that.displayName,_that.role,_that.canWrite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentStaff implements CurrentStaff {
  const _CurrentStaff({required this.id, required this.displayName, @JsonKey(unknownEnumValue: StaffRole.viewer) required this.role, this.canWrite = false});
  factory _CurrentStaff.fromJson(Map<String, dynamic> json) => _$CurrentStaffFromJson(json);

@override final  String id;
@override final  String displayName;
@override@JsonKey(unknownEnumValue: StaffRole.viewer) final  StaffRole role;
@override@JsonKey() final  bool canWrite;

/// Create a copy of CurrentStaff
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentStaffCopyWith<_CurrentStaff> get copyWith => __$CurrentStaffCopyWithImpl<_CurrentStaff>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentStaffToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentStaff&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.role, role) || other.role == role)&&(identical(other.canWrite, canWrite) || other.canWrite == canWrite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,role,canWrite);

@override
String toString() {
  return 'CurrentStaff(id: $id, displayName: $displayName, role: $role, canWrite: $canWrite)';
}


}

/// @nodoc
abstract mixin class _$CurrentStaffCopyWith<$Res> implements $CurrentStaffCopyWith<$Res> {
  factory _$CurrentStaffCopyWith(_CurrentStaff value, $Res Function(_CurrentStaff) _then) = __$CurrentStaffCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName,@JsonKey(unknownEnumValue: StaffRole.viewer) StaffRole role, bool canWrite
});




}
/// @nodoc
class __$CurrentStaffCopyWithImpl<$Res>
    implements _$CurrentStaffCopyWith<$Res> {
  __$CurrentStaffCopyWithImpl(this._self, this._then);

  final _CurrentStaff _self;
  final $Res Function(_CurrentStaff) _then;

/// Create a copy of CurrentStaff
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? role = null,Object? canWrite = null,}) {
  return _then(_CurrentStaff(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as StaffRole,canWrite: null == canWrite ? _self.canWrite : canWrite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SetupStatus {

 bool get installed;
/// Create a copy of SetupStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupStatusCopyWith<SetupStatus> get copyWith => _$SetupStatusCopyWithImpl<SetupStatus>(this as SetupStatus, _$identity);

  /// Serializes this SetupStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupStatus&&(identical(other.installed, installed) || other.installed == installed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,installed);

@override
String toString() {
  return 'SetupStatus(installed: $installed)';
}


}

/// @nodoc
abstract mixin class $SetupStatusCopyWith<$Res>  {
  factory $SetupStatusCopyWith(SetupStatus value, $Res Function(SetupStatus) _then) = _$SetupStatusCopyWithImpl;
@useResult
$Res call({
 bool installed
});




}
/// @nodoc
class _$SetupStatusCopyWithImpl<$Res>
    implements $SetupStatusCopyWith<$Res> {
  _$SetupStatusCopyWithImpl(this._self, this._then);

  final SetupStatus _self;
  final $Res Function(SetupStatus) _then;

/// Create a copy of SetupStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? installed = null,}) {
  return _then(_self.copyWith(
installed: null == installed ? _self.installed : installed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SetupStatus].
extension SetupStatusPatterns on SetupStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetupStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetupStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetupStatus value)  $default,){
final _that = this;
switch (_that) {
case _SetupStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetupStatus value)?  $default,){
final _that = this;
switch (_that) {
case _SetupStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool installed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetupStatus() when $default != null:
return $default(_that.installed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool installed)  $default,) {final _that = this;
switch (_that) {
case _SetupStatus():
return $default(_that.installed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool installed)?  $default,) {final _that = this;
switch (_that) {
case _SetupStatus() when $default != null:
return $default(_that.installed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SetupStatus implements SetupStatus {
  const _SetupStatus({required this.installed});
  factory _SetupStatus.fromJson(Map<String, dynamic> json) => _$SetupStatusFromJson(json);

@override final  bool installed;

/// Create a copy of SetupStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetupStatusCopyWith<_SetupStatus> get copyWith => __$SetupStatusCopyWithImpl<_SetupStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetupStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetupStatus&&(identical(other.installed, installed) || other.installed == installed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,installed);

@override
String toString() {
  return 'SetupStatus(installed: $installed)';
}


}

/// @nodoc
abstract mixin class _$SetupStatusCopyWith<$Res> implements $SetupStatusCopyWith<$Res> {
  factory _$SetupStatusCopyWith(_SetupStatus value, $Res Function(_SetupStatus) _then) = __$SetupStatusCopyWithImpl;
@override @useResult
$Res call({
 bool installed
});




}
/// @nodoc
class __$SetupStatusCopyWithImpl<$Res>
    implements _$SetupStatusCopyWith<$Res> {
  __$SetupStatusCopyWithImpl(this._self, this._then);

  final _SetupStatus _self;
  final $Res Function(_SetupStatus) _then;

/// Create a copy of SetupStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? installed = null,}) {
  return _then(_SetupStatus(
installed: null == installed ? _self.installed : installed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$LivePlayer {

 String get playerId; String get displayName; String get status; num get walletTotal; int get stayDurationMinutes; num? get estimatedTotal; List<LiveSession> get sessions;
/// Create a copy of LivePlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivePlayerCopyWith<LivePlayer> get copyWith => _$LivePlayerCopyWithImpl<LivePlayer>(this as LivePlayer, _$identity);

  /// Serializes this LivePlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivePlayer&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.walletTotal, walletTotal) || other.walletTotal == walletTotal)&&(identical(other.stayDurationMinutes, stayDurationMinutes) || other.stayDurationMinutes == stayDurationMinutes)&&(identical(other.estimatedTotal, estimatedTotal) || other.estimatedTotal == estimatedTotal)&&const DeepCollectionEquality().equals(other.sessions, sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,displayName,status,walletTotal,stayDurationMinutes,estimatedTotal,const DeepCollectionEquality().hash(sessions));

@override
String toString() {
  return 'LivePlayer(playerId: $playerId, displayName: $displayName, status: $status, walletTotal: $walletTotal, stayDurationMinutes: $stayDurationMinutes, estimatedTotal: $estimatedTotal, sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class $LivePlayerCopyWith<$Res>  {
  factory $LivePlayerCopyWith(LivePlayer value, $Res Function(LivePlayer) _then) = _$LivePlayerCopyWithImpl;
@useResult
$Res call({
 String playerId, String displayName, String status, num walletTotal, int stayDurationMinutes, num? estimatedTotal, List<LiveSession> sessions
});




}
/// @nodoc
class _$LivePlayerCopyWithImpl<$Res>
    implements $LivePlayerCopyWith<$Res> {
  _$LivePlayerCopyWithImpl(this._self, this._then);

  final LivePlayer _self;
  final $Res Function(LivePlayer) _then;

/// Create a copy of LivePlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? displayName = null,Object? status = null,Object? walletTotal = null,Object? stayDurationMinutes = null,Object? estimatedTotal = freezed,Object? sessions = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,walletTotal: null == walletTotal ? _self.walletTotal : walletTotal // ignore: cast_nullable_to_non_nullable
as num,stayDurationMinutes: null == stayDurationMinutes ? _self.stayDurationMinutes : stayDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,estimatedTotal: freezed == estimatedTotal ? _self.estimatedTotal : estimatedTotal // ignore: cast_nullable_to_non_nullable
as num?,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<LiveSession>,
  ));
}

}


/// Adds pattern-matching-related methods to [LivePlayer].
extension LivePlayerPatterns on LivePlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivePlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivePlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivePlayer value)  $default,){
final _that = this;
switch (_that) {
case _LivePlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivePlayer value)?  $default,){
final _that = this;
switch (_that) {
case _LivePlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  String displayName,  String status,  num walletTotal,  int stayDurationMinutes,  num? estimatedTotal,  List<LiveSession> sessions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivePlayer() when $default != null:
return $default(_that.playerId,_that.displayName,_that.status,_that.walletTotal,_that.stayDurationMinutes,_that.estimatedTotal,_that.sessions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  String displayName,  String status,  num walletTotal,  int stayDurationMinutes,  num? estimatedTotal,  List<LiveSession> sessions)  $default,) {final _that = this;
switch (_that) {
case _LivePlayer():
return $default(_that.playerId,_that.displayName,_that.status,_that.walletTotal,_that.stayDurationMinutes,_that.estimatedTotal,_that.sessions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  String displayName,  String status,  num walletTotal,  int stayDurationMinutes,  num? estimatedTotal,  List<LiveSession> sessions)?  $default,) {final _that = this;
switch (_that) {
case _LivePlayer() when $default != null:
return $default(_that.playerId,_that.displayName,_that.status,_that.walletTotal,_that.stayDurationMinutes,_that.estimatedTotal,_that.sessions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivePlayer extends LivePlayer {
  const _LivePlayer({required this.playerId, required this.displayName, required this.status, required this.walletTotal, required this.stayDurationMinutes, this.estimatedTotal, required final  List<LiveSession> sessions}): _sessions = sessions,super._();
  factory _LivePlayer.fromJson(Map<String, dynamic> json) => _$LivePlayerFromJson(json);

@override final  String playerId;
@override final  String displayName;
@override final  String status;
@override final  num walletTotal;
@override final  int stayDurationMinutes;
@override final  num? estimatedTotal;
 final  List<LiveSession> _sessions;
@override List<LiveSession> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}


/// Create a copy of LivePlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivePlayerCopyWith<_LivePlayer> get copyWith => __$LivePlayerCopyWithImpl<_LivePlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivePlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivePlayer&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.walletTotal, walletTotal) || other.walletTotal == walletTotal)&&(identical(other.stayDurationMinutes, stayDurationMinutes) || other.stayDurationMinutes == stayDurationMinutes)&&(identical(other.estimatedTotal, estimatedTotal) || other.estimatedTotal == estimatedTotal)&&const DeepCollectionEquality().equals(other._sessions, _sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,displayName,status,walletTotal,stayDurationMinutes,estimatedTotal,const DeepCollectionEquality().hash(_sessions));

@override
String toString() {
  return 'LivePlayer(playerId: $playerId, displayName: $displayName, status: $status, walletTotal: $walletTotal, stayDurationMinutes: $stayDurationMinutes, estimatedTotal: $estimatedTotal, sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class _$LivePlayerCopyWith<$Res> implements $LivePlayerCopyWith<$Res> {
  factory _$LivePlayerCopyWith(_LivePlayer value, $Res Function(_LivePlayer) _then) = __$LivePlayerCopyWithImpl;
@override @useResult
$Res call({
 String playerId, String displayName, String status, num walletTotal, int stayDurationMinutes, num? estimatedTotal, List<LiveSession> sessions
});




}
/// @nodoc
class __$LivePlayerCopyWithImpl<$Res>
    implements _$LivePlayerCopyWith<$Res> {
  __$LivePlayerCopyWithImpl(this._self, this._then);

  final _LivePlayer _self;
  final $Res Function(_LivePlayer) _then;

/// Create a copy of LivePlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? displayName = null,Object? status = null,Object? walletTotal = null,Object? stayDurationMinutes = null,Object? estimatedTotal = freezed,Object? sessions = null,}) {
  return _then(_LivePlayer(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,walletTotal: null == walletTotal ? _self.walletTotal : walletTotal // ignore: cast_nullable_to_non_nullable
as num,stayDurationMinutes: null == stayDurationMinutes ? _self.stayDurationMinutes : stayDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,estimatedTotal: freezed == estimatedTotal ? _self.estimatedTotal : estimatedTotal // ignore: cast_nullable_to_non_nullable
as num?,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<LiveSession>,
  ));
}


}


/// @nodoc
mixin _$LiveSession {

@JsonKey(readValue: readSessionId) String get id; String? get label; DateTime get startedAt;@JsonKey(readValue: readElapsedMinutes) int get elapsedMinutes;@JsonKey(readValue: readCurrentImpact) num? get currentImpact; String get status;
/// Create a copy of LiveSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveSessionCopyWith<LiveSession> get copyWith => _$LiveSessionCopyWithImpl<LiveSession>(this as LiveSession, _$identity);

  /// Serializes this LiveSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveSession&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.elapsedMinutes, elapsedMinutes) || other.elapsedMinutes == elapsedMinutes)&&(identical(other.currentImpact, currentImpact) || other.currentImpact == currentImpact)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,startedAt,elapsedMinutes,currentImpact,status);

@override
String toString() {
  return 'LiveSession(id: $id, label: $label, startedAt: $startedAt, elapsedMinutes: $elapsedMinutes, currentImpact: $currentImpact, status: $status)';
}


}

/// @nodoc
abstract mixin class $LiveSessionCopyWith<$Res>  {
  factory $LiveSessionCopyWith(LiveSession value, $Res Function(LiveSession) _then) = _$LiveSessionCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: readSessionId) String id, String? label, DateTime startedAt,@JsonKey(readValue: readElapsedMinutes) int elapsedMinutes,@JsonKey(readValue: readCurrentImpact) num? currentImpact, String status
});




}
/// @nodoc
class _$LiveSessionCopyWithImpl<$Res>
    implements $LiveSessionCopyWith<$Res> {
  _$LiveSessionCopyWithImpl(this._self, this._then);

  final LiveSession _self;
  final $Res Function(LiveSession) _then;

/// Create a copy of LiveSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = freezed,Object? startedAt = null,Object? elapsedMinutes = null,Object? currentImpact = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,elapsedMinutes: null == elapsedMinutes ? _self.elapsedMinutes : elapsedMinutes // ignore: cast_nullable_to_non_nullable
as int,currentImpact: freezed == currentImpact ? _self.currentImpact : currentImpact // ignore: cast_nullable_to_non_nullable
as num?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveSession].
extension LiveSessionPatterns on LiveSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveSession value)  $default,){
final _that = this;
switch (_that) {
case _LiveSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveSession value)?  $default,){
final _that = this;
switch (_that) {
case _LiveSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: readSessionId)  String id,  String? label,  DateTime startedAt, @JsonKey(readValue: readElapsedMinutes)  int elapsedMinutes, @JsonKey(readValue: readCurrentImpact)  num? currentImpact,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveSession() when $default != null:
return $default(_that.id,_that.label,_that.startedAt,_that.elapsedMinutes,_that.currentImpact,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: readSessionId)  String id,  String? label,  DateTime startedAt, @JsonKey(readValue: readElapsedMinutes)  int elapsedMinutes, @JsonKey(readValue: readCurrentImpact)  num? currentImpact,  String status)  $default,) {final _that = this;
switch (_that) {
case _LiveSession():
return $default(_that.id,_that.label,_that.startedAt,_that.elapsedMinutes,_that.currentImpact,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: readSessionId)  String id,  String? label,  DateTime startedAt, @JsonKey(readValue: readElapsedMinutes)  int elapsedMinutes, @JsonKey(readValue: readCurrentImpact)  num? currentImpact,  String status)?  $default,) {final _that = this;
switch (_that) {
case _LiveSession() when $default != null:
return $default(_that.id,_that.label,_that.startedAt,_that.elapsedMinutes,_that.currentImpact,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveSession extends LiveSession {
  const _LiveSession({@JsonKey(readValue: readSessionId) required this.id, this.label, required this.startedAt, @JsonKey(readValue: readElapsedMinutes) this.elapsedMinutes = 0, @JsonKey(readValue: readCurrentImpact) this.currentImpact, this.status = 'closed'}): super._();
  factory _LiveSession.fromJson(Map<String, dynamic> json) => _$LiveSessionFromJson(json);

@override@JsonKey(readValue: readSessionId) final  String id;
@override final  String? label;
@override final  DateTime startedAt;
@override@JsonKey(readValue: readElapsedMinutes) final  int elapsedMinutes;
@override@JsonKey(readValue: readCurrentImpact) final  num? currentImpact;
@override@JsonKey() final  String status;

/// Create a copy of LiveSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveSessionCopyWith<_LiveSession> get copyWith => __$LiveSessionCopyWithImpl<_LiveSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveSession&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.elapsedMinutes, elapsedMinutes) || other.elapsedMinutes == elapsedMinutes)&&(identical(other.currentImpact, currentImpact) || other.currentImpact == currentImpact)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,startedAt,elapsedMinutes,currentImpact,status);

@override
String toString() {
  return 'LiveSession(id: $id, label: $label, startedAt: $startedAt, elapsedMinutes: $elapsedMinutes, currentImpact: $currentImpact, status: $status)';
}


}

/// @nodoc
abstract mixin class _$LiveSessionCopyWith<$Res> implements $LiveSessionCopyWith<$Res> {
  factory _$LiveSessionCopyWith(_LiveSession value, $Res Function(_LiveSession) _then) = __$LiveSessionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: readSessionId) String id, String? label, DateTime startedAt,@JsonKey(readValue: readElapsedMinutes) int elapsedMinutes,@JsonKey(readValue: readCurrentImpact) num? currentImpact, String status
});




}
/// @nodoc
class __$LiveSessionCopyWithImpl<$Res>
    implements _$LiveSessionCopyWith<$Res> {
  __$LiveSessionCopyWithImpl(this._self, this._then);

  final _LiveSession _self;
  final $Res Function(_LiveSession) _then;

/// Create a copy of LiveSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = freezed,Object? startedAt = null,Object? elapsedMinutes = null,Object? currentImpact = freezed,Object? status = null,}) {
  return _then(_LiveSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,elapsedMinutes: null == elapsedMinutes ? _self.elapsedMinutes : elapsedMinutes // ignore: cast_nullable_to_non_nullable
as int,currentImpact: freezed == currentImpact ? _self.currentImpact : currentImpact // ignore: cast_nullable_to_non_nullable
as num?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SettlementPreview {

 String get playerId; List<String> get sessionIds; num get subtotal; num get total; String get status; DateTime? get previewedAt; List<SessionPreview> get sessionPreviews;
/// Create a copy of SettlementPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementPreviewCopyWith<SettlementPreview> get copyWith => _$SettlementPreviewCopyWithImpl<SettlementPreview>(this as SettlementPreview, _$identity);

  /// Serializes this SettlementPreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementPreview&&(identical(other.playerId, playerId) || other.playerId == playerId)&&const DeepCollectionEquality().equals(other.sessionIds, sessionIds)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.previewedAt, previewedAt) || other.previewedAt == previewedAt)&&const DeepCollectionEquality().equals(other.sessionPreviews, sessionPreviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,const DeepCollectionEquality().hash(sessionIds),subtotal,total,status,previewedAt,const DeepCollectionEquality().hash(sessionPreviews));

@override
String toString() {
  return 'SettlementPreview(playerId: $playerId, sessionIds: $sessionIds, subtotal: $subtotal, total: $total, status: $status, previewedAt: $previewedAt, sessionPreviews: $sessionPreviews)';
}


}

/// @nodoc
abstract mixin class $SettlementPreviewCopyWith<$Res>  {
  factory $SettlementPreviewCopyWith(SettlementPreview value, $Res Function(SettlementPreview) _then) = _$SettlementPreviewCopyWithImpl;
@useResult
$Res call({
 String playerId, List<String> sessionIds, num subtotal, num total, String status, DateTime? previewedAt, List<SessionPreview> sessionPreviews
});




}
/// @nodoc
class _$SettlementPreviewCopyWithImpl<$Res>
    implements $SettlementPreviewCopyWith<$Res> {
  _$SettlementPreviewCopyWithImpl(this._self, this._then);

  final SettlementPreview _self;
  final $Res Function(SettlementPreview) _then;

/// Create a copy of SettlementPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? sessionIds = null,Object? subtotal = null,Object? total = null,Object? status = null,Object? previewedAt = freezed,Object? sessionPreviews = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,sessionIds: null == sessionIds ? _self.sessionIds : sessionIds // ignore: cast_nullable_to_non_nullable
as List<String>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as num,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,previewedAt: freezed == previewedAt ? _self.previewedAt : previewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sessionPreviews: null == sessionPreviews ? _self.sessionPreviews : sessionPreviews // ignore: cast_nullable_to_non_nullable
as List<SessionPreview>,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementPreview].
extension SettlementPreviewPatterns on SettlementPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementPreview value)  $default,){
final _that = this;
switch (_that) {
case _SettlementPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementPreview value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  List<String> sessionIds,  num subtotal,  num total,  String status,  DateTime? previewedAt,  List<SessionPreview> sessionPreviews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementPreview() when $default != null:
return $default(_that.playerId,_that.sessionIds,_that.subtotal,_that.total,_that.status,_that.previewedAt,_that.sessionPreviews);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  List<String> sessionIds,  num subtotal,  num total,  String status,  DateTime? previewedAt,  List<SessionPreview> sessionPreviews)  $default,) {final _that = this;
switch (_that) {
case _SettlementPreview():
return $default(_that.playerId,_that.sessionIds,_that.subtotal,_that.total,_that.status,_that.previewedAt,_that.sessionPreviews);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  List<String> sessionIds,  num subtotal,  num total,  String status,  DateTime? previewedAt,  List<SessionPreview> sessionPreviews)?  $default,) {final _that = this;
switch (_that) {
case _SettlementPreview() when $default != null:
return $default(_that.playerId,_that.sessionIds,_that.subtotal,_that.total,_that.status,_that.previewedAt,_that.sessionPreviews);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlementPreview implements SettlementPreview {
  const _SettlementPreview({required this.playerId, required final  List<String> sessionIds, required this.subtotal, required this.total, required this.status, this.previewedAt, required final  List<SessionPreview> sessionPreviews}): _sessionIds = sessionIds,_sessionPreviews = sessionPreviews;
  factory _SettlementPreview.fromJson(Map<String, dynamic> json) => _$SettlementPreviewFromJson(json);

@override final  String playerId;
 final  List<String> _sessionIds;
@override List<String> get sessionIds {
  if (_sessionIds is EqualUnmodifiableListView) return _sessionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessionIds);
}

@override final  num subtotal;
@override final  num total;
@override final  String status;
@override final  DateTime? previewedAt;
 final  List<SessionPreview> _sessionPreviews;
@override List<SessionPreview> get sessionPreviews {
  if (_sessionPreviews is EqualUnmodifiableListView) return _sessionPreviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessionPreviews);
}


/// Create a copy of SettlementPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementPreviewCopyWith<_SettlementPreview> get copyWith => __$SettlementPreviewCopyWithImpl<_SettlementPreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettlementPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementPreview&&(identical(other.playerId, playerId) || other.playerId == playerId)&&const DeepCollectionEquality().equals(other._sessionIds, _sessionIds)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.total, total) || other.total == total)&&(identical(other.status, status) || other.status == status)&&(identical(other.previewedAt, previewedAt) || other.previewedAt == previewedAt)&&const DeepCollectionEquality().equals(other._sessionPreviews, _sessionPreviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,const DeepCollectionEquality().hash(_sessionIds),subtotal,total,status,previewedAt,const DeepCollectionEquality().hash(_sessionPreviews));

@override
String toString() {
  return 'SettlementPreview(playerId: $playerId, sessionIds: $sessionIds, subtotal: $subtotal, total: $total, status: $status, previewedAt: $previewedAt, sessionPreviews: $sessionPreviews)';
}


}

/// @nodoc
abstract mixin class _$SettlementPreviewCopyWith<$Res> implements $SettlementPreviewCopyWith<$Res> {
  factory _$SettlementPreviewCopyWith(_SettlementPreview value, $Res Function(_SettlementPreview) _then) = __$SettlementPreviewCopyWithImpl;
@override @useResult
$Res call({
 String playerId, List<String> sessionIds, num subtotal, num total, String status, DateTime? previewedAt, List<SessionPreview> sessionPreviews
});




}
/// @nodoc
class __$SettlementPreviewCopyWithImpl<$Res>
    implements _$SettlementPreviewCopyWith<$Res> {
  __$SettlementPreviewCopyWithImpl(this._self, this._then);

  final _SettlementPreview _self;
  final $Res Function(_SettlementPreview) _then;

/// Create a copy of SettlementPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? sessionIds = null,Object? subtotal = null,Object? total = null,Object? status = null,Object? previewedAt = freezed,Object? sessionPreviews = null,}) {
  return _then(_SettlementPreview(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,sessionIds: null == sessionIds ? _self._sessionIds : sessionIds // ignore: cast_nullable_to_non_nullable
as List<String>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as num,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,previewedAt: freezed == previewedAt ? _self.previewedAt : previewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sessionPreviews: null == sessionPreviews ? _self._sessionPreviews : sessionPreviews // ignore: cast_nullable_to_non_nullable
as List<SessionPreview>,
  ));
}


}


/// @nodoc
mixin _$SessionPreview {

 String get sessionId; num get subtotal; num get total;
/// Create a copy of SessionPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionPreviewCopyWith<SessionPreview> get copyWith => _$SessionPreviewCopyWithImpl<SessionPreview>(this as SessionPreview, _$identity);

  /// Serializes this SessionPreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionPreview&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,subtotal,total);

@override
String toString() {
  return 'SessionPreview(sessionId: $sessionId, subtotal: $subtotal, total: $total)';
}


}

/// @nodoc
abstract mixin class $SessionPreviewCopyWith<$Res>  {
  factory $SessionPreviewCopyWith(SessionPreview value, $Res Function(SessionPreview) _then) = _$SessionPreviewCopyWithImpl;
@useResult
$Res call({
 String sessionId, num subtotal, num total
});




}
/// @nodoc
class _$SessionPreviewCopyWithImpl<$Res>
    implements $SessionPreviewCopyWith<$Res> {
  _$SessionPreviewCopyWithImpl(this._self, this._then);

  final SessionPreview _self;
  final $Res Function(SessionPreview) _then;

/// Create a copy of SessionPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? subtotal = null,Object? total = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as num,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionPreview].
extension SessionPreviewPatterns on SessionPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionPreview value)  $default,){
final _that = this;
switch (_that) {
case _SessionPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionPreview value)?  $default,){
final _that = this;
switch (_that) {
case _SessionPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  num subtotal,  num total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionPreview() when $default != null:
return $default(_that.sessionId,_that.subtotal,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  num subtotal,  num total)  $default,) {final _that = this;
switch (_that) {
case _SessionPreview():
return $default(_that.sessionId,_that.subtotal,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  num subtotal,  num total)?  $default,) {final _that = this;
switch (_that) {
case _SessionPreview() when $default != null:
return $default(_that.sessionId,_that.subtotal,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionPreview implements SessionPreview {
  const _SessionPreview({required this.sessionId, required this.subtotal, required this.total});
  factory _SessionPreview.fromJson(Map<String, dynamic> json) => _$SessionPreviewFromJson(json);

@override final  String sessionId;
@override final  num subtotal;
@override final  num total;

/// Create a copy of SessionPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionPreviewCopyWith<_SessionPreview> get copyWith => __$SessionPreviewCopyWithImpl<_SessionPreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionPreview&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,subtotal,total);

@override
String toString() {
  return 'SessionPreview(sessionId: $sessionId, subtotal: $subtotal, total: $total)';
}


}

/// @nodoc
abstract mixin class _$SessionPreviewCopyWith<$Res> implements $SessionPreviewCopyWith<$Res> {
  factory _$SessionPreviewCopyWith(_SessionPreview value, $Res Function(_SessionPreview) _then) = __$SessionPreviewCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, num subtotal, num total
});




}
/// @nodoc
class __$SessionPreviewCopyWithImpl<$Res>
    implements _$SessionPreviewCopyWith<$Res> {
  __$SessionPreviewCopyWithImpl(this._self, this._then);

  final _SessionPreview _self;
  final $Res Function(_SessionPreview) _then;

/// Create a copy of SessionPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? subtotal = null,Object? total = null,}) {
  return _then(_SessionPreview(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as num,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$Player {

 String get id; String get displayName; String get status; num get walletTotal; String? get activeSessionId; int get stayDurationMinutes; DateTime? get createdAt;
/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerCopyWith<Player> get copyWith => _$PlayerCopyWithImpl<Player>(this as Player, _$identity);

  /// Serializes this Player to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Player&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.walletTotal, walletTotal) || other.walletTotal == walletTotal)&&(identical(other.activeSessionId, activeSessionId) || other.activeSessionId == activeSessionId)&&(identical(other.stayDurationMinutes, stayDurationMinutes) || other.stayDurationMinutes == stayDurationMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,status,walletTotal,activeSessionId,stayDurationMinutes,createdAt);

@override
String toString() {
  return 'Player(id: $id, displayName: $displayName, status: $status, walletTotal: $walletTotal, activeSessionId: $activeSessionId, stayDurationMinutes: $stayDurationMinutes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PlayerCopyWith<$Res>  {
  factory $PlayerCopyWith(Player value, $Res Function(Player) _then) = _$PlayerCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String status, num walletTotal, String? activeSessionId, int stayDurationMinutes, DateTime? createdAt
});




}
/// @nodoc
class _$PlayerCopyWithImpl<$Res>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._self, this._then);

  final Player _self;
  final $Res Function(Player) _then;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? status = null,Object? walletTotal = null,Object? activeSessionId = freezed,Object? stayDurationMinutes = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,walletTotal: null == walletTotal ? _self.walletTotal : walletTotal // ignore: cast_nullable_to_non_nullable
as num,activeSessionId: freezed == activeSessionId ? _self.activeSessionId : activeSessionId // ignore: cast_nullable_to_non_nullable
as String?,stayDurationMinutes: null == stayDurationMinutes ? _self.stayDurationMinutes : stayDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Player].
extension PlayerPatterns on Player {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Player value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Player() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Player value)  $default,){
final _that = this;
switch (_that) {
case _Player():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Player value)?  $default,){
final _that = this;
switch (_that) {
case _Player() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String status,  num walletTotal,  String? activeSessionId,  int stayDurationMinutes,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.displayName,_that.status,_that.walletTotal,_that.activeSessionId,_that.stayDurationMinutes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String status,  num walletTotal,  String? activeSessionId,  int stayDurationMinutes,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Player():
return $default(_that.id,_that.displayName,_that.status,_that.walletTotal,_that.activeSessionId,_that.stayDurationMinutes,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String status,  num walletTotal,  String? activeSessionId,  int stayDurationMinutes,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.displayName,_that.status,_that.walletTotal,_that.activeSessionId,_that.stayDurationMinutes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Player implements Player {
  const _Player({required this.id, required this.displayName, required this.status, this.walletTotal = 0, this.activeSessionId, this.stayDurationMinutes = 0, this.createdAt});
  factory _Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String status;
@override@JsonKey() final  num walletTotal;
@override final  String? activeSessionId;
@override@JsonKey() final  int stayDurationMinutes;
@override final  DateTime? createdAt;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerCopyWith<_Player> get copyWith => __$PlayerCopyWithImpl<_Player>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Player&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.walletTotal, walletTotal) || other.walletTotal == walletTotal)&&(identical(other.activeSessionId, activeSessionId) || other.activeSessionId == activeSessionId)&&(identical(other.stayDurationMinutes, stayDurationMinutes) || other.stayDurationMinutes == stayDurationMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,status,walletTotal,activeSessionId,stayDurationMinutes,createdAt);

@override
String toString() {
  return 'Player(id: $id, displayName: $displayName, status: $status, walletTotal: $walletTotal, activeSessionId: $activeSessionId, stayDurationMinutes: $stayDurationMinutes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$PlayerCopyWith(_Player value, $Res Function(_Player) _then) = __$PlayerCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String status, num walletTotal, String? activeSessionId, int stayDurationMinutes, DateTime? createdAt
});




}
/// @nodoc
class __$PlayerCopyWithImpl<$Res>
    implements _$PlayerCopyWith<$Res> {
  __$PlayerCopyWithImpl(this._self, this._then);

  final _Player _self;
  final $Res Function(_Player) _then;

/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? status = null,Object? walletTotal = null,Object? activeSessionId = freezed,Object? stayDurationMinutes = null,Object? createdAt = freezed,}) {
  return _then(_Player(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,walletTotal: null == walletTotal ? _self.walletTotal : walletTotal // ignore: cast_nullable_to_non_nullable
as num,activeSessionId: freezed == activeSessionId ? _self.activeSessionId : activeSessionId // ignore: cast_nullable_to_non_nullable
as String?,stayDurationMinutes: null == stayDurationMinutes ? _self.stayDurationMinutes : stayDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$AssetDefinition {

 String get type; String get code;@JsonKey(readValue: readDisplayName) String get displayName; bool get stackable;@JsonKey(readValue: readIsArchived) bool get isArchived;
/// Create a copy of AssetDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetDefinitionCopyWith<AssetDefinition> get copyWith => _$AssetDefinitionCopyWithImpl<AssetDefinition>(this as AssetDefinition, _$identity);

  /// Serializes this AssetDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetDefinition&&(identical(other.type, type) || other.type == type)&&(identical(other.code, code) || other.code == code)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.stackable, stackable) || other.stackable == stackable)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,code,displayName,stackable,isArchived);

@override
String toString() {
  return 'AssetDefinition(type: $type, code: $code, displayName: $displayName, stackable: $stackable, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class $AssetDefinitionCopyWith<$Res>  {
  factory $AssetDefinitionCopyWith(AssetDefinition value, $Res Function(AssetDefinition) _then) = _$AssetDefinitionCopyWithImpl;
@useResult
$Res call({
 String type, String code,@JsonKey(readValue: readDisplayName) String displayName, bool stackable,@JsonKey(readValue: readIsArchived) bool isArchived
});




}
/// @nodoc
class _$AssetDefinitionCopyWithImpl<$Res>
    implements $AssetDefinitionCopyWith<$Res> {
  _$AssetDefinitionCopyWithImpl(this._self, this._then);

  final AssetDefinition _self;
  final $Res Function(AssetDefinition) _then;

/// Create a copy of AssetDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? code = null,Object? displayName = null,Object? stackable = null,Object? isArchived = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,stackable: null == stackable ? _self.stackable : stackable // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetDefinition].
extension AssetDefinitionPatterns on AssetDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetDefinition value)  $default,){
final _that = this;
switch (_that) {
case _AssetDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _AssetDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String code, @JsonKey(readValue: readDisplayName)  String displayName,  bool stackable, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetDefinition() when $default != null:
return $default(_that.type,_that.code,_that.displayName,_that.stackable,_that.isArchived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String code, @JsonKey(readValue: readDisplayName)  String displayName,  bool stackable, @JsonKey(readValue: readIsArchived)  bool isArchived)  $default,) {final _that = this;
switch (_that) {
case _AssetDefinition():
return $default(_that.type,_that.code,_that.displayName,_that.stackable,_that.isArchived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String code, @JsonKey(readValue: readDisplayName)  String displayName,  bool stackable, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,) {final _that = this;
switch (_that) {
case _AssetDefinition() when $default != null:
return $default(_that.type,_that.code,_that.displayName,_that.stackable,_that.isArchived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetDefinition implements AssetDefinition {
  const _AssetDefinition({required this.type, required this.code, @JsonKey(readValue: readDisplayName) required this.displayName, this.stackable = true, @JsonKey(readValue: readIsArchived) this.isArchived = false});
  factory _AssetDefinition.fromJson(Map<String, dynamic> json) => _$AssetDefinitionFromJson(json);

@override final  String type;
@override final  String code;
@override@JsonKey(readValue: readDisplayName) final  String displayName;
@override@JsonKey() final  bool stackable;
@override@JsonKey(readValue: readIsArchived) final  bool isArchived;

/// Create a copy of AssetDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetDefinitionCopyWith<_AssetDefinition> get copyWith => __$AssetDefinitionCopyWithImpl<_AssetDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetDefinition&&(identical(other.type, type) || other.type == type)&&(identical(other.code, code) || other.code == code)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.stackable, stackable) || other.stackable == stackable)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,code,displayName,stackable,isArchived);

@override
String toString() {
  return 'AssetDefinition(type: $type, code: $code, displayName: $displayName, stackable: $stackable, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class _$AssetDefinitionCopyWith<$Res> implements $AssetDefinitionCopyWith<$Res> {
  factory _$AssetDefinitionCopyWith(_AssetDefinition value, $Res Function(_AssetDefinition) _then) = __$AssetDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String type, String code,@JsonKey(readValue: readDisplayName) String displayName, bool stackable,@JsonKey(readValue: readIsArchived) bool isArchived
});




}
/// @nodoc
class __$AssetDefinitionCopyWithImpl<$Res>
    implements _$AssetDefinitionCopyWith<$Res> {
  __$AssetDefinitionCopyWithImpl(this._self, this._then);

  final _AssetDefinition _self;
  final $Res Function(_AssetDefinition) _then;

/// Create a copy of AssetDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? code = null,Object? displayName = null,Object? stackable = null,Object? isArchived = null,}) {
  return _then(_AssetDefinition(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,stackable: null == stackable ? _self.stackable : stackable // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AssetHolding {

 String get assetType; String get assetCode; String? get assetName;@JsonKey(readValue: readAmount) num get amount;
/// Create a copy of AssetHolding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetHoldingCopyWith<AssetHolding> get copyWith => _$AssetHoldingCopyWithImpl<AssetHolding>(this as AssetHolding, _$identity);

  /// Serializes this AssetHolding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetHolding&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetType,assetCode,assetName,amount);

@override
String toString() {
  return 'AssetHolding(assetType: $assetType, assetCode: $assetCode, assetName: $assetName, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $AssetHoldingCopyWith<$Res>  {
  factory $AssetHoldingCopyWith(AssetHolding value, $Res Function(AssetHolding) _then) = _$AssetHoldingCopyWithImpl;
@useResult
$Res call({
 String assetType, String assetCode, String? assetName,@JsonKey(readValue: readAmount) num amount
});




}
/// @nodoc
class _$AssetHoldingCopyWithImpl<$Res>
    implements $AssetHoldingCopyWith<$Res> {
  _$AssetHoldingCopyWithImpl(this._self, this._then);

  final AssetHolding _self;
  final $Res Function(AssetHolding) _then;

/// Create a copy of AssetHolding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assetType = null,Object? assetCode = null,Object? assetName = freezed,Object? amount = null,}) {
  return _then(_self.copyWith(
assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,assetName: freezed == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetHolding].
extension AssetHoldingPatterns on AssetHolding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetHolding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetHolding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetHolding value)  $default,){
final _that = this;
switch (_that) {
case _AssetHolding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetHolding value)?  $default,){
final _that = this;
switch (_that) {
case _AssetHolding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetHolding() when $default != null:
return $default(_that.assetType,_that.assetCode,_that.assetName,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount)  $default,) {final _that = this;
switch (_that) {
case _AssetHolding():
return $default(_that.assetType,_that.assetCode,_that.assetName,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount)?  $default,) {final _that = this;
switch (_that) {
case _AssetHolding() when $default != null:
return $default(_that.assetType,_that.assetCode,_that.assetName,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetHolding implements AssetHolding {
  const _AssetHolding({required this.assetType, required this.assetCode, this.assetName, @JsonKey(readValue: readAmount) required this.amount});
  factory _AssetHolding.fromJson(Map<String, dynamic> json) => _$AssetHoldingFromJson(json);

@override final  String assetType;
@override final  String assetCode;
@override final  String? assetName;
@override@JsonKey(readValue: readAmount) final  num amount;

/// Create a copy of AssetHolding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetHoldingCopyWith<_AssetHolding> get copyWith => __$AssetHoldingCopyWithImpl<_AssetHolding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetHoldingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetHolding&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetType,assetCode,assetName,amount);

@override
String toString() {
  return 'AssetHolding(assetType: $assetType, assetCode: $assetCode, assetName: $assetName, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$AssetHoldingCopyWith<$Res> implements $AssetHoldingCopyWith<$Res> {
  factory _$AssetHoldingCopyWith(_AssetHolding value, $Res Function(_AssetHolding) _then) = __$AssetHoldingCopyWithImpl;
@override @useResult
$Res call({
 String assetType, String assetCode, String? assetName,@JsonKey(readValue: readAmount) num amount
});




}
/// @nodoc
class __$AssetHoldingCopyWithImpl<$Res>
    implements _$AssetHoldingCopyWith<$Res> {
  __$AssetHoldingCopyWithImpl(this._self, this._then);

  final _AssetHolding _self;
  final $Res Function(_AssetHolding) _then;

/// Create a copy of AssetHolding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assetType = null,Object? assetCode = null,Object? assetName = freezed,Object? amount = null,}) {
  return _then(_AssetHolding(
assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,assetName: freezed == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$AssetLedgerEntry {

 String get id; String get assetType; String get assetCode; String? get assetName;@JsonKey(readValue: readAmount) num get amount;@JsonKey(readValue: readDirection) String get direction; String get reason; DateTime get createdAt;
/// Create a copy of AssetLedgerEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetLedgerEntryCopyWith<AssetLedgerEntry> get copyWith => _$AssetLedgerEntryCopyWithImpl<AssetLedgerEntry>(this as AssetLedgerEntry, _$identity);

  /// Serializes this AssetLedgerEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetLedgerEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,assetType,assetCode,assetName,amount,direction,reason,createdAt);

@override
String toString() {
  return 'AssetLedgerEntry(id: $id, assetType: $assetType, assetCode: $assetCode, assetName: $assetName, amount: $amount, direction: $direction, reason: $reason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AssetLedgerEntryCopyWith<$Res>  {
  factory $AssetLedgerEntryCopyWith(AssetLedgerEntry value, $Res Function(AssetLedgerEntry) _then) = _$AssetLedgerEntryCopyWithImpl;
@useResult
$Res call({
 String id, String assetType, String assetCode, String? assetName,@JsonKey(readValue: readAmount) num amount,@JsonKey(readValue: readDirection) String direction, String reason, DateTime createdAt
});




}
/// @nodoc
class _$AssetLedgerEntryCopyWithImpl<$Res>
    implements $AssetLedgerEntryCopyWith<$Res> {
  _$AssetLedgerEntryCopyWithImpl(this._self, this._then);

  final AssetLedgerEntry _self;
  final $Res Function(AssetLedgerEntry) _then;

/// Create a copy of AssetLedgerEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? assetType = null,Object? assetCode = null,Object? assetName = freezed,Object? amount = null,Object? direction = null,Object? reason = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,assetName: freezed == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetLedgerEntry].
extension AssetLedgerEntryPatterns on AssetLedgerEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetLedgerEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetLedgerEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetLedgerEntry value)  $default,){
final _that = this;
switch (_that) {
case _AssetLedgerEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetLedgerEntry value)?  $default,){
final _that = this;
switch (_that) {
case _AssetLedgerEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount, @JsonKey(readValue: readDirection)  String direction,  String reason,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetLedgerEntry() when $default != null:
return $default(_that.id,_that.assetType,_that.assetCode,_that.assetName,_that.amount,_that.direction,_that.reason,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount, @JsonKey(readValue: readDirection)  String direction,  String reason,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AssetLedgerEntry():
return $default(_that.id,_that.assetType,_that.assetCode,_that.assetName,_that.amount,_that.direction,_that.reason,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount, @JsonKey(readValue: readDirection)  String direction,  String reason,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AssetLedgerEntry() when $default != null:
return $default(_that.id,_that.assetType,_that.assetCode,_that.assetName,_that.amount,_that.direction,_that.reason,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetLedgerEntry implements AssetLedgerEntry {
  const _AssetLedgerEntry({this.id = '', required this.assetType, required this.assetCode, this.assetName, @JsonKey(readValue: readAmount) required this.amount, @JsonKey(readValue: readDirection) required this.direction, required this.reason, required this.createdAt});
  factory _AssetLedgerEntry.fromJson(Map<String, dynamic> json) => _$AssetLedgerEntryFromJson(json);

@override@JsonKey() final  String id;
@override final  String assetType;
@override final  String assetCode;
@override final  String? assetName;
@override@JsonKey(readValue: readAmount) final  num amount;
@override@JsonKey(readValue: readDirection) final  String direction;
@override final  String reason;
@override final  DateTime createdAt;

/// Create a copy of AssetLedgerEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetLedgerEntryCopyWith<_AssetLedgerEntry> get copyWith => __$AssetLedgerEntryCopyWithImpl<_AssetLedgerEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetLedgerEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetLedgerEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,assetType,assetCode,assetName,amount,direction,reason,createdAt);

@override
String toString() {
  return 'AssetLedgerEntry(id: $id, assetType: $assetType, assetCode: $assetCode, assetName: $assetName, amount: $amount, direction: $direction, reason: $reason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AssetLedgerEntryCopyWith<$Res> implements $AssetLedgerEntryCopyWith<$Res> {
  factory _$AssetLedgerEntryCopyWith(_AssetLedgerEntry value, $Res Function(_AssetLedgerEntry) _then) = __$AssetLedgerEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String assetType, String assetCode, String? assetName,@JsonKey(readValue: readAmount) num amount,@JsonKey(readValue: readDirection) String direction, String reason, DateTime createdAt
});




}
/// @nodoc
class __$AssetLedgerEntryCopyWithImpl<$Res>
    implements _$AssetLedgerEntryCopyWith<$Res> {
  __$AssetLedgerEntryCopyWithImpl(this._self, this._then);

  final _AssetLedgerEntry _self;
  final $Res Function(_AssetLedgerEntry) _then;

/// Create a copy of AssetLedgerEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? assetType = null,Object? assetCode = null,Object? assetName = freezed,Object? amount = null,Object? direction = null,Object? reason = null,Object? createdAt = null,}) {
  return _then(_AssetLedgerEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,assetName: freezed == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PlayerAssets {

 String get playerId; List<AssetHolding> get holdings;@JsonKey(readValue: readLedger) List<AssetLedgerEntry> get ledger;
/// Create a copy of PlayerAssets
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerAssetsCopyWith<PlayerAssets> get copyWith => _$PlayerAssetsCopyWithImpl<PlayerAssets>(this as PlayerAssets, _$identity);

  /// Serializes this PlayerAssets to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerAssets&&(identical(other.playerId, playerId) || other.playerId == playerId)&&const DeepCollectionEquality().equals(other.holdings, holdings)&&const DeepCollectionEquality().equals(other.ledger, ledger));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,const DeepCollectionEquality().hash(holdings),const DeepCollectionEquality().hash(ledger));

@override
String toString() {
  return 'PlayerAssets(playerId: $playerId, holdings: $holdings, ledger: $ledger)';
}


}

/// @nodoc
abstract mixin class $PlayerAssetsCopyWith<$Res>  {
  factory $PlayerAssetsCopyWith(PlayerAssets value, $Res Function(PlayerAssets) _then) = _$PlayerAssetsCopyWithImpl;
@useResult
$Res call({
 String playerId, List<AssetHolding> holdings,@JsonKey(readValue: readLedger) List<AssetLedgerEntry> ledger
});




}
/// @nodoc
class _$PlayerAssetsCopyWithImpl<$Res>
    implements $PlayerAssetsCopyWith<$Res> {
  _$PlayerAssetsCopyWithImpl(this._self, this._then);

  final PlayerAssets _self;
  final $Res Function(PlayerAssets) _then;

/// Create a copy of PlayerAssets
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? holdings = null,Object? ledger = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,holdings: null == holdings ? _self.holdings : holdings // ignore: cast_nullable_to_non_nullable
as List<AssetHolding>,ledger: null == ledger ? _self.ledger : ledger // ignore: cast_nullable_to_non_nullable
as List<AssetLedgerEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerAssets].
extension PlayerAssetsPatterns on PlayerAssets {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerAssets value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerAssets() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerAssets value)  $default,){
final _that = this;
switch (_that) {
case _PlayerAssets():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerAssets value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerAssets() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  List<AssetHolding> holdings, @JsonKey(readValue: readLedger)  List<AssetLedgerEntry> ledger)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerAssets() when $default != null:
return $default(_that.playerId,_that.holdings,_that.ledger);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  List<AssetHolding> holdings, @JsonKey(readValue: readLedger)  List<AssetLedgerEntry> ledger)  $default,) {final _that = this;
switch (_that) {
case _PlayerAssets():
return $default(_that.playerId,_that.holdings,_that.ledger);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  List<AssetHolding> holdings, @JsonKey(readValue: readLedger)  List<AssetLedgerEntry> ledger)?  $default,) {final _that = this;
switch (_that) {
case _PlayerAssets() when $default != null:
return $default(_that.playerId,_that.holdings,_that.ledger);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerAssets implements PlayerAssets {
  const _PlayerAssets({this.playerId = '', required final  List<AssetHolding> holdings, @JsonKey(readValue: readLedger) required final  List<AssetLedgerEntry> ledger}): _holdings = holdings,_ledger = ledger;
  factory _PlayerAssets.fromJson(Map<String, dynamic> json) => _$PlayerAssetsFromJson(json);

@override@JsonKey() final  String playerId;
 final  List<AssetHolding> _holdings;
@override List<AssetHolding> get holdings {
  if (_holdings is EqualUnmodifiableListView) return _holdings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_holdings);
}

 final  List<AssetLedgerEntry> _ledger;
@override@JsonKey(readValue: readLedger) List<AssetLedgerEntry> get ledger {
  if (_ledger is EqualUnmodifiableListView) return _ledger;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ledger);
}


/// Create a copy of PlayerAssets
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerAssetsCopyWith<_PlayerAssets> get copyWith => __$PlayerAssetsCopyWithImpl<_PlayerAssets>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerAssetsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerAssets&&(identical(other.playerId, playerId) || other.playerId == playerId)&&const DeepCollectionEquality().equals(other._holdings, _holdings)&&const DeepCollectionEquality().equals(other._ledger, _ledger));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,const DeepCollectionEquality().hash(_holdings),const DeepCollectionEquality().hash(_ledger));

@override
String toString() {
  return 'PlayerAssets(playerId: $playerId, holdings: $holdings, ledger: $ledger)';
}


}

/// @nodoc
abstract mixin class _$PlayerAssetsCopyWith<$Res> implements $PlayerAssetsCopyWith<$Res> {
  factory _$PlayerAssetsCopyWith(_PlayerAssets value, $Res Function(_PlayerAssets) _then) = __$PlayerAssetsCopyWithImpl;
@override @useResult
$Res call({
 String playerId, List<AssetHolding> holdings,@JsonKey(readValue: readLedger) List<AssetLedgerEntry> ledger
});




}
/// @nodoc
class __$PlayerAssetsCopyWithImpl<$Res>
    implements _$PlayerAssetsCopyWith<$Res> {
  __$PlayerAssetsCopyWithImpl(this._self, this._then);

  final _PlayerAssets _self;
  final $Res Function(_PlayerAssets) _then;

/// Create a copy of PlayerAssets
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? holdings = null,Object? ledger = null,}) {
  return _then(_PlayerAssets(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,holdings: null == holdings ? _self._holdings : holdings // ignore: cast_nullable_to_non_nullable
as List<AssetHolding>,ledger: null == ledger ? _self._ledger : ledger // ignore: cast_nullable_to_non_nullable
as List<AssetLedgerEntry>,
  ));
}


}


/// @nodoc
mixin _$AssetGrant {

 String get assetType; String get assetCode; num get amount;
/// Create a copy of AssetGrant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetGrantCopyWith<AssetGrant> get copyWith => _$AssetGrantCopyWithImpl<AssetGrant>(this as AssetGrant, _$identity);

  /// Serializes this AssetGrant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetGrant&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetType,assetCode,amount);

@override
String toString() {
  return 'AssetGrant(assetType: $assetType, assetCode: $assetCode, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $AssetGrantCopyWith<$Res>  {
  factory $AssetGrantCopyWith(AssetGrant value, $Res Function(AssetGrant) _then) = _$AssetGrantCopyWithImpl;
@useResult
$Res call({
 String assetType, String assetCode, num amount
});




}
/// @nodoc
class _$AssetGrantCopyWithImpl<$Res>
    implements $AssetGrantCopyWith<$Res> {
  _$AssetGrantCopyWithImpl(this._self, this._then);

  final AssetGrant _self;
  final $Res Function(AssetGrant) _then;

/// Create a copy of AssetGrant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assetType = null,Object? assetCode = null,Object? amount = null,}) {
  return _then(_self.copyWith(
assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetGrant].
extension AssetGrantPatterns on AssetGrant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetGrant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetGrant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetGrant value)  $default,){
final _that = this;
switch (_that) {
case _AssetGrant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetGrant value)?  $default,){
final _that = this;
switch (_that) {
case _AssetGrant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String assetType,  String assetCode,  num amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetGrant() when $default != null:
return $default(_that.assetType,_that.assetCode,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String assetType,  String assetCode,  num amount)  $default,) {final _that = this;
switch (_that) {
case _AssetGrant():
return $default(_that.assetType,_that.assetCode,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String assetType,  String assetCode,  num amount)?  $default,) {final _that = this;
switch (_that) {
case _AssetGrant() when $default != null:
return $default(_that.assetType,_that.assetCode,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetGrant implements AssetGrant {
  const _AssetGrant({required this.assetType, required this.assetCode, required this.amount});
  factory _AssetGrant.fromJson(Map<String, dynamic> json) => _$AssetGrantFromJson(json);

@override final  String assetType;
@override final  String assetCode;
@override final  num amount;

/// Create a copy of AssetGrant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetGrantCopyWith<_AssetGrant> get copyWith => __$AssetGrantCopyWithImpl<_AssetGrant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetGrantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetGrant&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetType,assetCode,amount);

@override
String toString() {
  return 'AssetGrant(assetType: $assetType, assetCode: $assetCode, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$AssetGrantCopyWith<$Res> implements $AssetGrantCopyWith<$Res> {
  factory _$AssetGrantCopyWith(_AssetGrant value, $Res Function(_AssetGrant) _then) = __$AssetGrantCopyWithImpl;
@override @useResult
$Res call({
 String assetType, String assetCode, num amount
});




}
/// @nodoc
class __$AssetGrantCopyWithImpl<$Res>
    implements _$AssetGrantCopyWith<$Res> {
  __$AssetGrantCopyWithImpl(this._self, this._then);

  final _AssetGrant _self;
  final $Res Function(_AssetGrant) _then;

/// Create a copy of AssetGrant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assetType = null,Object? assetCode = null,Object? amount = null,}) {
  return _then(_AssetGrant(
assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$Present {

 String get id; String get name; List<AssetGrant> get grants; bool get oncePerPlayer;@JsonKey(readValue: readIsArchived) bool get isArchived;
/// Create a copy of Present
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresentCopyWith<Present> get copyWith => _$PresentCopyWithImpl<Present>(this as Present, _$identity);

  /// Serializes this Present to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Present&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.grants, grants)&&(identical(other.oncePerPlayer, oncePerPlayer) || other.oncePerPlayer == oncePerPlayer)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(grants),oncePerPlayer,isArchived);

@override
String toString() {
  return 'Present(id: $id, name: $name, grants: $grants, oncePerPlayer: $oncePerPlayer, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class $PresentCopyWith<$Res>  {
  factory $PresentCopyWith(Present value, $Res Function(Present) _then) = _$PresentCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<AssetGrant> grants, bool oncePerPlayer,@JsonKey(readValue: readIsArchived) bool isArchived
});




}
/// @nodoc
class _$PresentCopyWithImpl<$Res>
    implements $PresentCopyWith<$Res> {
  _$PresentCopyWithImpl(this._self, this._then);

  final Present _self;
  final $Res Function(Present) _then;

/// Create a copy of Present
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? grants = null,Object? oncePerPlayer = null,Object? isArchived = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,grants: null == grants ? _self.grants : grants // ignore: cast_nullable_to_non_nullable
as List<AssetGrant>,oncePerPlayer: null == oncePerPlayer ? _self.oncePerPlayer : oncePerPlayer // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Present].
extension PresentPatterns on Present {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Present value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Present() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Present value)  $default,){
final _that = this;
switch (_that) {
case _Present():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Present value)?  $default,){
final _that = this;
switch (_that) {
case _Present() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<AssetGrant> grants,  bool oncePerPlayer, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Present() when $default != null:
return $default(_that.id,_that.name,_that.grants,_that.oncePerPlayer,_that.isArchived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<AssetGrant> grants,  bool oncePerPlayer, @JsonKey(readValue: readIsArchived)  bool isArchived)  $default,) {final _that = this;
switch (_that) {
case _Present():
return $default(_that.id,_that.name,_that.grants,_that.oncePerPlayer,_that.isArchived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<AssetGrant> grants,  bool oncePerPlayer, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,) {final _that = this;
switch (_that) {
case _Present() when $default != null:
return $default(_that.id,_that.name,_that.grants,_that.oncePerPlayer,_that.isArchived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Present implements Present {
  const _Present({required this.id, required this.name, required final  List<AssetGrant> grants, this.oncePerPlayer = false, @JsonKey(readValue: readIsArchived) this.isArchived = false}): _grants = grants;
  factory _Present.fromJson(Map<String, dynamic> json) => _$PresentFromJson(json);

@override final  String id;
@override final  String name;
 final  List<AssetGrant> _grants;
@override List<AssetGrant> get grants {
  if (_grants is EqualUnmodifiableListView) return _grants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_grants);
}

@override@JsonKey() final  bool oncePerPlayer;
@override@JsonKey(readValue: readIsArchived) final  bool isArchived;

/// Create a copy of Present
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PresentCopyWith<_Present> get copyWith => __$PresentCopyWithImpl<_Present>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PresentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Present&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._grants, _grants)&&(identical(other.oncePerPlayer, oncePerPlayer) || other.oncePerPlayer == oncePerPlayer)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_grants),oncePerPlayer,isArchived);

@override
String toString() {
  return 'Present(id: $id, name: $name, grants: $grants, oncePerPlayer: $oncePerPlayer, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class _$PresentCopyWith<$Res> implements $PresentCopyWith<$Res> {
  factory _$PresentCopyWith(_Present value, $Res Function(_Present) _then) = __$PresentCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<AssetGrant> grants, bool oncePerPlayer,@JsonKey(readValue: readIsArchived) bool isArchived
});




}
/// @nodoc
class __$PresentCopyWithImpl<$Res>
    implements _$PresentCopyWith<$Res> {
  __$PresentCopyWithImpl(this._self, this._then);

  final _Present _self;
  final $Res Function(_Present) _then;

/// Create a copy of Present
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? grants = null,Object? oncePerPlayer = null,Object? isArchived = null,}) {
  return _then(_Present(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,grants: null == grants ? _self._grants : grants // ignore: cast_nullable_to_non_nullable
as List<AssetGrant>,oncePerPlayer: null == oncePerPlayer ? _self.oncePerPlayer : oncePerPlayer // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$RedeemCode {

 String get id; String get code; String? get presentId; DateTime? get activeAt; List<AssetGrant> get grants;@JsonKey(readValue: readUsageLimit) int get usageLimit; int get usageCount; DateTime? get expiresAt; bool get isRevoked; DateTime? get createdAt;
/// Create a copy of RedeemCode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RedeemCodeCopyWith<RedeemCode> get copyWith => _$RedeemCodeCopyWithImpl<RedeemCode>(this as RedeemCode, _$identity);

  /// Serializes this RedeemCode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RedeemCode&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.presentId, presentId) || other.presentId == presentId)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&const DeepCollectionEquality().equals(other.grants, grants)&&(identical(other.usageLimit, usageLimit) || other.usageLimit == usageLimit)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isRevoked, isRevoked) || other.isRevoked == isRevoked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,presentId,activeAt,const DeepCollectionEquality().hash(grants),usageLimit,usageCount,expiresAt,isRevoked,createdAt);

@override
String toString() {
  return 'RedeemCode(id: $id, code: $code, presentId: $presentId, activeAt: $activeAt, grants: $grants, usageLimit: $usageLimit, usageCount: $usageCount, expiresAt: $expiresAt, isRevoked: $isRevoked, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RedeemCodeCopyWith<$Res>  {
  factory $RedeemCodeCopyWith(RedeemCode value, $Res Function(RedeemCode) _then) = _$RedeemCodeCopyWithImpl;
@useResult
$Res call({
 String id, String code, String? presentId, DateTime? activeAt, List<AssetGrant> grants,@JsonKey(readValue: readUsageLimit) int usageLimit, int usageCount, DateTime? expiresAt, bool isRevoked, DateTime? createdAt
});




}
/// @nodoc
class _$RedeemCodeCopyWithImpl<$Res>
    implements $RedeemCodeCopyWith<$Res> {
  _$RedeemCodeCopyWithImpl(this._self, this._then);

  final RedeemCode _self;
  final $Res Function(RedeemCode) _then;

/// Create a copy of RedeemCode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? presentId = freezed,Object? activeAt = freezed,Object? grants = null,Object? usageLimit = null,Object? usageCount = null,Object? expiresAt = freezed,Object? isRevoked = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,presentId: freezed == presentId ? _self.presentId : presentId // ignore: cast_nullable_to_non_nullable
as String?,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,grants: null == grants ? _self.grants : grants // ignore: cast_nullable_to_non_nullable
as List<AssetGrant>,usageLimit: null == usageLimit ? _self.usageLimit : usageLimit // ignore: cast_nullable_to_non_nullable
as int,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isRevoked: null == isRevoked ? _self.isRevoked : isRevoked // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RedeemCode].
extension RedeemCodePatterns on RedeemCode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RedeemCode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RedeemCode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RedeemCode value)  $default,){
final _that = this;
switch (_that) {
case _RedeemCode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RedeemCode value)?  $default,){
final _that = this;
switch (_that) {
case _RedeemCode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String? presentId,  DateTime? activeAt,  List<AssetGrant> grants, @JsonKey(readValue: readUsageLimit)  int usageLimit,  int usageCount,  DateTime? expiresAt,  bool isRevoked,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RedeemCode() when $default != null:
return $default(_that.id,_that.code,_that.presentId,_that.activeAt,_that.grants,_that.usageLimit,_that.usageCount,_that.expiresAt,_that.isRevoked,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String? presentId,  DateTime? activeAt,  List<AssetGrant> grants, @JsonKey(readValue: readUsageLimit)  int usageLimit,  int usageCount,  DateTime? expiresAt,  bool isRevoked,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _RedeemCode():
return $default(_that.id,_that.code,_that.presentId,_that.activeAt,_that.grants,_that.usageLimit,_that.usageCount,_that.expiresAt,_that.isRevoked,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String? presentId,  DateTime? activeAt,  List<AssetGrant> grants, @JsonKey(readValue: readUsageLimit)  int usageLimit,  int usageCount,  DateTime? expiresAt,  bool isRevoked,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RedeemCode() when $default != null:
return $default(_that.id,_that.code,_that.presentId,_that.activeAt,_that.grants,_that.usageLimit,_that.usageCount,_that.expiresAt,_that.isRevoked,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RedeemCode implements RedeemCode {
  const _RedeemCode({required this.id, required this.code, this.presentId, this.activeAt, final  List<AssetGrant> grants = const [], @JsonKey(readValue: readUsageLimit) this.usageLimit = 1, this.usageCount = 0, this.expiresAt, this.isRevoked = false, this.createdAt}): _grants = grants;
  factory _RedeemCode.fromJson(Map<String, dynamic> json) => _$RedeemCodeFromJson(json);

@override final  String id;
@override final  String code;
@override final  String? presentId;
@override final  DateTime? activeAt;
 final  List<AssetGrant> _grants;
@override@JsonKey() List<AssetGrant> get grants {
  if (_grants is EqualUnmodifiableListView) return _grants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_grants);
}

@override@JsonKey(readValue: readUsageLimit) final  int usageLimit;
@override@JsonKey() final  int usageCount;
@override final  DateTime? expiresAt;
@override@JsonKey() final  bool isRevoked;
@override final  DateTime? createdAt;

/// Create a copy of RedeemCode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RedeemCodeCopyWith<_RedeemCode> get copyWith => __$RedeemCodeCopyWithImpl<_RedeemCode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RedeemCodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RedeemCode&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.presentId, presentId) || other.presentId == presentId)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&const DeepCollectionEquality().equals(other._grants, _grants)&&(identical(other.usageLimit, usageLimit) || other.usageLimit == usageLimit)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isRevoked, isRevoked) || other.isRevoked == isRevoked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,presentId,activeAt,const DeepCollectionEquality().hash(_grants),usageLimit,usageCount,expiresAt,isRevoked,createdAt);

@override
String toString() {
  return 'RedeemCode(id: $id, code: $code, presentId: $presentId, activeAt: $activeAt, grants: $grants, usageLimit: $usageLimit, usageCount: $usageCount, expiresAt: $expiresAt, isRevoked: $isRevoked, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RedeemCodeCopyWith<$Res> implements $RedeemCodeCopyWith<$Res> {
  factory _$RedeemCodeCopyWith(_RedeemCode value, $Res Function(_RedeemCode) _then) = __$RedeemCodeCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String? presentId, DateTime? activeAt, List<AssetGrant> grants,@JsonKey(readValue: readUsageLimit) int usageLimit, int usageCount, DateTime? expiresAt, bool isRevoked, DateTime? createdAt
});




}
/// @nodoc
class __$RedeemCodeCopyWithImpl<$Res>
    implements _$RedeemCodeCopyWith<$Res> {
  __$RedeemCodeCopyWithImpl(this._self, this._then);

  final _RedeemCode _self;
  final $Res Function(_RedeemCode) _then;

/// Create a copy of RedeemCode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? presentId = freezed,Object? activeAt = freezed,Object? grants = null,Object? usageLimit = null,Object? usageCount = null,Object? expiresAt = freezed,Object? isRevoked = null,Object? createdAt = freezed,}) {
  return _then(_RedeemCode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,presentId: freezed == presentId ? _self.presentId : presentId // ignore: cast_nullable_to_non_nullable
as String?,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,grants: null == grants ? _self._grants : grants // ignore: cast_nullable_to_non_nullable
as List<AssetGrant>,usageLimit: null == usageLimit ? _self.usageLimit : usageLimit // ignore: cast_nullable_to_non_nullable
as int,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isRevoked: null == isRevoked ? _self.isRevoked : isRevoked // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PriorityTimeRule {

 String get label; int get priority; String get startTime; String get endTime; List<int> get weekdays; String? get specificDate; String? get startDateTime; String? get endDateTime; int get unitMinutes; num get unitPrice; int get graceMinutes; num? get priceCap;
/// Create a copy of PriorityTimeRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriorityTimeRuleCopyWith<PriorityTimeRule> get copyWith => _$PriorityTimeRuleCopyWithImpl<PriorityTimeRule>(this as PriorityTimeRule, _$identity);

  /// Serializes this PriorityTimeRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriorityTimeRule&&(identical(other.label, label) || other.label == label)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other.weekdays, weekdays)&&(identical(other.specificDate, specificDate) || other.specificDate == specificDate)&&(identical(other.startDateTime, startDateTime) || other.startDateTime == startDateTime)&&(identical(other.endDateTime, endDateTime) || other.endDateTime == endDateTime)&&(identical(other.unitMinutes, unitMinutes) || other.unitMinutes == unitMinutes)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.graceMinutes, graceMinutes) || other.graceMinutes == graceMinutes)&&(identical(other.priceCap, priceCap) || other.priceCap == priceCap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,priority,startTime,endTime,const DeepCollectionEquality().hash(weekdays),specificDate,startDateTime,endDateTime,unitMinutes,unitPrice,graceMinutes,priceCap);

@override
String toString() {
  return 'PriorityTimeRule(label: $label, priority: $priority, startTime: $startTime, endTime: $endTime, weekdays: $weekdays, specificDate: $specificDate, startDateTime: $startDateTime, endDateTime: $endDateTime, unitMinutes: $unitMinutes, unitPrice: $unitPrice, graceMinutes: $graceMinutes, priceCap: $priceCap)';
}


}

/// @nodoc
abstract mixin class $PriorityTimeRuleCopyWith<$Res>  {
  factory $PriorityTimeRuleCopyWith(PriorityTimeRule value, $Res Function(PriorityTimeRule) _then) = _$PriorityTimeRuleCopyWithImpl;
@useResult
$Res call({
 String label, int priority, String startTime, String endTime, List<int> weekdays, String? specificDate, String? startDateTime, String? endDateTime, int unitMinutes, num unitPrice, int graceMinutes, num? priceCap
});




}
/// @nodoc
class _$PriorityTimeRuleCopyWithImpl<$Res>
    implements $PriorityTimeRuleCopyWith<$Res> {
  _$PriorityTimeRuleCopyWithImpl(this._self, this._then);

  final PriorityTimeRule _self;
  final $Res Function(PriorityTimeRule) _then;

/// Create a copy of PriorityTimeRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? priority = null,Object? startTime = null,Object? endTime = null,Object? weekdays = null,Object? specificDate = freezed,Object? startDateTime = freezed,Object? endDateTime = freezed,Object? unitMinutes = null,Object? unitPrice = null,Object? graceMinutes = null,Object? priceCap = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,weekdays: null == weekdays ? _self.weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as List<int>,specificDate: freezed == specificDate ? _self.specificDate : specificDate // ignore: cast_nullable_to_non_nullable
as String?,startDateTime: freezed == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as String?,endDateTime: freezed == endDateTime ? _self.endDateTime : endDateTime // ignore: cast_nullable_to_non_nullable
as String?,unitMinutes: null == unitMinutes ? _self.unitMinutes : unitMinutes // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as num,graceMinutes: null == graceMinutes ? _self.graceMinutes : graceMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCap: freezed == priceCap ? _self.priceCap : priceCap // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [PriorityTimeRule].
extension PriorityTimeRulePatterns on PriorityTimeRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriorityTimeRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriorityTimeRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriorityTimeRule value)  $default,){
final _that = this;
switch (_that) {
case _PriorityTimeRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriorityTimeRule value)?  $default,){
final _that = this;
switch (_that) {
case _PriorityTimeRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  int priority,  String startTime,  String endTime,  List<int> weekdays,  String? specificDate,  String? startDateTime,  String? endDateTime,  int unitMinutes,  num unitPrice,  int graceMinutes,  num? priceCap)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriorityTimeRule() when $default != null:
return $default(_that.label,_that.priority,_that.startTime,_that.endTime,_that.weekdays,_that.specificDate,_that.startDateTime,_that.endDateTime,_that.unitMinutes,_that.unitPrice,_that.graceMinutes,_that.priceCap);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  int priority,  String startTime,  String endTime,  List<int> weekdays,  String? specificDate,  String? startDateTime,  String? endDateTime,  int unitMinutes,  num unitPrice,  int graceMinutes,  num? priceCap)  $default,) {final _that = this;
switch (_that) {
case _PriorityTimeRule():
return $default(_that.label,_that.priority,_that.startTime,_that.endTime,_that.weekdays,_that.specificDate,_that.startDateTime,_that.endDateTime,_that.unitMinutes,_that.unitPrice,_that.graceMinutes,_that.priceCap);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  int priority,  String startTime,  String endTime,  List<int> weekdays,  String? specificDate,  String? startDateTime,  String? endDateTime,  int unitMinutes,  num unitPrice,  int graceMinutes,  num? priceCap)?  $default,) {final _that = this;
switch (_that) {
case _PriorityTimeRule() when $default != null:
return $default(_that.label,_that.priority,_that.startTime,_that.endTime,_that.weekdays,_that.specificDate,_that.startDateTime,_that.endDateTime,_that.unitMinutes,_that.unitPrice,_that.graceMinutes,_that.priceCap);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PriorityTimeRule implements PriorityTimeRule {
  const _PriorityTimeRule({required this.label, required this.priority, required this.startTime, required this.endTime, required final  List<int> weekdays, this.specificDate, this.startDateTime, this.endDateTime, required this.unitMinutes, required this.unitPrice, required this.graceMinutes, this.priceCap}): _weekdays = weekdays;
  factory _PriorityTimeRule.fromJson(Map<String, dynamic> json) => _$PriorityTimeRuleFromJson(json);

@override final  String label;
@override final  int priority;
@override final  String startTime;
@override final  String endTime;
 final  List<int> _weekdays;
@override List<int> get weekdays {
  if (_weekdays is EqualUnmodifiableListView) return _weekdays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekdays);
}

@override final  String? specificDate;
@override final  String? startDateTime;
@override final  String? endDateTime;
@override final  int unitMinutes;
@override final  num unitPrice;
@override final  int graceMinutes;
@override final  num? priceCap;

/// Create a copy of PriorityTimeRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriorityTimeRuleCopyWith<_PriorityTimeRule> get copyWith => __$PriorityTimeRuleCopyWithImpl<_PriorityTimeRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PriorityTimeRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriorityTimeRule&&(identical(other.label, label) || other.label == label)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other._weekdays, _weekdays)&&(identical(other.specificDate, specificDate) || other.specificDate == specificDate)&&(identical(other.startDateTime, startDateTime) || other.startDateTime == startDateTime)&&(identical(other.endDateTime, endDateTime) || other.endDateTime == endDateTime)&&(identical(other.unitMinutes, unitMinutes) || other.unitMinutes == unitMinutes)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.graceMinutes, graceMinutes) || other.graceMinutes == graceMinutes)&&(identical(other.priceCap, priceCap) || other.priceCap == priceCap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,priority,startTime,endTime,const DeepCollectionEquality().hash(_weekdays),specificDate,startDateTime,endDateTime,unitMinutes,unitPrice,graceMinutes,priceCap);

@override
String toString() {
  return 'PriorityTimeRule(label: $label, priority: $priority, startTime: $startTime, endTime: $endTime, weekdays: $weekdays, specificDate: $specificDate, startDateTime: $startDateTime, endDateTime: $endDateTime, unitMinutes: $unitMinutes, unitPrice: $unitPrice, graceMinutes: $graceMinutes, priceCap: $priceCap)';
}


}

/// @nodoc
abstract mixin class _$PriorityTimeRuleCopyWith<$Res> implements $PriorityTimeRuleCopyWith<$Res> {
  factory _$PriorityTimeRuleCopyWith(_PriorityTimeRule value, $Res Function(_PriorityTimeRule) _then) = __$PriorityTimeRuleCopyWithImpl;
@override @useResult
$Res call({
 String label, int priority, String startTime, String endTime, List<int> weekdays, String? specificDate, String? startDateTime, String? endDateTime, int unitMinutes, num unitPrice, int graceMinutes, num? priceCap
});




}
/// @nodoc
class __$PriorityTimeRuleCopyWithImpl<$Res>
    implements _$PriorityTimeRuleCopyWith<$Res> {
  __$PriorityTimeRuleCopyWithImpl(this._self, this._then);

  final _PriorityTimeRule _self;
  final $Res Function(_PriorityTimeRule) _then;

/// Create a copy of PriorityTimeRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? priority = null,Object? startTime = null,Object? endTime = null,Object? weekdays = null,Object? specificDate = freezed,Object? startDateTime = freezed,Object? endDateTime = freezed,Object? unitMinutes = null,Object? unitPrice = null,Object? graceMinutes = null,Object? priceCap = freezed,}) {
  return _then(_PriorityTimeRule(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,weekdays: null == weekdays ? _self._weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as List<int>,specificDate: freezed == specificDate ? _self.specificDate : specificDate // ignore: cast_nullable_to_non_nullable
as String?,startDateTime: freezed == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as String?,endDateTime: freezed == endDateTime ? _self.endDateTime : endDateTime // ignore: cast_nullable_to_non_nullable
as String?,unitMinutes: null == unitMinutes ? _self.unitMinutes : unitMinutes // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as num,graceMinutes: null == graceMinutes ? _self.graceMinutes : graceMinutes // ignore: cast_nullable_to_non_nullable
as int,priceCap: freezed == priceCap ? _self.priceCap : priceCap // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}


/// @nodoc
mixin _$PricingConfig {

 String get id; String get name; String get kind;@JsonKey(readValue: readPricingRules) List<PriorityTimeRule> get rules;@JsonKey(readValue: readIsArchived) bool get isArchived;@JsonKey(readValue: readIsActive) bool get isActive;
/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricingConfigCopyWith<PricingConfig> get copyWith => _$PricingConfigCopyWithImpl<PricingConfig>(this as PricingConfig, _$identity);

  /// Serializes this PricingConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricingConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.rules, rules)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kind,const DeepCollectionEquality().hash(rules),isArchived,isActive);

@override
String toString() {
  return 'PricingConfig(id: $id, name: $name, kind: $kind, rules: $rules, isArchived: $isArchived, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $PricingConfigCopyWith<$Res>  {
  factory $PricingConfigCopyWith(PricingConfig value, $Res Function(PricingConfig) _then) = _$PricingConfigCopyWithImpl;
@useResult
$Res call({
 String id, String name, String kind,@JsonKey(readValue: readPricingRules) List<PriorityTimeRule> rules,@JsonKey(readValue: readIsArchived) bool isArchived,@JsonKey(readValue: readIsActive) bool isActive
});




}
/// @nodoc
class _$PricingConfigCopyWithImpl<$Res>
    implements $PricingConfigCopyWith<$Res> {
  _$PricingConfigCopyWithImpl(this._self, this._then);

  final PricingConfig _self;
  final $Res Function(PricingConfig) _then;

/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? rules = null,Object? isArchived = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<PriorityTimeRule>,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PricingConfig].
extension PricingConfigPatterns on PricingConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PricingConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PricingConfig value)  $default,){
final _that = this;
switch (_that) {
case _PricingConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PricingConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String kind, @JsonKey(readValue: readPricingRules)  List<PriorityTimeRule> rules, @JsonKey(readValue: readIsArchived)  bool isArchived, @JsonKey(readValue: readIsActive)  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.rules,_that.isArchived,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String kind, @JsonKey(readValue: readPricingRules)  List<PriorityTimeRule> rules, @JsonKey(readValue: readIsArchived)  bool isArchived, @JsonKey(readValue: readIsActive)  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _PricingConfig():
return $default(_that.id,_that.name,_that.kind,_that.rules,_that.isArchived,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String kind, @JsonKey(readValue: readPricingRules)  List<PriorityTimeRule> rules, @JsonKey(readValue: readIsArchived)  bool isArchived, @JsonKey(readValue: readIsActive)  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.rules,_that.isArchived,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PricingConfig implements PricingConfig {
  const _PricingConfig({required this.id, required this.name, required this.kind, @JsonKey(readValue: readPricingRules) required final  List<PriorityTimeRule> rules, @JsonKey(readValue: readIsArchived) this.isArchived = false, @JsonKey(readValue: readIsActive) this.isActive = true}): _rules = rules;
  factory _PricingConfig.fromJson(Map<String, dynamic> json) => _$PricingConfigFromJson(json);

@override final  String id;
@override final  String name;
@override final  String kind;
 final  List<PriorityTimeRule> _rules;
@override@JsonKey(readValue: readPricingRules) List<PriorityTimeRule> get rules {
  if (_rules is EqualUnmodifiableListView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rules);
}

@override@JsonKey(readValue: readIsArchived) final  bool isArchived;
@override@JsonKey(readValue: readIsActive) final  bool isActive;

/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricingConfigCopyWith<_PricingConfig> get copyWith => __$PricingConfigCopyWithImpl<_PricingConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PricingConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricingConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other._rules, _rules)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kind,const DeepCollectionEquality().hash(_rules),isArchived,isActive);

@override
String toString() {
  return 'PricingConfig(id: $id, name: $name, kind: $kind, rules: $rules, isArchived: $isArchived, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$PricingConfigCopyWith<$Res> implements $PricingConfigCopyWith<$Res> {
  factory _$PricingConfigCopyWith(_PricingConfig value, $Res Function(_PricingConfig) _then) = __$PricingConfigCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String kind,@JsonKey(readValue: readPricingRules) List<PriorityTimeRule> rules,@JsonKey(readValue: readIsArchived) bool isArchived,@JsonKey(readValue: readIsActive) bool isActive
});




}
/// @nodoc
class __$PricingConfigCopyWithImpl<$Res>
    implements _$PricingConfigCopyWith<$Res> {
  __$PricingConfigCopyWithImpl(this._self, this._then);

  final _PricingConfig _self;
  final $Res Function(_PricingConfig) _then;

/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? rules = null,Object? isArchived = null,Object? isActive = null,}) {
  return _then(_PricingConfig(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<PriorityTimeRule>,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$UnitPricing {

 String get startTime; String get endTime; num get price;
/// Create a copy of UnitPricing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnitPricingCopyWith<UnitPricing> get copyWith => _$UnitPricingCopyWithImpl<UnitPricing>(this as UnitPricing, _$identity);

  /// Serializes this UnitPricing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnitPricing&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startTime,endTime,price);

@override
String toString() {
  return 'UnitPricing(startTime: $startTime, endTime: $endTime, price: $price)';
}


}

/// @nodoc
abstract mixin class $UnitPricingCopyWith<$Res>  {
  factory $UnitPricingCopyWith(UnitPricing value, $Res Function(UnitPricing) _then) = _$UnitPricingCopyWithImpl;
@useResult
$Res call({
 String startTime, String endTime, num price
});




}
/// @nodoc
class _$UnitPricingCopyWithImpl<$Res>
    implements $UnitPricingCopyWith<$Res> {
  _$UnitPricingCopyWithImpl(this._self, this._then);

  final UnitPricing _self;
  final $Res Function(UnitPricing) _then;

/// Create a copy of UnitPricing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startTime = null,Object? endTime = null,Object? price = null,}) {
  return _then(_self.copyWith(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [UnitPricing].
extension UnitPricingPatterns on UnitPricing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnitPricing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnitPricing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnitPricing value)  $default,){
final _that = this;
switch (_that) {
case _UnitPricing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnitPricing value)?  $default,){
final _that = this;
switch (_that) {
case _UnitPricing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String startTime,  String endTime,  num price)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnitPricing() when $default != null:
return $default(_that.startTime,_that.endTime,_that.price);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String startTime,  String endTime,  num price)  $default,) {final _that = this;
switch (_that) {
case _UnitPricing():
return $default(_that.startTime,_that.endTime,_that.price);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String startTime,  String endTime,  num price)?  $default,) {final _that = this;
switch (_that) {
case _UnitPricing() when $default != null:
return $default(_that.startTime,_that.endTime,_that.price);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnitPricing implements UnitPricing {
  const _UnitPricing({required this.startTime, required this.endTime, required this.price});
  factory _UnitPricing.fromJson(Map<String, dynamic> json) => _$UnitPricingFromJson(json);

@override final  String startTime;
@override final  String endTime;
@override final  num price;

/// Create a copy of UnitPricing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnitPricingCopyWith<_UnitPricing> get copyWith => __$UnitPricingCopyWithImpl<_UnitPricing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnitPricingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnitPricing&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startTime,endTime,price);

@override
String toString() {
  return 'UnitPricing(startTime: $startTime, endTime: $endTime, price: $price)';
}


}

/// @nodoc
abstract mixin class _$UnitPricingCopyWith<$Res> implements $UnitPricingCopyWith<$Res> {
  factory _$UnitPricingCopyWith(_UnitPricing value, $Res Function(_UnitPricing) _then) = __$UnitPricingCopyWithImpl;
@override @useResult
$Res call({
 String startTime, String endTime, num price
});




}
/// @nodoc
class __$UnitPricingCopyWithImpl<$Res>
    implements _$UnitPricingCopyWith<$Res> {
  __$UnitPricingCopyWithImpl(this._self, this._then);

  final _UnitPricing _self;
  final $Res Function(_UnitPricing) _then;

/// Create a copy of UnitPricing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startTime = null,Object? endTime = null,Object? price = null,}) {
  return _then(_UnitPricing(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$PricingTimeline {

 List<UnitPricing> get timeline; String get pricingConfigId;
/// Create a copy of PricingTimeline
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricingTimelineCopyWith<PricingTimeline> get copyWith => _$PricingTimelineCopyWithImpl<PricingTimeline>(this as PricingTimeline, _$identity);

  /// Serializes this PricingTimeline to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricingTimeline&&const DeepCollectionEquality().equals(other.timeline, timeline)&&(identical(other.pricingConfigId, pricingConfigId) || other.pricingConfigId == pricingConfigId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(timeline),pricingConfigId);

@override
String toString() {
  return 'PricingTimeline(timeline: $timeline, pricingConfigId: $pricingConfigId)';
}


}

/// @nodoc
abstract mixin class $PricingTimelineCopyWith<$Res>  {
  factory $PricingTimelineCopyWith(PricingTimeline value, $Res Function(PricingTimeline) _then) = _$PricingTimelineCopyWithImpl;
@useResult
$Res call({
 List<UnitPricing> timeline, String pricingConfigId
});




}
/// @nodoc
class _$PricingTimelineCopyWithImpl<$Res>
    implements $PricingTimelineCopyWith<$Res> {
  _$PricingTimelineCopyWithImpl(this._self, this._then);

  final PricingTimeline _self;
  final $Res Function(PricingTimeline) _then;

/// Create a copy of PricingTimeline
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timeline = null,Object? pricingConfigId = null,}) {
  return _then(_self.copyWith(
timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<UnitPricing>,pricingConfigId: null == pricingConfigId ? _self.pricingConfigId : pricingConfigId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PricingTimeline].
extension PricingTimelinePatterns on PricingTimeline {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PricingTimeline value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PricingTimeline() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PricingTimeline value)  $default,){
final _that = this;
switch (_that) {
case _PricingTimeline():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PricingTimeline value)?  $default,){
final _that = this;
switch (_that) {
case _PricingTimeline() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UnitPricing> timeline,  String pricingConfigId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricingTimeline() when $default != null:
return $default(_that.timeline,_that.pricingConfigId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UnitPricing> timeline,  String pricingConfigId)  $default,) {final _that = this;
switch (_that) {
case _PricingTimeline():
return $default(_that.timeline,_that.pricingConfigId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UnitPricing> timeline,  String pricingConfigId)?  $default,) {final _that = this;
switch (_that) {
case _PricingTimeline() when $default != null:
return $default(_that.timeline,_that.pricingConfigId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PricingTimeline implements PricingTimeline {
  const _PricingTimeline({required final  List<UnitPricing> timeline, required this.pricingConfigId}): _timeline = timeline;
  factory _PricingTimeline.fromJson(Map<String, dynamic> json) => _$PricingTimelineFromJson(json);

 final  List<UnitPricing> _timeline;
@override List<UnitPricing> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}

@override final  String pricingConfigId;

/// Create a copy of PricingTimeline
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricingTimelineCopyWith<_PricingTimeline> get copyWith => __$PricingTimelineCopyWithImpl<_PricingTimeline>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PricingTimelineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricingTimeline&&const DeepCollectionEquality().equals(other._timeline, _timeline)&&(identical(other.pricingConfigId, pricingConfigId) || other.pricingConfigId == pricingConfigId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_timeline),pricingConfigId);

@override
String toString() {
  return 'PricingTimeline(timeline: $timeline, pricingConfigId: $pricingConfigId)';
}


}

/// @nodoc
abstract mixin class _$PricingTimelineCopyWith<$Res> implements $PricingTimelineCopyWith<$Res> {
  factory _$PricingTimelineCopyWith(_PricingTimeline value, $Res Function(_PricingTimeline) _then) = __$PricingTimelineCopyWithImpl;
@override @useResult
$Res call({
 List<UnitPricing> timeline, String pricingConfigId
});




}
/// @nodoc
class __$PricingTimelineCopyWithImpl<$Res>
    implements _$PricingTimelineCopyWith<$Res> {
  __$PricingTimelineCopyWithImpl(this._self, this._then);

  final _PricingTimeline _self;
  final $Res Function(_PricingTimeline) _then;

/// Create a copy of PricingTimeline
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timeline = null,Object? pricingConfigId = null,}) {
  return _then(_PricingTimeline(
timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<UnitPricing>,pricingConfigId: null == pricingConfigId ? _self.pricingConfigId : pricingConfigId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BusinessItem {

 String get id; String get name; num get price; String get kind;@JsonKey(readValue: readIsArchived) bool get isArchived;
/// Create a copy of BusinessItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessItemCopyWith<BusinessItem> get copyWith => _$BusinessItemCopyWithImpl<BusinessItem>(this as BusinessItem, _$identity);

  /// Serializes this BusinessItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,kind,isArchived);

@override
String toString() {
  return 'BusinessItem(id: $id, name: $name, price: $price, kind: $kind, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class $BusinessItemCopyWith<$Res>  {
  factory $BusinessItemCopyWith(BusinessItem value, $Res Function(BusinessItem) _then) = _$BusinessItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, num price, String kind,@JsonKey(readValue: readIsArchived) bool isArchived
});




}
/// @nodoc
class _$BusinessItemCopyWithImpl<$Res>
    implements $BusinessItemCopyWith<$Res> {
  _$BusinessItemCopyWithImpl(this._self, this._then);

  final BusinessItem _self;
  final $Res Function(BusinessItem) _then;

/// Create a copy of BusinessItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? price = null,Object? kind = null,Object? isArchived = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessItem].
extension BusinessItemPatterns on BusinessItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessItem value)  $default,){
final _that = this;
switch (_that) {
case _BusinessItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessItem value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  num price,  String kind, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessItem() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.kind,_that.isArchived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  num price,  String kind, @JsonKey(readValue: readIsArchived)  bool isArchived)  $default,) {final _that = this;
switch (_that) {
case _BusinessItem():
return $default(_that.id,_that.name,_that.price,_that.kind,_that.isArchived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  num price,  String kind, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,) {final _that = this;
switch (_that) {
case _BusinessItem() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.kind,_that.isArchived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessItem implements BusinessItem {
  const _BusinessItem({required this.id, required this.name, required this.price, required this.kind, @JsonKey(readValue: readIsArchived) this.isArchived = false});
  factory _BusinessItem.fromJson(Map<String, dynamic> json) => _$BusinessItemFromJson(json);

@override final  String id;
@override final  String name;
@override final  num price;
@override final  String kind;
@override@JsonKey(readValue: readIsArchived) final  bool isArchived;

/// Create a copy of BusinessItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessItemCopyWith<_BusinessItem> get copyWith => __$BusinessItemCopyWithImpl<_BusinessItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,kind,isArchived);

@override
String toString() {
  return 'BusinessItem(id: $id, name: $name, price: $price, kind: $kind, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class _$BusinessItemCopyWith<$Res> implements $BusinessItemCopyWith<$Res> {
  factory _$BusinessItemCopyWith(_BusinessItem value, $Res Function(_BusinessItem) _then) = __$BusinessItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, num price, String kind,@JsonKey(readValue: readIsArchived) bool isArchived
});




}
/// @nodoc
class __$BusinessItemCopyWithImpl<$Res>
    implements _$BusinessItemCopyWith<$Res> {
  __$BusinessItemCopyWithImpl(this._self, this._then);

  final _BusinessItem _self;
  final $Res Function(_BusinessItem) _then;

/// Create a copy of BusinessItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? price = null,Object? kind = null,Object? isArchived = null,}) {
  return _then(_BusinessItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$BusinessItemOrder {

 String get id; String get playerId;@JsonKey(readValue: readItemId) String get itemId;@JsonKey(readValue: readItemName) String get itemName; num get price; String get status; DateTime get createdAt; DateTime? get fulfilledAt; DateTime? get cancelledAt;
/// Create a copy of BusinessItemOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessItemOrderCopyWith<BusinessItemOrder> get copyWith => _$BusinessItemOrderCopyWithImpl<BusinessItemOrder>(this as BusinessItemOrder, _$identity);

  /// Serializes this BusinessItemOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessItemOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.price, price) || other.price == price)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.fulfilledAt, fulfilledAt) || other.fulfilledAt == fulfilledAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,playerId,itemId,itemName,price,status,createdAt,fulfilledAt,cancelledAt);

@override
String toString() {
  return 'BusinessItemOrder(id: $id, playerId: $playerId, itemId: $itemId, itemName: $itemName, price: $price, status: $status, createdAt: $createdAt, fulfilledAt: $fulfilledAt, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class $BusinessItemOrderCopyWith<$Res>  {
  factory $BusinessItemOrderCopyWith(BusinessItemOrder value, $Res Function(BusinessItemOrder) _then) = _$BusinessItemOrderCopyWithImpl;
@useResult
$Res call({
 String id, String playerId,@JsonKey(readValue: readItemId) String itemId,@JsonKey(readValue: readItemName) String itemName, num price, String status, DateTime createdAt, DateTime? fulfilledAt, DateTime? cancelledAt
});




}
/// @nodoc
class _$BusinessItemOrderCopyWithImpl<$Res>
    implements $BusinessItemOrderCopyWith<$Res> {
  _$BusinessItemOrderCopyWithImpl(this._self, this._then);

  final BusinessItemOrder _self;
  final $Res Function(BusinessItemOrder) _then;

/// Create a copy of BusinessItemOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playerId = null,Object? itemId = null,Object? itemName = null,Object? price = null,Object? status = null,Object? createdAt = null,Object? fulfilledAt = freezed,Object? cancelledAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,fulfilledAt: freezed == fulfilledAt ? _self.fulfilledAt : fulfilledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessItemOrder].
extension BusinessItemOrderPatterns on BusinessItemOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessItemOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessItemOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessItemOrder value)  $default,){
final _that = this;
switch (_that) {
case _BusinessItemOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessItemOrder value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessItemOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String playerId, @JsonKey(readValue: readItemId)  String itemId, @JsonKey(readValue: readItemName)  String itemName,  num price,  String status,  DateTime createdAt,  DateTime? fulfilledAt,  DateTime? cancelledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessItemOrder() when $default != null:
return $default(_that.id,_that.playerId,_that.itemId,_that.itemName,_that.price,_that.status,_that.createdAt,_that.fulfilledAt,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String playerId, @JsonKey(readValue: readItemId)  String itemId, @JsonKey(readValue: readItemName)  String itemName,  num price,  String status,  DateTime createdAt,  DateTime? fulfilledAt,  DateTime? cancelledAt)  $default,) {final _that = this;
switch (_that) {
case _BusinessItemOrder():
return $default(_that.id,_that.playerId,_that.itemId,_that.itemName,_that.price,_that.status,_that.createdAt,_that.fulfilledAt,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String playerId, @JsonKey(readValue: readItemId)  String itemId, @JsonKey(readValue: readItemName)  String itemName,  num price,  String status,  DateTime createdAt,  DateTime? fulfilledAt,  DateTime? cancelledAt)?  $default,) {final _that = this;
switch (_that) {
case _BusinessItemOrder() when $default != null:
return $default(_that.id,_that.playerId,_that.itemId,_that.itemName,_that.price,_that.status,_that.createdAt,_that.fulfilledAt,_that.cancelledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessItemOrder implements BusinessItemOrder {
  const _BusinessItemOrder({required this.id, required this.playerId, @JsonKey(readValue: readItemId) required this.itemId, @JsonKey(readValue: readItemName) required this.itemName, required this.price, required this.status, required this.createdAt, this.fulfilledAt, this.cancelledAt});
  factory _BusinessItemOrder.fromJson(Map<String, dynamic> json) => _$BusinessItemOrderFromJson(json);

@override final  String id;
@override final  String playerId;
@override@JsonKey(readValue: readItemId) final  String itemId;
@override@JsonKey(readValue: readItemName) final  String itemName;
@override final  num price;
@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime? fulfilledAt;
@override final  DateTime? cancelledAt;

/// Create a copy of BusinessItemOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessItemOrderCopyWith<_BusinessItemOrder> get copyWith => __$BusinessItemOrderCopyWithImpl<_BusinessItemOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessItemOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessItemOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.price, price) || other.price == price)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.fulfilledAt, fulfilledAt) || other.fulfilledAt == fulfilledAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,playerId,itemId,itemName,price,status,createdAt,fulfilledAt,cancelledAt);

@override
String toString() {
  return 'BusinessItemOrder(id: $id, playerId: $playerId, itemId: $itemId, itemName: $itemName, price: $price, status: $status, createdAt: $createdAt, fulfilledAt: $fulfilledAt, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class _$BusinessItemOrderCopyWith<$Res> implements $BusinessItemOrderCopyWith<$Res> {
  factory _$BusinessItemOrderCopyWith(_BusinessItemOrder value, $Res Function(_BusinessItemOrder) _then) = __$BusinessItemOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String playerId,@JsonKey(readValue: readItemId) String itemId,@JsonKey(readValue: readItemName) String itemName, num price, String status, DateTime createdAt, DateTime? fulfilledAt, DateTime? cancelledAt
});




}
/// @nodoc
class __$BusinessItemOrderCopyWithImpl<$Res>
    implements _$BusinessItemOrderCopyWith<$Res> {
  __$BusinessItemOrderCopyWithImpl(this._self, this._then);

  final _BusinessItemOrder _self;
  final $Res Function(_BusinessItemOrder) _then;

/// Create a copy of BusinessItemOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playerId = null,Object? itemId = null,Object? itemName = null,Object? price = null,Object? status = null,Object? createdAt = null,Object? fulfilledAt = freezed,Object? cancelledAt = freezed,}) {
  return _then(_BusinessItemOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,fulfilledAt: freezed == fulfilledAt ? _self.fulfilledAt : fulfilledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$DeviceState {

 String get deviceId; String get label; String get type; String get status; DateTime get reportedAt; String get reportedBy;
/// Create a copy of DeviceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceStateCopyWith<DeviceState> get copyWith => _$DeviceStateCopyWithImpl<DeviceState>(this as DeviceState, _$identity);

  /// Serializes this DeviceState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceState&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.reportedBy, reportedBy) || other.reportedBy == reportedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,label,type,status,reportedAt,reportedBy);

@override
String toString() {
  return 'DeviceState(deviceId: $deviceId, label: $label, type: $type, status: $status, reportedAt: $reportedAt, reportedBy: $reportedBy)';
}


}

/// @nodoc
abstract mixin class $DeviceStateCopyWith<$Res>  {
  factory $DeviceStateCopyWith(DeviceState value, $Res Function(DeviceState) _then) = _$DeviceStateCopyWithImpl;
@useResult
$Res call({
 String deviceId, String label, String type, String status, DateTime reportedAt, String reportedBy
});




}
/// @nodoc
class _$DeviceStateCopyWithImpl<$Res>
    implements $DeviceStateCopyWith<$Res> {
  _$DeviceStateCopyWithImpl(this._self, this._then);

  final DeviceState _self;
  final $Res Function(DeviceState) _then;

/// Create a copy of DeviceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? label = null,Object? type = null,Object? status = null,Object? reportedAt = null,Object? reportedBy = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportedBy: null == reportedBy ? _self.reportedBy : reportedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceState].
extension DeviceStatePatterns on DeviceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceState value)  $default,){
final _that = this;
switch (_that) {
case _DeviceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceState value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  String label,  String type,  String status,  DateTime reportedAt,  String reportedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceState() when $default != null:
return $default(_that.deviceId,_that.label,_that.type,_that.status,_that.reportedAt,_that.reportedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  String label,  String type,  String status,  DateTime reportedAt,  String reportedBy)  $default,) {final _that = this;
switch (_that) {
case _DeviceState():
return $default(_that.deviceId,_that.label,_that.type,_that.status,_that.reportedAt,_that.reportedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  String label,  String type,  String status,  DateTime reportedAt,  String reportedBy)?  $default,) {final _that = this;
switch (_that) {
case _DeviceState() when $default != null:
return $default(_that.deviceId,_that.label,_that.type,_that.status,_that.reportedAt,_that.reportedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceState implements DeviceState {
  const _DeviceState({required this.deviceId, required this.label, required this.type, required this.status, required this.reportedAt, required this.reportedBy});
  factory _DeviceState.fromJson(Map<String, dynamic> json) => _$DeviceStateFromJson(json);

@override final  String deviceId;
@override final  String label;
@override final  String type;
@override final  String status;
@override final  DateTime reportedAt;
@override final  String reportedBy;

/// Create a copy of DeviceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceStateCopyWith<_DeviceState> get copyWith => __$DeviceStateCopyWithImpl<_DeviceState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceState&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.reportedBy, reportedBy) || other.reportedBy == reportedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,label,type,status,reportedAt,reportedBy);

@override
String toString() {
  return 'DeviceState(deviceId: $deviceId, label: $label, type: $type, status: $status, reportedAt: $reportedAt, reportedBy: $reportedBy)';
}


}

/// @nodoc
abstract mixin class _$DeviceStateCopyWith<$Res> implements $DeviceStateCopyWith<$Res> {
  factory _$DeviceStateCopyWith(_DeviceState value, $Res Function(_DeviceState) _then) = __$DeviceStateCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, String label, String type, String status, DateTime reportedAt, String reportedBy
});




}
/// @nodoc
class __$DeviceStateCopyWithImpl<$Res>
    implements _$DeviceStateCopyWith<$Res> {
  __$DeviceStateCopyWithImpl(this._self, this._then);

  final _DeviceState _self;
  final $Res Function(_DeviceState) _then;

/// Create a copy of DeviceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? label = null,Object? type = null,Object? status = null,Object? reportedAt = null,Object? reportedBy = null,}) {
  return _then(_DeviceState(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportedBy: null == reportedBy ? _self.reportedBy : reportedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DeviceCommand {

 String get id;@JsonKey(readValue: readCommandType) String get commandType; String get deviceId;@JsonKey(readValue: readRequester) String get requester; String get status;@JsonKey(readValue: readCreatedAt) DateTime get createdAt; DateTime? get ackedAt;
/// Create a copy of DeviceCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceCommandCopyWith<DeviceCommand> get copyWith => _$DeviceCommandCopyWithImpl<DeviceCommand>(this as DeviceCommand, _$identity);

  /// Serializes this DeviceCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.commandType, commandType) || other.commandType == commandType)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.ackedAt, ackedAt) || other.ackedAt == ackedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,commandType,deviceId,requester,status,createdAt,ackedAt);

@override
String toString() {
  return 'DeviceCommand(id: $id, commandType: $commandType, deviceId: $deviceId, requester: $requester, status: $status, createdAt: $createdAt, ackedAt: $ackedAt)';
}


}

/// @nodoc
abstract mixin class $DeviceCommandCopyWith<$Res>  {
  factory $DeviceCommandCopyWith(DeviceCommand value, $Res Function(DeviceCommand) _then) = _$DeviceCommandCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(readValue: readCommandType) String commandType, String deviceId,@JsonKey(readValue: readRequester) String requester, String status,@JsonKey(readValue: readCreatedAt) DateTime createdAt, DateTime? ackedAt
});




}
/// @nodoc
class _$DeviceCommandCopyWithImpl<$Res>
    implements $DeviceCommandCopyWith<$Res> {
  _$DeviceCommandCopyWithImpl(this._self, this._then);

  final DeviceCommand _self;
  final $Res Function(DeviceCommand) _then;

/// Create a copy of DeviceCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? commandType = null,Object? deviceId = null,Object? requester = null,Object? status = null,Object? createdAt = null,Object? ackedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,commandType: null == commandType ? _self.commandType : commandType // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,ackedAt: freezed == ackedAt ? _self.ackedAt : ackedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceCommand].
extension DeviceCommandPatterns on DeviceCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceCommand value)  $default,){
final _that = this;
switch (_that) {
case _DeviceCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceCommand value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(readValue: readCommandType)  String commandType,  String deviceId, @JsonKey(readValue: readRequester)  String requester,  String status, @JsonKey(readValue: readCreatedAt)  DateTime createdAt,  DateTime? ackedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceCommand() when $default != null:
return $default(_that.id,_that.commandType,_that.deviceId,_that.requester,_that.status,_that.createdAt,_that.ackedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(readValue: readCommandType)  String commandType,  String deviceId, @JsonKey(readValue: readRequester)  String requester,  String status, @JsonKey(readValue: readCreatedAt)  DateTime createdAt,  DateTime? ackedAt)  $default,) {final _that = this;
switch (_that) {
case _DeviceCommand():
return $default(_that.id,_that.commandType,_that.deviceId,_that.requester,_that.status,_that.createdAt,_that.ackedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(readValue: readCommandType)  String commandType,  String deviceId, @JsonKey(readValue: readRequester)  String requester,  String status, @JsonKey(readValue: readCreatedAt)  DateTime createdAt,  DateTime? ackedAt)?  $default,) {final _that = this;
switch (_that) {
case _DeviceCommand() when $default != null:
return $default(_that.id,_that.commandType,_that.deviceId,_that.requester,_that.status,_that.createdAt,_that.ackedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceCommand implements DeviceCommand {
  const _DeviceCommand({required this.id, @JsonKey(readValue: readCommandType) required this.commandType, required this.deviceId, @JsonKey(readValue: readRequester) required this.requester, required this.status, @JsonKey(readValue: readCreatedAt) required this.createdAt, this.ackedAt});
  factory _DeviceCommand.fromJson(Map<String, dynamic> json) => _$DeviceCommandFromJson(json);

@override final  String id;
@override@JsonKey(readValue: readCommandType) final  String commandType;
@override final  String deviceId;
@override@JsonKey(readValue: readRequester) final  String requester;
@override final  String status;
@override@JsonKey(readValue: readCreatedAt) final  DateTime createdAt;
@override final  DateTime? ackedAt;

/// Create a copy of DeviceCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceCommandCopyWith<_DeviceCommand> get copyWith => __$DeviceCommandCopyWithImpl<_DeviceCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.commandType, commandType) || other.commandType == commandType)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.ackedAt, ackedAt) || other.ackedAt == ackedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,commandType,deviceId,requester,status,createdAt,ackedAt);

@override
String toString() {
  return 'DeviceCommand(id: $id, commandType: $commandType, deviceId: $deviceId, requester: $requester, status: $status, createdAt: $createdAt, ackedAt: $ackedAt)';
}


}

/// @nodoc
abstract mixin class _$DeviceCommandCopyWith<$Res> implements $DeviceCommandCopyWith<$Res> {
  factory _$DeviceCommandCopyWith(_DeviceCommand value, $Res Function(_DeviceCommand) _then) = __$DeviceCommandCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(readValue: readCommandType) String commandType, String deviceId,@JsonKey(readValue: readRequester) String requester, String status,@JsonKey(readValue: readCreatedAt) DateTime createdAt, DateTime? ackedAt
});




}
/// @nodoc
class __$DeviceCommandCopyWithImpl<$Res>
    implements _$DeviceCommandCopyWith<$Res> {
  __$DeviceCommandCopyWithImpl(this._self, this._then);

  final _DeviceCommand _self;
  final $Res Function(_DeviceCommand) _then;

/// Create a copy of DeviceCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? commandType = null,Object? deviceId = null,Object? requester = null,Object? status = null,Object? createdAt = null,Object? ackedAt = freezed,}) {
  return _then(_DeviceCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,commandType: null == commandType ? _self.commandType : commandType // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,ackedAt: freezed == ackedAt ? _self.ackedAt : ackedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ReportSummary {

@JsonKey(readValue: readRevenue) num get revenue;@JsonKey(readValue: readSettledSessionsCount) int get settledSessionsCount;@JsonKey(readValue: readAssetGrantsCount) int get assetGrantsCount;@JsonKey(readValue: readCoinCommandsCount) int get coinCommandsCount;
/// Create a copy of ReportSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportSummaryCopyWith<ReportSummary> get copyWith => _$ReportSummaryCopyWithImpl<ReportSummary>(this as ReportSummary, _$identity);

  /// Serializes this ReportSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportSummary&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.settledSessionsCount, settledSessionsCount) || other.settledSessionsCount == settledSessionsCount)&&(identical(other.assetGrantsCount, assetGrantsCount) || other.assetGrantsCount == assetGrantsCount)&&(identical(other.coinCommandsCount, coinCommandsCount) || other.coinCommandsCount == coinCommandsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revenue,settledSessionsCount,assetGrantsCount,coinCommandsCount);

@override
String toString() {
  return 'ReportSummary(revenue: $revenue, settledSessionsCount: $settledSessionsCount, assetGrantsCount: $assetGrantsCount, coinCommandsCount: $coinCommandsCount)';
}


}

/// @nodoc
abstract mixin class $ReportSummaryCopyWith<$Res>  {
  factory $ReportSummaryCopyWith(ReportSummary value, $Res Function(ReportSummary) _then) = _$ReportSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: readRevenue) num revenue,@JsonKey(readValue: readSettledSessionsCount) int settledSessionsCount,@JsonKey(readValue: readAssetGrantsCount) int assetGrantsCount,@JsonKey(readValue: readCoinCommandsCount) int coinCommandsCount
});




}
/// @nodoc
class _$ReportSummaryCopyWithImpl<$Res>
    implements $ReportSummaryCopyWith<$Res> {
  _$ReportSummaryCopyWithImpl(this._self, this._then);

  final ReportSummary _self;
  final $Res Function(ReportSummary) _then;

/// Create a copy of ReportSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? revenue = null,Object? settledSessionsCount = null,Object? assetGrantsCount = null,Object? coinCommandsCount = null,}) {
  return _then(_self.copyWith(
revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as num,settledSessionsCount: null == settledSessionsCount ? _self.settledSessionsCount : settledSessionsCount // ignore: cast_nullable_to_non_nullable
as int,assetGrantsCount: null == assetGrantsCount ? _self.assetGrantsCount : assetGrantsCount // ignore: cast_nullable_to_non_nullable
as int,coinCommandsCount: null == coinCommandsCount ? _self.coinCommandsCount : coinCommandsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportSummary].
extension ReportSummaryPatterns on ReportSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportSummary value)  $default,){
final _that = this;
switch (_that) {
case _ReportSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ReportSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: readRevenue)  num revenue, @JsonKey(readValue: readSettledSessionsCount)  int settledSessionsCount, @JsonKey(readValue: readAssetGrantsCount)  int assetGrantsCount, @JsonKey(readValue: readCoinCommandsCount)  int coinCommandsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportSummary() when $default != null:
return $default(_that.revenue,_that.settledSessionsCount,_that.assetGrantsCount,_that.coinCommandsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: readRevenue)  num revenue, @JsonKey(readValue: readSettledSessionsCount)  int settledSessionsCount, @JsonKey(readValue: readAssetGrantsCount)  int assetGrantsCount, @JsonKey(readValue: readCoinCommandsCount)  int coinCommandsCount)  $default,) {final _that = this;
switch (_that) {
case _ReportSummary():
return $default(_that.revenue,_that.settledSessionsCount,_that.assetGrantsCount,_that.coinCommandsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: readRevenue)  num revenue, @JsonKey(readValue: readSettledSessionsCount)  int settledSessionsCount, @JsonKey(readValue: readAssetGrantsCount)  int assetGrantsCount, @JsonKey(readValue: readCoinCommandsCount)  int coinCommandsCount)?  $default,) {final _that = this;
switch (_that) {
case _ReportSummary() when $default != null:
return $default(_that.revenue,_that.settledSessionsCount,_that.assetGrantsCount,_that.coinCommandsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportSummary implements ReportSummary {
  const _ReportSummary({@JsonKey(readValue: readRevenue) required this.revenue, @JsonKey(readValue: readSettledSessionsCount) required this.settledSessionsCount, @JsonKey(readValue: readAssetGrantsCount) required this.assetGrantsCount, @JsonKey(readValue: readCoinCommandsCount) required this.coinCommandsCount});
  factory _ReportSummary.fromJson(Map<String, dynamic> json) => _$ReportSummaryFromJson(json);

@override@JsonKey(readValue: readRevenue) final  num revenue;
@override@JsonKey(readValue: readSettledSessionsCount) final  int settledSessionsCount;
@override@JsonKey(readValue: readAssetGrantsCount) final  int assetGrantsCount;
@override@JsonKey(readValue: readCoinCommandsCount) final  int coinCommandsCount;

/// Create a copy of ReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportSummaryCopyWith<_ReportSummary> get copyWith => __$ReportSummaryCopyWithImpl<_ReportSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportSummary&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.settledSessionsCount, settledSessionsCount) || other.settledSessionsCount == settledSessionsCount)&&(identical(other.assetGrantsCount, assetGrantsCount) || other.assetGrantsCount == assetGrantsCount)&&(identical(other.coinCommandsCount, coinCommandsCount) || other.coinCommandsCount == coinCommandsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,revenue,settledSessionsCount,assetGrantsCount,coinCommandsCount);

@override
String toString() {
  return 'ReportSummary(revenue: $revenue, settledSessionsCount: $settledSessionsCount, assetGrantsCount: $assetGrantsCount, coinCommandsCount: $coinCommandsCount)';
}


}

/// @nodoc
abstract mixin class _$ReportSummaryCopyWith<$Res> implements $ReportSummaryCopyWith<$Res> {
  factory _$ReportSummaryCopyWith(_ReportSummary value, $Res Function(_ReportSummary) _then) = __$ReportSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: readRevenue) num revenue,@JsonKey(readValue: readSettledSessionsCount) int settledSessionsCount,@JsonKey(readValue: readAssetGrantsCount) int assetGrantsCount,@JsonKey(readValue: readCoinCommandsCount) int coinCommandsCount
});




}
/// @nodoc
class __$ReportSummaryCopyWithImpl<$Res>
    implements _$ReportSummaryCopyWith<$Res> {
  __$ReportSummaryCopyWithImpl(this._self, this._then);

  final _ReportSummary _self;
  final $Res Function(_ReportSummary) _then;

/// Create a copy of ReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? revenue = null,Object? settledSessionsCount = null,Object? assetGrantsCount = null,Object? coinCommandsCount = null,}) {
  return _then(_ReportSummary(
revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as num,settledSessionsCount: null == settledSessionsCount ? _self.settledSessionsCount : settledSessionsCount // ignore: cast_nullable_to_non_nullable
as int,assetGrantsCount: null == assetGrantsCount ? _self.assetGrantsCount : assetGrantsCount // ignore: cast_nullable_to_non_nullable
as int,coinCommandsCount: null == coinCommandsCount ? _self.coinCommandsCount : coinCommandsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SettlementReportRow {

 String get playerId;@JsonKey(readValue: readDisplayName) String get displayName; int get durationMinutes; num get subtotal; num get total; DateTime get settledAt;
/// Create a copy of SettlementReportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementReportRowCopyWith<SettlementReportRow> get copyWith => _$SettlementReportRowCopyWithImpl<SettlementReportRow>(this as SettlementReportRow, _$identity);

  /// Serializes this SettlementReportRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementReportRow&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.total, total) || other.total == total)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,displayName,durationMinutes,subtotal,total,settledAt);

@override
String toString() {
  return 'SettlementReportRow(playerId: $playerId, displayName: $displayName, durationMinutes: $durationMinutes, subtotal: $subtotal, total: $total, settledAt: $settledAt)';
}


}

/// @nodoc
abstract mixin class $SettlementReportRowCopyWith<$Res>  {
  factory $SettlementReportRowCopyWith(SettlementReportRow value, $Res Function(SettlementReportRow) _then) = _$SettlementReportRowCopyWithImpl;
@useResult
$Res call({
 String playerId,@JsonKey(readValue: readDisplayName) String displayName, int durationMinutes, num subtotal, num total, DateTime settledAt
});




}
/// @nodoc
class _$SettlementReportRowCopyWithImpl<$Res>
    implements $SettlementReportRowCopyWith<$Res> {
  _$SettlementReportRowCopyWithImpl(this._self, this._then);

  final SettlementReportRow _self;
  final $Res Function(SettlementReportRow) _then;

/// Create a copy of SettlementReportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? displayName = null,Object? durationMinutes = null,Object? subtotal = null,Object? total = null,Object? settledAt = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as num,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as num,settledAt: null == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementReportRow].
extension SettlementReportRowPatterns on SettlementReportRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementReportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementReportRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementReportRow value)  $default,){
final _that = this;
switch (_that) {
case _SettlementReportRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementReportRow value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementReportRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId, @JsonKey(readValue: readDisplayName)  String displayName,  int durationMinutes,  num subtotal,  num total,  DateTime settledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementReportRow() when $default != null:
return $default(_that.playerId,_that.displayName,_that.durationMinutes,_that.subtotal,_that.total,_that.settledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId, @JsonKey(readValue: readDisplayName)  String displayName,  int durationMinutes,  num subtotal,  num total,  DateTime settledAt)  $default,) {final _that = this;
switch (_that) {
case _SettlementReportRow():
return $default(_that.playerId,_that.displayName,_that.durationMinutes,_that.subtotal,_that.total,_that.settledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId, @JsonKey(readValue: readDisplayName)  String displayName,  int durationMinutes,  num subtotal,  num total,  DateTime settledAt)?  $default,) {final _that = this;
switch (_that) {
case _SettlementReportRow() when $default != null:
return $default(_that.playerId,_that.displayName,_that.durationMinutes,_that.subtotal,_that.total,_that.settledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlementReportRow implements SettlementReportRow {
  const _SettlementReportRow({required this.playerId, @JsonKey(readValue: readDisplayName) required this.displayName, required this.durationMinutes, required this.subtotal, required this.total, required this.settledAt});
  factory _SettlementReportRow.fromJson(Map<String, dynamic> json) => _$SettlementReportRowFromJson(json);

@override final  String playerId;
@override@JsonKey(readValue: readDisplayName) final  String displayName;
@override final  int durationMinutes;
@override final  num subtotal;
@override final  num total;
@override final  DateTime settledAt;

/// Create a copy of SettlementReportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementReportRowCopyWith<_SettlementReportRow> get copyWith => __$SettlementReportRowCopyWithImpl<_SettlementReportRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettlementReportRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementReportRow&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.total, total) || other.total == total)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,displayName,durationMinutes,subtotal,total,settledAt);

@override
String toString() {
  return 'SettlementReportRow(playerId: $playerId, displayName: $displayName, durationMinutes: $durationMinutes, subtotal: $subtotal, total: $total, settledAt: $settledAt)';
}


}

/// @nodoc
abstract mixin class _$SettlementReportRowCopyWith<$Res> implements $SettlementReportRowCopyWith<$Res> {
  factory _$SettlementReportRowCopyWith(_SettlementReportRow value, $Res Function(_SettlementReportRow) _then) = __$SettlementReportRowCopyWithImpl;
@override @useResult
$Res call({
 String playerId,@JsonKey(readValue: readDisplayName) String displayName, int durationMinutes, num subtotal, num total, DateTime settledAt
});




}
/// @nodoc
class __$SettlementReportRowCopyWithImpl<$Res>
    implements _$SettlementReportRowCopyWith<$Res> {
  __$SettlementReportRowCopyWithImpl(this._self, this._then);

  final _SettlementReportRow _self;
  final $Res Function(_SettlementReportRow) _then;

/// Create a copy of SettlementReportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? displayName = null,Object? durationMinutes = null,Object? subtotal = null,Object? total = null,Object? settledAt = null,}) {
  return _then(_SettlementReportRow(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as num,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as num,settledAt: null == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PlayerReportRow {

 String get playerId;@JsonKey(readValue: readDisplayName) String get displayName; int get settlementCount; int get totalDurationMinutes;@JsonKey(readValue: readRevenue) num get revenue; DateTime get lastSettledAt;
/// Create a copy of PlayerReportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerReportRowCopyWith<PlayerReportRow> get copyWith => _$PlayerReportRowCopyWithImpl<PlayerReportRow>(this as PlayerReportRow, _$identity);

  /// Serializes this PlayerReportRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerReportRow&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.settlementCount, settlementCount) || other.settlementCount == settlementCount)&&(identical(other.totalDurationMinutes, totalDurationMinutes) || other.totalDurationMinutes == totalDurationMinutes)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.lastSettledAt, lastSettledAt) || other.lastSettledAt == lastSettledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,displayName,settlementCount,totalDurationMinutes,revenue,lastSettledAt);

@override
String toString() {
  return 'PlayerReportRow(playerId: $playerId, displayName: $displayName, settlementCount: $settlementCount, totalDurationMinutes: $totalDurationMinutes, revenue: $revenue, lastSettledAt: $lastSettledAt)';
}


}

/// @nodoc
abstract mixin class $PlayerReportRowCopyWith<$Res>  {
  factory $PlayerReportRowCopyWith(PlayerReportRow value, $Res Function(PlayerReportRow) _then) = _$PlayerReportRowCopyWithImpl;
@useResult
$Res call({
 String playerId,@JsonKey(readValue: readDisplayName) String displayName, int settlementCount, int totalDurationMinutes,@JsonKey(readValue: readRevenue) num revenue, DateTime lastSettledAt
});




}
/// @nodoc
class _$PlayerReportRowCopyWithImpl<$Res>
    implements $PlayerReportRowCopyWith<$Res> {
  _$PlayerReportRowCopyWithImpl(this._self, this._then);

  final PlayerReportRow _self;
  final $Res Function(PlayerReportRow) _then;

/// Create a copy of PlayerReportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? displayName = null,Object? settlementCount = null,Object? totalDurationMinutes = null,Object? revenue = null,Object? lastSettledAt = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,settlementCount: null == settlementCount ? _self.settlementCount : settlementCount // ignore: cast_nullable_to_non_nullable
as int,totalDurationMinutes: null == totalDurationMinutes ? _self.totalDurationMinutes : totalDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as num,lastSettledAt: null == lastSettledAt ? _self.lastSettledAt : lastSettledAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerReportRow].
extension PlayerReportRowPatterns on PlayerReportRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerReportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerReportRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerReportRow value)  $default,){
final _that = this;
switch (_that) {
case _PlayerReportRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerReportRow value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerReportRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId, @JsonKey(readValue: readDisplayName)  String displayName,  int settlementCount,  int totalDurationMinutes, @JsonKey(readValue: readRevenue)  num revenue,  DateTime lastSettledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerReportRow() when $default != null:
return $default(_that.playerId,_that.displayName,_that.settlementCount,_that.totalDurationMinutes,_that.revenue,_that.lastSettledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId, @JsonKey(readValue: readDisplayName)  String displayName,  int settlementCount,  int totalDurationMinutes, @JsonKey(readValue: readRevenue)  num revenue,  DateTime lastSettledAt)  $default,) {final _that = this;
switch (_that) {
case _PlayerReportRow():
return $default(_that.playerId,_that.displayName,_that.settlementCount,_that.totalDurationMinutes,_that.revenue,_that.lastSettledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId, @JsonKey(readValue: readDisplayName)  String displayName,  int settlementCount,  int totalDurationMinutes, @JsonKey(readValue: readRevenue)  num revenue,  DateTime lastSettledAt)?  $default,) {final _that = this;
switch (_that) {
case _PlayerReportRow() when $default != null:
return $default(_that.playerId,_that.displayName,_that.settlementCount,_that.totalDurationMinutes,_that.revenue,_that.lastSettledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerReportRow implements PlayerReportRow {
  const _PlayerReportRow({required this.playerId, @JsonKey(readValue: readDisplayName) required this.displayName, required this.settlementCount, required this.totalDurationMinutes, @JsonKey(readValue: readRevenue) required this.revenue, required this.lastSettledAt});
  factory _PlayerReportRow.fromJson(Map<String, dynamic> json) => _$PlayerReportRowFromJson(json);

@override final  String playerId;
@override@JsonKey(readValue: readDisplayName) final  String displayName;
@override final  int settlementCount;
@override final  int totalDurationMinutes;
@override@JsonKey(readValue: readRevenue) final  num revenue;
@override final  DateTime lastSettledAt;

/// Create a copy of PlayerReportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerReportRowCopyWith<_PlayerReportRow> get copyWith => __$PlayerReportRowCopyWithImpl<_PlayerReportRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerReportRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerReportRow&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.settlementCount, settlementCount) || other.settlementCount == settlementCount)&&(identical(other.totalDurationMinutes, totalDurationMinutes) || other.totalDurationMinutes == totalDurationMinutes)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.lastSettledAt, lastSettledAt) || other.lastSettledAt == lastSettledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,displayName,settlementCount,totalDurationMinutes,revenue,lastSettledAt);

@override
String toString() {
  return 'PlayerReportRow(playerId: $playerId, displayName: $displayName, settlementCount: $settlementCount, totalDurationMinutes: $totalDurationMinutes, revenue: $revenue, lastSettledAt: $lastSettledAt)';
}


}

/// @nodoc
abstract mixin class _$PlayerReportRowCopyWith<$Res> implements $PlayerReportRowCopyWith<$Res> {
  factory _$PlayerReportRowCopyWith(_PlayerReportRow value, $Res Function(_PlayerReportRow) _then) = __$PlayerReportRowCopyWithImpl;
@override @useResult
$Res call({
 String playerId,@JsonKey(readValue: readDisplayName) String displayName, int settlementCount, int totalDurationMinutes,@JsonKey(readValue: readRevenue) num revenue, DateTime lastSettledAt
});




}
/// @nodoc
class __$PlayerReportRowCopyWithImpl<$Res>
    implements _$PlayerReportRowCopyWith<$Res> {
  __$PlayerReportRowCopyWithImpl(this._self, this._then);

  final _PlayerReportRow _self;
  final $Res Function(_PlayerReportRow) _then;

/// Create a copy of PlayerReportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? displayName = null,Object? settlementCount = null,Object? totalDurationMinutes = null,Object? revenue = null,Object? lastSettledAt = null,}) {
  return _then(_PlayerReportRow(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,settlementCount: null == settlementCount ? _self.settlementCount : settlementCount // ignore: cast_nullable_to_non_nullable
as int,totalDurationMinutes: null == totalDurationMinutes ? _self.totalDurationMinutes : totalDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as num,lastSettledAt: null == lastSettledAt ? _self.lastSettledAt : lastSettledAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$SettingsData {

@JsonKey(readValue: readStoreName) String get storeName;@JsonKey(readValue: readTimeZone) String get timeZone;@JsonKey(readValue: readCoinCooldownMs) int get coinCooldownMs;
/// Create a copy of SettingsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsDataCopyWith<SettingsData> get copyWith => _$SettingsDataCopyWithImpl<SettingsData>(this as SettingsData, _$identity);

  /// Serializes this SettingsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsData&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.coinCooldownMs, coinCooldownMs) || other.coinCooldownMs == coinCooldownMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storeName,timeZone,coinCooldownMs);

@override
String toString() {
  return 'SettingsData(storeName: $storeName, timeZone: $timeZone, coinCooldownMs: $coinCooldownMs)';
}


}

/// @nodoc
abstract mixin class $SettingsDataCopyWith<$Res>  {
  factory $SettingsDataCopyWith(SettingsData value, $Res Function(SettingsData) _then) = _$SettingsDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: readStoreName) String storeName,@JsonKey(readValue: readTimeZone) String timeZone,@JsonKey(readValue: readCoinCooldownMs) int coinCooldownMs
});




}
/// @nodoc
class _$SettingsDataCopyWithImpl<$Res>
    implements $SettingsDataCopyWith<$Res> {
  _$SettingsDataCopyWithImpl(this._self, this._then);

  final SettingsData _self;
  final $Res Function(SettingsData) _then;

/// Create a copy of SettingsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storeName = null,Object? timeZone = null,Object? coinCooldownMs = null,}) {
  return _then(_self.copyWith(
storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,coinCooldownMs: null == coinCooldownMs ? _self.coinCooldownMs : coinCooldownMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsData].
extension SettingsDataPatterns on SettingsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsData value)  $default,){
final _that = this;
switch (_that) {
case _SettingsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsData value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: readStoreName)  String storeName, @JsonKey(readValue: readTimeZone)  String timeZone, @JsonKey(readValue: readCoinCooldownMs)  int coinCooldownMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsData() when $default != null:
return $default(_that.storeName,_that.timeZone,_that.coinCooldownMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: readStoreName)  String storeName, @JsonKey(readValue: readTimeZone)  String timeZone, @JsonKey(readValue: readCoinCooldownMs)  int coinCooldownMs)  $default,) {final _that = this;
switch (_that) {
case _SettingsData():
return $default(_that.storeName,_that.timeZone,_that.coinCooldownMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: readStoreName)  String storeName, @JsonKey(readValue: readTimeZone)  String timeZone, @JsonKey(readValue: readCoinCooldownMs)  int coinCooldownMs)?  $default,) {final _that = this;
switch (_that) {
case _SettingsData() when $default != null:
return $default(_that.storeName,_that.timeZone,_that.coinCooldownMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettingsData implements SettingsData {
  const _SettingsData({@JsonKey(readValue: readStoreName) required this.storeName, @JsonKey(readValue: readTimeZone) required this.timeZone, @JsonKey(readValue: readCoinCooldownMs) required this.coinCooldownMs});
  factory _SettingsData.fromJson(Map<String, dynamic> json) => _$SettingsDataFromJson(json);

@override@JsonKey(readValue: readStoreName) final  String storeName;
@override@JsonKey(readValue: readTimeZone) final  String timeZone;
@override@JsonKey(readValue: readCoinCooldownMs) final  int coinCooldownMs;

/// Create a copy of SettingsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsDataCopyWith<_SettingsData> get copyWith => __$SettingsDataCopyWithImpl<_SettingsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsData&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.coinCooldownMs, coinCooldownMs) || other.coinCooldownMs == coinCooldownMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storeName,timeZone,coinCooldownMs);

@override
String toString() {
  return 'SettingsData(storeName: $storeName, timeZone: $timeZone, coinCooldownMs: $coinCooldownMs)';
}


}

/// @nodoc
abstract mixin class _$SettingsDataCopyWith<$Res> implements $SettingsDataCopyWith<$Res> {
  factory _$SettingsDataCopyWith(_SettingsData value, $Res Function(_SettingsData) _then) = __$SettingsDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: readStoreName) String storeName,@JsonKey(readValue: readTimeZone) String timeZone,@JsonKey(readValue: readCoinCooldownMs) int coinCooldownMs
});




}
/// @nodoc
class __$SettingsDataCopyWithImpl<$Res>
    implements _$SettingsDataCopyWith<$Res> {
  __$SettingsDataCopyWithImpl(this._self, this._then);

  final _SettingsData _self;
  final $Res Function(_SettingsData) _then;

/// Create a copy of SettingsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storeName = null,Object? timeZone = null,Object? coinCooldownMs = null,}) {
  return _then(_SettingsData(
storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,coinCooldownMs: null == coinCooldownMs ? _self.coinCooldownMs : coinCooldownMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StaffUser {

 String get id; String get username; String get displayName;@JsonKey(unknownEnumValue: StaffRole.viewer) StaffRole get role;@JsonKey(readValue: readIsArchived) bool get isArchived;
/// Create a copy of StaffUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffUserCopyWith<StaffUser> get copyWith => _$StaffUserCopyWithImpl<StaffUser>(this as StaffUser, _$identity);

  /// Serializes this StaffUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffUser&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.role, role) || other.role == role)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,displayName,role,isArchived);

@override
String toString() {
  return 'StaffUser(id: $id, username: $username, displayName: $displayName, role: $role, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class $StaffUserCopyWith<$Res>  {
  factory $StaffUserCopyWith(StaffUser value, $Res Function(StaffUser) _then) = _$StaffUserCopyWithImpl;
@useResult
$Res call({
 String id, String username, String displayName,@JsonKey(unknownEnumValue: StaffRole.viewer) StaffRole role,@JsonKey(readValue: readIsArchived) bool isArchived
});




}
/// @nodoc
class _$StaffUserCopyWithImpl<$Res>
    implements $StaffUserCopyWith<$Res> {
  _$StaffUserCopyWithImpl(this._self, this._then);

  final StaffUser _self;
  final $Res Function(StaffUser) _then;

/// Create a copy of StaffUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? displayName = null,Object? role = null,Object? isArchived = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as StaffRole,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffUser].
extension StaffUserPatterns on StaffUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffUser value)  $default,){
final _that = this;
switch (_that) {
case _StaffUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffUser value)?  $default,){
final _that = this;
switch (_that) {
case _StaffUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String displayName, @JsonKey(unknownEnumValue: StaffRole.viewer)  StaffRole role, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffUser() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.role,_that.isArchived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String displayName, @JsonKey(unknownEnumValue: StaffRole.viewer)  StaffRole role, @JsonKey(readValue: readIsArchived)  bool isArchived)  $default,) {final _that = this;
switch (_that) {
case _StaffUser():
return $default(_that.id,_that.username,_that.displayName,_that.role,_that.isArchived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String displayName, @JsonKey(unknownEnumValue: StaffRole.viewer)  StaffRole role, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,) {final _that = this;
switch (_that) {
case _StaffUser() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.role,_that.isArchived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StaffUser implements StaffUser {
  const _StaffUser({required this.id, required this.username, required this.displayName, @JsonKey(unknownEnumValue: StaffRole.viewer) required this.role, @JsonKey(readValue: readIsArchived) this.isArchived = false});
  factory _StaffUser.fromJson(Map<String, dynamic> json) => _$StaffUserFromJson(json);

@override final  String id;
@override final  String username;
@override final  String displayName;
@override@JsonKey(unknownEnumValue: StaffRole.viewer) final  StaffRole role;
@override@JsonKey(readValue: readIsArchived) final  bool isArchived;

/// Create a copy of StaffUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffUserCopyWith<_StaffUser> get copyWith => __$StaffUserCopyWithImpl<_StaffUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StaffUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffUser&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.role, role) || other.role == role)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,displayName,role,isArchived);

@override
String toString() {
  return 'StaffUser(id: $id, username: $username, displayName: $displayName, role: $role, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class _$StaffUserCopyWith<$Res> implements $StaffUserCopyWith<$Res> {
  factory _$StaffUserCopyWith(_StaffUser value, $Res Function(_StaffUser) _then) = __$StaffUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String displayName,@JsonKey(unknownEnumValue: StaffRole.viewer) StaffRole role,@JsonKey(readValue: readIsArchived) bool isArchived
});




}
/// @nodoc
class __$StaffUserCopyWithImpl<$Res>
    implements _$StaffUserCopyWith<$Res> {
  __$StaffUserCopyWithImpl(this._self, this._then);

  final _StaffUser _self;
  final $Res Function(_StaffUser) _then;

/// Create a copy of StaffUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? displayName = null,Object? role = null,Object? isArchived = null,}) {
  return _then(_StaffUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as StaffRole,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ApiToken {

 String get id; String get label;@JsonKey(includeToJson: false) String? get token; DateTime get createdAt; String get role; String get tokenPrefix;@JsonKey(readValue: readIsRevoked) bool get isRevoked;
/// Create a copy of ApiToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiTokenCopyWith<ApiToken> get copyWith => _$ApiTokenCopyWithImpl<ApiToken>(this as ApiToken, _$identity);

  /// Serializes this ApiToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiToken&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.token, token) || other.token == token)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.role, role) || other.role == role)&&(identical(other.tokenPrefix, tokenPrefix) || other.tokenPrefix == tokenPrefix)&&(identical(other.isRevoked, isRevoked) || other.isRevoked == isRevoked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,token,createdAt,role,tokenPrefix,isRevoked);



}

/// @nodoc
abstract mixin class $ApiTokenCopyWith<$Res>  {
  factory $ApiTokenCopyWith(ApiToken value, $Res Function(ApiToken) _then) = _$ApiTokenCopyWithImpl;
@useResult
$Res call({
 String id, String label,@JsonKey(includeToJson: false) String? token, DateTime createdAt, String role, String tokenPrefix,@JsonKey(readValue: readIsRevoked) bool isRevoked
});




}
/// @nodoc
class _$ApiTokenCopyWithImpl<$Res>
    implements $ApiTokenCopyWith<$Res> {
  _$ApiTokenCopyWithImpl(this._self, this._then);

  final ApiToken _self;
  final $Res Function(ApiToken) _then;

/// Create a copy of ApiToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? token = freezed,Object? createdAt = null,Object? role = null,Object? tokenPrefix = null,Object? isRevoked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,tokenPrefix: null == tokenPrefix ? _self.tokenPrefix : tokenPrefix // ignore: cast_nullable_to_non_nullable
as String,isRevoked: null == isRevoked ? _self.isRevoked : isRevoked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiToken].
extension ApiTokenPatterns on ApiToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiToken value)  $default,){
final _that = this;
switch (_that) {
case _ApiToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiToken value)?  $default,){
final _that = this;
switch (_that) {
case _ApiToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label, @JsonKey(includeToJson: false)  String? token,  DateTime createdAt,  String role,  String tokenPrefix, @JsonKey(readValue: readIsRevoked)  bool isRevoked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiToken() when $default != null:
return $default(_that.id,_that.label,_that.token,_that.createdAt,_that.role,_that.tokenPrefix,_that.isRevoked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label, @JsonKey(includeToJson: false)  String? token,  DateTime createdAt,  String role,  String tokenPrefix, @JsonKey(readValue: readIsRevoked)  bool isRevoked)  $default,) {final _that = this;
switch (_that) {
case _ApiToken():
return $default(_that.id,_that.label,_that.token,_that.createdAt,_that.role,_that.tokenPrefix,_that.isRevoked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label, @JsonKey(includeToJson: false)  String? token,  DateTime createdAt,  String role,  String tokenPrefix, @JsonKey(readValue: readIsRevoked)  bool isRevoked)?  $default,) {final _that = this;
switch (_that) {
case _ApiToken() when $default != null:
return $default(_that.id,_that.label,_that.token,_that.createdAt,_that.role,_that.tokenPrefix,_that.isRevoked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiToken implements ApiToken {
  const _ApiToken({required this.id, required this.label, @JsonKey(includeToJson: false) this.token, required this.createdAt, this.role = 'player', this.tokenPrefix = '', @JsonKey(readValue: readIsRevoked) this.isRevoked = false});
  factory _ApiToken.fromJson(Map<String, dynamic> json) => _$ApiTokenFromJson(json);

@override final  String id;
@override final  String label;
@override@JsonKey(includeToJson: false) final  String? token;
@override final  DateTime createdAt;
@override@JsonKey() final  String role;
@override@JsonKey() final  String tokenPrefix;
@override@JsonKey(readValue: readIsRevoked) final  bool isRevoked;

/// Create a copy of ApiToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiTokenCopyWith<_ApiToken> get copyWith => __$ApiTokenCopyWithImpl<_ApiToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiToken&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.token, token) || other.token == token)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.role, role) || other.role == role)&&(identical(other.tokenPrefix, tokenPrefix) || other.tokenPrefix == tokenPrefix)&&(identical(other.isRevoked, isRevoked) || other.isRevoked == isRevoked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,token,createdAt,role,tokenPrefix,isRevoked);



}

/// @nodoc
abstract mixin class _$ApiTokenCopyWith<$Res> implements $ApiTokenCopyWith<$Res> {
  factory _$ApiTokenCopyWith(_ApiToken value, $Res Function(_ApiToken) _then) = __$ApiTokenCopyWithImpl;
@override @useResult
$Res call({
 String id, String label,@JsonKey(includeToJson: false) String? token, DateTime createdAt, String role, String tokenPrefix,@JsonKey(readValue: readIsRevoked) bool isRevoked
});




}
/// @nodoc
class __$ApiTokenCopyWithImpl<$Res>
    implements _$ApiTokenCopyWith<$Res> {
  __$ApiTokenCopyWithImpl(this._self, this._then);

  final _ApiToken _self;
  final $Res Function(_ApiToken) _then;

/// Create a copy of ApiToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? token = freezed,Object? createdAt = null,Object? role = null,Object? tokenPrefix = null,Object? isRevoked = null,}) {
  return _then(_ApiToken(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,tokenPrefix: null == tokenPrefix ? _self.tokenPrefix : tokenPrefix // ignore: cast_nullable_to_non_nullable
as String,isRevoked: null == isRevoked ? _self.isRevoked : isRevoked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
