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

 String get id; String get displayName;@JsonKey(unknownEnumValue: StaffRole.viewer) StaffRole get role;@JsonKey(readValue: readCanWrite) bool get canWrite;
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
 String id, String displayName,@JsonKey(unknownEnumValue: StaffRole.viewer) StaffRole role,@JsonKey(readValue: readCanWrite) bool canWrite
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName, @JsonKey(unknownEnumValue: StaffRole.viewer)  StaffRole role, @JsonKey(readValue: readCanWrite)  bool canWrite)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName, @JsonKey(unknownEnumValue: StaffRole.viewer)  StaffRole role, @JsonKey(readValue: readCanWrite)  bool canWrite)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName, @JsonKey(unknownEnumValue: StaffRole.viewer)  StaffRole role, @JsonKey(readValue: readCanWrite)  bool canWrite)?  $default,) {final _that = this;
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
  const _CurrentStaff({required this.id, required this.displayName, @JsonKey(unknownEnumValue: StaffRole.viewer) required this.role, @JsonKey(readValue: readCanWrite) this.canWrite = false});
  factory _CurrentStaff.fromJson(Map<String, dynamic> json) => _$CurrentStaffFromJson(json);

@override final  String id;
@override final  String displayName;
@override@JsonKey(unknownEnumValue: StaffRole.viewer) final  StaffRole role;
@override@JsonKey(readValue: readCanWrite) final  bool canWrite;

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
 String id, String displayName,@JsonKey(unknownEnumValue: StaffRole.viewer) StaffRole role,@JsonKey(readValue: readCanWrite) bool canWrite
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

 String get playerId; String get displayName; String get status; num get walletTotal; int get stayDurationMinutes; num? get estimatedTotal; List<LiveGlobalCapWindow> get globalCapWindows; List<LiveSession> get sessions;
/// Create a copy of LivePlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivePlayerCopyWith<LivePlayer> get copyWith => _$LivePlayerCopyWithImpl<LivePlayer>(this as LivePlayer, _$identity);

  /// Serializes this LivePlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivePlayer&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.walletTotal, walletTotal) || other.walletTotal == walletTotal)&&(identical(other.stayDurationMinutes, stayDurationMinutes) || other.stayDurationMinutes == stayDurationMinutes)&&(identical(other.estimatedTotal, estimatedTotal) || other.estimatedTotal == estimatedTotal)&&const DeepCollectionEquality().equals(other.globalCapWindows, globalCapWindows)&&const DeepCollectionEquality().equals(other.sessions, sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,displayName,status,walletTotal,stayDurationMinutes,estimatedTotal,const DeepCollectionEquality().hash(globalCapWindows),const DeepCollectionEquality().hash(sessions));

@override
String toString() {
  return 'LivePlayer(playerId: $playerId, displayName: $displayName, status: $status, walletTotal: $walletTotal, stayDurationMinutes: $stayDurationMinutes, estimatedTotal: $estimatedTotal, globalCapWindows: $globalCapWindows, sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class $LivePlayerCopyWith<$Res>  {
  factory $LivePlayerCopyWith(LivePlayer value, $Res Function(LivePlayer) _then) = _$LivePlayerCopyWithImpl;
@useResult
$Res call({
 String playerId, String displayName, String status, num walletTotal, int stayDurationMinutes, num? estimatedTotal, List<LiveGlobalCapWindow> globalCapWindows, List<LiveSession> sessions
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
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? displayName = null,Object? status = null,Object? walletTotal = null,Object? stayDurationMinutes = null,Object? estimatedTotal = freezed,Object? globalCapWindows = null,Object? sessions = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,walletTotal: null == walletTotal ? _self.walletTotal : walletTotal // ignore: cast_nullable_to_non_nullable
as num,stayDurationMinutes: null == stayDurationMinutes ? _self.stayDurationMinutes : stayDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,estimatedTotal: freezed == estimatedTotal ? _self.estimatedTotal : estimatedTotal // ignore: cast_nullable_to_non_nullable
as num?,globalCapWindows: null == globalCapWindows ? _self.globalCapWindows : globalCapWindows // ignore: cast_nullable_to_non_nullable
as List<LiveGlobalCapWindow>,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  String displayName,  String status,  num walletTotal,  int stayDurationMinutes,  num? estimatedTotal,  List<LiveGlobalCapWindow> globalCapWindows,  List<LiveSession> sessions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivePlayer() when $default != null:
return $default(_that.playerId,_that.displayName,_that.status,_that.walletTotal,_that.stayDurationMinutes,_that.estimatedTotal,_that.globalCapWindows,_that.sessions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  String displayName,  String status,  num walletTotal,  int stayDurationMinutes,  num? estimatedTotal,  List<LiveGlobalCapWindow> globalCapWindows,  List<LiveSession> sessions)  $default,) {final _that = this;
switch (_that) {
case _LivePlayer():
return $default(_that.playerId,_that.displayName,_that.status,_that.walletTotal,_that.stayDurationMinutes,_that.estimatedTotal,_that.globalCapWindows,_that.sessions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  String displayName,  String status,  num walletTotal,  int stayDurationMinutes,  num? estimatedTotal,  List<LiveGlobalCapWindow> globalCapWindows,  List<LiveSession> sessions)?  $default,) {final _that = this;
switch (_that) {
case _LivePlayer() when $default != null:
return $default(_that.playerId,_that.displayName,_that.status,_that.walletTotal,_that.stayDurationMinutes,_that.estimatedTotal,_that.globalCapWindows,_that.sessions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivePlayer extends LivePlayer {
  const _LivePlayer({required this.playerId, required this.displayName, required this.status, required this.walletTotal, required this.stayDurationMinutes, this.estimatedTotal, final  List<LiveGlobalCapWindow> globalCapWindows = const [], required final  List<LiveSession> sessions}): _globalCapWindows = globalCapWindows,_sessions = sessions,super._();
  factory _LivePlayer.fromJson(Map<String, dynamic> json) => _$LivePlayerFromJson(json);

@override final  String playerId;
@override final  String displayName;
@override final  String status;
@override final  num walletTotal;
@override final  int stayDurationMinutes;
@override final  num? estimatedTotal;
 final  List<LiveGlobalCapWindow> _globalCapWindows;
@override@JsonKey() List<LiveGlobalCapWindow> get globalCapWindows {
  if (_globalCapWindows is EqualUnmodifiableListView) return _globalCapWindows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_globalCapWindows);
}

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivePlayer&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.walletTotal, walletTotal) || other.walletTotal == walletTotal)&&(identical(other.stayDurationMinutes, stayDurationMinutes) || other.stayDurationMinutes == stayDurationMinutes)&&(identical(other.estimatedTotal, estimatedTotal) || other.estimatedTotal == estimatedTotal)&&const DeepCollectionEquality().equals(other._globalCapWindows, _globalCapWindows)&&const DeepCollectionEquality().equals(other._sessions, _sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,displayName,status,walletTotal,stayDurationMinutes,estimatedTotal,const DeepCollectionEquality().hash(_globalCapWindows),const DeepCollectionEquality().hash(_sessions));

@override
String toString() {
  return 'LivePlayer(playerId: $playerId, displayName: $displayName, status: $status, walletTotal: $walletTotal, stayDurationMinutes: $stayDurationMinutes, estimatedTotal: $estimatedTotal, globalCapWindows: $globalCapWindows, sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class _$LivePlayerCopyWith<$Res> implements $LivePlayerCopyWith<$Res> {
  factory _$LivePlayerCopyWith(_LivePlayer value, $Res Function(_LivePlayer) _then) = __$LivePlayerCopyWithImpl;
@override @useResult
$Res call({
 String playerId, String displayName, String status, num walletTotal, int stayDurationMinutes, num? estimatedTotal, List<LiveGlobalCapWindow> globalCapWindows, List<LiveSession> sessions
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
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? displayName = null,Object? status = null,Object? walletTotal = null,Object? stayDurationMinutes = null,Object? estimatedTotal = freezed,Object? globalCapWindows = null,Object? sessions = null,}) {
  return _then(_LivePlayer(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,walletTotal: null == walletTotal ? _self.walletTotal : walletTotal // ignore: cast_nullable_to_non_nullable
as num,stayDurationMinutes: null == stayDurationMinutes ? _self.stayDurationMinutes : stayDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,estimatedTotal: freezed == estimatedTotal ? _self.estimatedTotal : estimatedTotal // ignore: cast_nullable_to_non_nullable
as num?,globalCapWindows: null == globalCapWindows ? _self._globalCapWindows : globalCapWindows // ignore: cast_nullable_to_non_nullable
as List<LiveGlobalCapWindow>,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<LiveSession>,
  ));
}


}


/// @nodoc
mixin _$LiveSession {

@JsonKey(readValue: readSessionId) String get id; String? get label; DateTime get startedAt; DateTime? get endedAt;@JsonKey(readValue: readElapsedMinutes) int get elapsedMinutes;@JsonKey(readValue: readCurrentImpact) num? get currentImpact; List<LivePricingCharge> get pricingCharges; List<LivePricingSegment> get pricingSegments; String get status;
/// Create a copy of LiveSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveSessionCopyWith<LiveSession> get copyWith => _$LiveSessionCopyWithImpl<LiveSession>(this as LiveSession, _$identity);

  /// Serializes this LiveSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveSession&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.elapsedMinutes, elapsedMinutes) || other.elapsedMinutes == elapsedMinutes)&&(identical(other.currentImpact, currentImpact) || other.currentImpact == currentImpact)&&const DeepCollectionEquality().equals(other.pricingCharges, pricingCharges)&&const DeepCollectionEquality().equals(other.pricingSegments, pricingSegments)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,startedAt,endedAt,elapsedMinutes,currentImpact,const DeepCollectionEquality().hash(pricingCharges),const DeepCollectionEquality().hash(pricingSegments),status);

@override
String toString() {
  return 'LiveSession(id: $id, label: $label, startedAt: $startedAt, endedAt: $endedAt, elapsedMinutes: $elapsedMinutes, currentImpact: $currentImpact, pricingCharges: $pricingCharges, pricingSegments: $pricingSegments, status: $status)';
}


}

/// @nodoc
abstract mixin class $LiveSessionCopyWith<$Res>  {
  factory $LiveSessionCopyWith(LiveSession value, $Res Function(LiveSession) _then) = _$LiveSessionCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: readSessionId) String id, String? label, DateTime startedAt, DateTime? endedAt,@JsonKey(readValue: readElapsedMinutes) int elapsedMinutes,@JsonKey(readValue: readCurrentImpact) num? currentImpact, List<LivePricingCharge> pricingCharges, List<LivePricingSegment> pricingSegments, String status
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? elapsedMinutes = null,Object? currentImpact = freezed,Object? pricingCharges = null,Object? pricingSegments = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,elapsedMinutes: null == elapsedMinutes ? _self.elapsedMinutes : elapsedMinutes // ignore: cast_nullable_to_non_nullable
as int,currentImpact: freezed == currentImpact ? _self.currentImpact : currentImpact // ignore: cast_nullable_to_non_nullable
as num?,pricingCharges: null == pricingCharges ? _self.pricingCharges : pricingCharges // ignore: cast_nullable_to_non_nullable
as List<LivePricingCharge>,pricingSegments: null == pricingSegments ? _self.pricingSegments : pricingSegments // ignore: cast_nullable_to_non_nullable
as List<LivePricingSegment>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: readSessionId)  String id,  String? label,  DateTime startedAt,  DateTime? endedAt, @JsonKey(readValue: readElapsedMinutes)  int elapsedMinutes, @JsonKey(readValue: readCurrentImpact)  num? currentImpact,  List<LivePricingCharge> pricingCharges,  List<LivePricingSegment> pricingSegments,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveSession() when $default != null:
return $default(_that.id,_that.label,_that.startedAt,_that.endedAt,_that.elapsedMinutes,_that.currentImpact,_that.pricingCharges,_that.pricingSegments,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: readSessionId)  String id,  String? label,  DateTime startedAt,  DateTime? endedAt, @JsonKey(readValue: readElapsedMinutes)  int elapsedMinutes, @JsonKey(readValue: readCurrentImpact)  num? currentImpact,  List<LivePricingCharge> pricingCharges,  List<LivePricingSegment> pricingSegments,  String status)  $default,) {final _that = this;
switch (_that) {
case _LiveSession():
return $default(_that.id,_that.label,_that.startedAt,_that.endedAt,_that.elapsedMinutes,_that.currentImpact,_that.pricingCharges,_that.pricingSegments,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: readSessionId)  String id,  String? label,  DateTime startedAt,  DateTime? endedAt, @JsonKey(readValue: readElapsedMinutes)  int elapsedMinutes, @JsonKey(readValue: readCurrentImpact)  num? currentImpact,  List<LivePricingCharge> pricingCharges,  List<LivePricingSegment> pricingSegments,  String status)?  $default,) {final _that = this;
switch (_that) {
case _LiveSession() when $default != null:
return $default(_that.id,_that.label,_that.startedAt,_that.endedAt,_that.elapsedMinutes,_that.currentImpact,_that.pricingCharges,_that.pricingSegments,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveSession extends LiveSession {
  const _LiveSession({@JsonKey(readValue: readSessionId) required this.id, this.label, required this.startedAt, this.endedAt, @JsonKey(readValue: readElapsedMinutes) this.elapsedMinutes = 0, @JsonKey(readValue: readCurrentImpact) this.currentImpact, final  List<LivePricingCharge> pricingCharges = const [], final  List<LivePricingSegment> pricingSegments = const [], this.status = 'closed'}): _pricingCharges = pricingCharges,_pricingSegments = pricingSegments,super._();
  factory _LiveSession.fromJson(Map<String, dynamic> json) => _$LiveSessionFromJson(json);

@override@JsonKey(readValue: readSessionId) final  String id;
@override final  String? label;
@override final  DateTime startedAt;
@override final  DateTime? endedAt;
@override@JsonKey(readValue: readElapsedMinutes) final  int elapsedMinutes;
@override@JsonKey(readValue: readCurrentImpact) final  num? currentImpact;
 final  List<LivePricingCharge> _pricingCharges;
@override@JsonKey() List<LivePricingCharge> get pricingCharges {
  if (_pricingCharges is EqualUnmodifiableListView) return _pricingCharges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pricingCharges);
}

 final  List<LivePricingSegment> _pricingSegments;
@override@JsonKey() List<LivePricingSegment> get pricingSegments {
  if (_pricingSegments is EqualUnmodifiableListView) return _pricingSegments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pricingSegments);
}

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveSession&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.elapsedMinutes, elapsedMinutes) || other.elapsedMinutes == elapsedMinutes)&&(identical(other.currentImpact, currentImpact) || other.currentImpact == currentImpact)&&const DeepCollectionEquality().equals(other._pricingCharges, _pricingCharges)&&const DeepCollectionEquality().equals(other._pricingSegments, _pricingSegments)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,startedAt,endedAt,elapsedMinutes,currentImpact,const DeepCollectionEquality().hash(_pricingCharges),const DeepCollectionEquality().hash(_pricingSegments),status);

@override
String toString() {
  return 'LiveSession(id: $id, label: $label, startedAt: $startedAt, endedAt: $endedAt, elapsedMinutes: $elapsedMinutes, currentImpact: $currentImpact, pricingCharges: $pricingCharges, pricingSegments: $pricingSegments, status: $status)';
}


}

/// @nodoc
abstract mixin class _$LiveSessionCopyWith<$Res> implements $LiveSessionCopyWith<$Res> {
  factory _$LiveSessionCopyWith(_LiveSession value, $Res Function(_LiveSession) _then) = __$LiveSessionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: readSessionId) String id, String? label, DateTime startedAt, DateTime? endedAt,@JsonKey(readValue: readElapsedMinutes) int elapsedMinutes,@JsonKey(readValue: readCurrentImpact) num? currentImpact, List<LivePricingCharge> pricingCharges, List<LivePricingSegment> pricingSegments, String status
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? elapsedMinutes = null,Object? currentImpact = freezed,Object? pricingCharges = null,Object? pricingSegments = null,Object? status = null,}) {
  return _then(_LiveSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,elapsedMinutes: null == elapsedMinutes ? _self.elapsedMinutes : elapsedMinutes // ignore: cast_nullable_to_non_nullable
as int,currentImpact: freezed == currentImpact ? _self.currentImpact : currentImpact // ignore: cast_nullable_to_non_nullable
as num?,pricingCharges: null == pricingCharges ? _self._pricingCharges : pricingCharges // ignore: cast_nullable_to_non_nullable
as List<LivePricingCharge>,pricingSegments: null == pricingSegments ? _self._pricingSegments : pricingSegments // ignore: cast_nullable_to_non_nullable
as List<LivePricingSegment>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LivePricingSegment {

 String get pricingConfigId; String get planName; String get providerId; String get ruleId; String get ruleLabel; DateTime get actualStartedAt; DateTime get actualEndedAt; Map<String, dynamic>? get ruleTimeRange; num get amount; num get intervalCap; bool get intervalCapReached;
/// Create a copy of LivePricingSegment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivePricingSegmentCopyWith<LivePricingSegment> get copyWith => _$LivePricingSegmentCopyWithImpl<LivePricingSegment>(this as LivePricingSegment, _$identity);

  /// Serializes this LivePricingSegment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivePricingSegment&&(identical(other.pricingConfigId, pricingConfigId) || other.pricingConfigId == pricingConfigId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.ruleLabel, ruleLabel) || other.ruleLabel == ruleLabel)&&(identical(other.actualStartedAt, actualStartedAt) || other.actualStartedAt == actualStartedAt)&&(identical(other.actualEndedAt, actualEndedAt) || other.actualEndedAt == actualEndedAt)&&const DeepCollectionEquality().equals(other.ruleTimeRange, ruleTimeRange)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.intervalCap, intervalCap) || other.intervalCap == intervalCap)&&(identical(other.intervalCapReached, intervalCapReached) || other.intervalCapReached == intervalCapReached));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pricingConfigId,planName,providerId,ruleId,ruleLabel,actualStartedAt,actualEndedAt,const DeepCollectionEquality().hash(ruleTimeRange),amount,intervalCap,intervalCapReached);

@override
String toString() {
  return 'LivePricingSegment(pricingConfigId: $pricingConfigId, planName: $planName, providerId: $providerId, ruleId: $ruleId, ruleLabel: $ruleLabel, actualStartedAt: $actualStartedAt, actualEndedAt: $actualEndedAt, ruleTimeRange: $ruleTimeRange, amount: $amount, intervalCap: $intervalCap, intervalCapReached: $intervalCapReached)';
}


}

/// @nodoc
abstract mixin class $LivePricingSegmentCopyWith<$Res>  {
  factory $LivePricingSegmentCopyWith(LivePricingSegment value, $Res Function(LivePricingSegment) _then) = _$LivePricingSegmentCopyWithImpl;
@useResult
$Res call({
 String pricingConfigId, String planName, String providerId, String ruleId, String ruleLabel, DateTime actualStartedAt, DateTime actualEndedAt, Map<String, dynamic>? ruleTimeRange, num amount, num intervalCap, bool intervalCapReached
});




}
/// @nodoc
class _$LivePricingSegmentCopyWithImpl<$Res>
    implements $LivePricingSegmentCopyWith<$Res> {
  _$LivePricingSegmentCopyWithImpl(this._self, this._then);

  final LivePricingSegment _self;
  final $Res Function(LivePricingSegment) _then;

/// Create a copy of LivePricingSegment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pricingConfigId = null,Object? planName = null,Object? providerId = null,Object? ruleId = null,Object? ruleLabel = null,Object? actualStartedAt = null,Object? actualEndedAt = null,Object? ruleTimeRange = freezed,Object? amount = null,Object? intervalCap = null,Object? intervalCapReached = null,}) {
  return _then(_self.copyWith(
pricingConfigId: null == pricingConfigId ? _self.pricingConfigId : pricingConfigId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,ruleLabel: null == ruleLabel ? _self.ruleLabel : ruleLabel // ignore: cast_nullable_to_non_nullable
as String,actualStartedAt: null == actualStartedAt ? _self.actualStartedAt : actualStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime,actualEndedAt: null == actualEndedAt ? _self.actualEndedAt : actualEndedAt // ignore: cast_nullable_to_non_nullable
as DateTime,ruleTimeRange: freezed == ruleTimeRange ? _self.ruleTimeRange : ruleTimeRange // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,intervalCap: null == intervalCap ? _self.intervalCap : intervalCap // ignore: cast_nullable_to_non_nullable
as num,intervalCapReached: null == intervalCapReached ? _self.intervalCapReached : intervalCapReached // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LivePricingSegment].
extension LivePricingSegmentPatterns on LivePricingSegment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivePricingSegment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivePricingSegment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivePricingSegment value)  $default,){
final _that = this;
switch (_that) {
case _LivePricingSegment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivePricingSegment value)?  $default,){
final _that = this;
switch (_that) {
case _LivePricingSegment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pricingConfigId,  String planName,  String providerId,  String ruleId,  String ruleLabel,  DateTime actualStartedAt,  DateTime actualEndedAt,  Map<String, dynamic>? ruleTimeRange,  num amount,  num intervalCap,  bool intervalCapReached)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivePricingSegment() when $default != null:
return $default(_that.pricingConfigId,_that.planName,_that.providerId,_that.ruleId,_that.ruleLabel,_that.actualStartedAt,_that.actualEndedAt,_that.ruleTimeRange,_that.amount,_that.intervalCap,_that.intervalCapReached);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pricingConfigId,  String planName,  String providerId,  String ruleId,  String ruleLabel,  DateTime actualStartedAt,  DateTime actualEndedAt,  Map<String, dynamic>? ruleTimeRange,  num amount,  num intervalCap,  bool intervalCapReached)  $default,) {final _that = this;
switch (_that) {
case _LivePricingSegment():
return $default(_that.pricingConfigId,_that.planName,_that.providerId,_that.ruleId,_that.ruleLabel,_that.actualStartedAt,_that.actualEndedAt,_that.ruleTimeRange,_that.amount,_that.intervalCap,_that.intervalCapReached);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pricingConfigId,  String planName,  String providerId,  String ruleId,  String ruleLabel,  DateTime actualStartedAt,  DateTime actualEndedAt,  Map<String, dynamic>? ruleTimeRange,  num amount,  num intervalCap,  bool intervalCapReached)?  $default,) {final _that = this;
switch (_that) {
case _LivePricingSegment() when $default != null:
return $default(_that.pricingConfigId,_that.planName,_that.providerId,_that.ruleId,_that.ruleLabel,_that.actualStartedAt,_that.actualEndedAt,_that.ruleTimeRange,_that.amount,_that.intervalCap,_that.intervalCapReached);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivePricingSegment implements LivePricingSegment {
  const _LivePricingSegment({required this.pricingConfigId, required this.planName, required this.providerId, required this.ruleId, required this.ruleLabel, required this.actualStartedAt, required this.actualEndedAt, final  Map<String, dynamic>? ruleTimeRange, required this.amount, required this.intervalCap, this.intervalCapReached = false}): _ruleTimeRange = ruleTimeRange;
  factory _LivePricingSegment.fromJson(Map<String, dynamic> json) => _$LivePricingSegmentFromJson(json);

@override final  String pricingConfigId;
@override final  String planName;
@override final  String providerId;
@override final  String ruleId;
@override final  String ruleLabel;
@override final  DateTime actualStartedAt;
@override final  DateTime actualEndedAt;
 final  Map<String, dynamic>? _ruleTimeRange;
@override Map<String, dynamic>? get ruleTimeRange {
  final value = _ruleTimeRange;
  if (value == null) return null;
  if (_ruleTimeRange is EqualUnmodifiableMapView) return _ruleTimeRange;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  num amount;
@override final  num intervalCap;
@override@JsonKey() final  bool intervalCapReached;

/// Create a copy of LivePricingSegment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivePricingSegmentCopyWith<_LivePricingSegment> get copyWith => __$LivePricingSegmentCopyWithImpl<_LivePricingSegment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivePricingSegmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivePricingSegment&&(identical(other.pricingConfigId, pricingConfigId) || other.pricingConfigId == pricingConfigId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.ruleLabel, ruleLabel) || other.ruleLabel == ruleLabel)&&(identical(other.actualStartedAt, actualStartedAt) || other.actualStartedAt == actualStartedAt)&&(identical(other.actualEndedAt, actualEndedAt) || other.actualEndedAt == actualEndedAt)&&const DeepCollectionEquality().equals(other._ruleTimeRange, _ruleTimeRange)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.intervalCap, intervalCap) || other.intervalCap == intervalCap)&&(identical(other.intervalCapReached, intervalCapReached) || other.intervalCapReached == intervalCapReached));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pricingConfigId,planName,providerId,ruleId,ruleLabel,actualStartedAt,actualEndedAt,const DeepCollectionEquality().hash(_ruleTimeRange),amount,intervalCap,intervalCapReached);

@override
String toString() {
  return 'LivePricingSegment(pricingConfigId: $pricingConfigId, planName: $planName, providerId: $providerId, ruleId: $ruleId, ruleLabel: $ruleLabel, actualStartedAt: $actualStartedAt, actualEndedAt: $actualEndedAt, ruleTimeRange: $ruleTimeRange, amount: $amount, intervalCap: $intervalCap, intervalCapReached: $intervalCapReached)';
}


}

/// @nodoc
abstract mixin class _$LivePricingSegmentCopyWith<$Res> implements $LivePricingSegmentCopyWith<$Res> {
  factory _$LivePricingSegmentCopyWith(_LivePricingSegment value, $Res Function(_LivePricingSegment) _then) = __$LivePricingSegmentCopyWithImpl;
@override @useResult
$Res call({
 String pricingConfigId, String planName, String providerId, String ruleId, String ruleLabel, DateTime actualStartedAt, DateTime actualEndedAt, Map<String, dynamic>? ruleTimeRange, num amount, num intervalCap, bool intervalCapReached
});




}
/// @nodoc
class __$LivePricingSegmentCopyWithImpl<$Res>
    implements _$LivePricingSegmentCopyWith<$Res> {
  __$LivePricingSegmentCopyWithImpl(this._self, this._then);

  final _LivePricingSegment _self;
  final $Res Function(_LivePricingSegment) _then;

/// Create a copy of LivePricingSegment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pricingConfigId = null,Object? planName = null,Object? providerId = null,Object? ruleId = null,Object? ruleLabel = null,Object? actualStartedAt = null,Object? actualEndedAt = null,Object? ruleTimeRange = freezed,Object? amount = null,Object? intervalCap = null,Object? intervalCapReached = null,}) {
  return _then(_LivePricingSegment(
pricingConfigId: null == pricingConfigId ? _self.pricingConfigId : pricingConfigId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,ruleLabel: null == ruleLabel ? _self.ruleLabel : ruleLabel // ignore: cast_nullable_to_non_nullable
as String,actualStartedAt: null == actualStartedAt ? _self.actualStartedAt : actualStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime,actualEndedAt: null == actualEndedAt ? _self.actualEndedAt : actualEndedAt // ignore: cast_nullable_to_non_nullable
as DateTime,ruleTimeRange: freezed == ruleTimeRange ? _self._ruleTimeRange : ruleTimeRange // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,intervalCap: null == intervalCap ? _self.intervalCap : intervalCap // ignore: cast_nullable_to_non_nullable
as num,intervalCapReached: null == intervalCapReached ? _self.intervalCapReached : intervalCapReached // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$LiveGlobalCapWindow {

 String get key; String get capConfigId; String get capRuleId; String get ruleLabel; DateTime get windowStartedAt; DateTime get windowEndedAt; num get priceCap; num get paidBefore; num get currentAmount; num get amountApplied; bool get priceCapReached; List<LiveGlobalCapContribution> get contributions;
/// Create a copy of LiveGlobalCapWindow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveGlobalCapWindowCopyWith<LiveGlobalCapWindow> get copyWith => _$LiveGlobalCapWindowCopyWithImpl<LiveGlobalCapWindow>(this as LiveGlobalCapWindow, _$identity);

  /// Serializes this LiveGlobalCapWindow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveGlobalCapWindow&&(identical(other.key, key) || other.key == key)&&(identical(other.capConfigId, capConfigId) || other.capConfigId == capConfigId)&&(identical(other.capRuleId, capRuleId) || other.capRuleId == capRuleId)&&(identical(other.ruleLabel, ruleLabel) || other.ruleLabel == ruleLabel)&&(identical(other.windowStartedAt, windowStartedAt) || other.windowStartedAt == windowStartedAt)&&(identical(other.windowEndedAt, windowEndedAt) || other.windowEndedAt == windowEndedAt)&&(identical(other.priceCap, priceCap) || other.priceCap == priceCap)&&(identical(other.paidBefore, paidBefore) || other.paidBefore == paidBefore)&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.amountApplied, amountApplied) || other.amountApplied == amountApplied)&&(identical(other.priceCapReached, priceCapReached) || other.priceCapReached == priceCapReached)&&const DeepCollectionEquality().equals(other.contributions, contributions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,capConfigId,capRuleId,ruleLabel,windowStartedAt,windowEndedAt,priceCap,paidBefore,currentAmount,amountApplied,priceCapReached,const DeepCollectionEquality().hash(contributions));

@override
String toString() {
  return 'LiveGlobalCapWindow(key: $key, capConfigId: $capConfigId, capRuleId: $capRuleId, ruleLabel: $ruleLabel, windowStartedAt: $windowStartedAt, windowEndedAt: $windowEndedAt, priceCap: $priceCap, paidBefore: $paidBefore, currentAmount: $currentAmount, amountApplied: $amountApplied, priceCapReached: $priceCapReached, contributions: $contributions)';
}


}

/// @nodoc
abstract mixin class $LiveGlobalCapWindowCopyWith<$Res>  {
  factory $LiveGlobalCapWindowCopyWith(LiveGlobalCapWindow value, $Res Function(LiveGlobalCapWindow) _then) = _$LiveGlobalCapWindowCopyWithImpl;
@useResult
$Res call({
 String key, String capConfigId, String capRuleId, String ruleLabel, DateTime windowStartedAt, DateTime windowEndedAt, num priceCap, num paidBefore, num currentAmount, num amountApplied, bool priceCapReached, List<LiveGlobalCapContribution> contributions
});




}
/// @nodoc
class _$LiveGlobalCapWindowCopyWithImpl<$Res>
    implements $LiveGlobalCapWindowCopyWith<$Res> {
  _$LiveGlobalCapWindowCopyWithImpl(this._self, this._then);

  final LiveGlobalCapWindow _self;
  final $Res Function(LiveGlobalCapWindow) _then;

/// Create a copy of LiveGlobalCapWindow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? capConfigId = null,Object? capRuleId = null,Object? ruleLabel = null,Object? windowStartedAt = null,Object? windowEndedAt = null,Object? priceCap = null,Object? paidBefore = null,Object? currentAmount = null,Object? amountApplied = null,Object? priceCapReached = null,Object? contributions = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,capConfigId: null == capConfigId ? _self.capConfigId : capConfigId // ignore: cast_nullable_to_non_nullable
as String,capRuleId: null == capRuleId ? _self.capRuleId : capRuleId // ignore: cast_nullable_to_non_nullable
as String,ruleLabel: null == ruleLabel ? _self.ruleLabel : ruleLabel // ignore: cast_nullable_to_non_nullable
as String,windowStartedAt: null == windowStartedAt ? _self.windowStartedAt : windowStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime,windowEndedAt: null == windowEndedAt ? _self.windowEndedAt : windowEndedAt // ignore: cast_nullable_to_non_nullable
as DateTime,priceCap: null == priceCap ? _self.priceCap : priceCap // ignore: cast_nullable_to_non_nullable
as num,paidBefore: null == paidBefore ? _self.paidBefore : paidBefore // ignore: cast_nullable_to_non_nullable
as num,currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as num,amountApplied: null == amountApplied ? _self.amountApplied : amountApplied // ignore: cast_nullable_to_non_nullable
as num,priceCapReached: null == priceCapReached ? _self.priceCapReached : priceCapReached // ignore: cast_nullable_to_non_nullable
as bool,contributions: null == contributions ? _self.contributions : contributions // ignore: cast_nullable_to_non_nullable
as List<LiveGlobalCapContribution>,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveGlobalCapWindow].
extension LiveGlobalCapWindowPatterns on LiveGlobalCapWindow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveGlobalCapWindow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveGlobalCapWindow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveGlobalCapWindow value)  $default,){
final _that = this;
switch (_that) {
case _LiveGlobalCapWindow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveGlobalCapWindow value)?  $default,){
final _that = this;
switch (_that) {
case _LiveGlobalCapWindow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String capConfigId,  String capRuleId,  String ruleLabel,  DateTime windowStartedAt,  DateTime windowEndedAt,  num priceCap,  num paidBefore,  num currentAmount,  num amountApplied,  bool priceCapReached,  List<LiveGlobalCapContribution> contributions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveGlobalCapWindow() when $default != null:
return $default(_that.key,_that.capConfigId,_that.capRuleId,_that.ruleLabel,_that.windowStartedAt,_that.windowEndedAt,_that.priceCap,_that.paidBefore,_that.currentAmount,_that.amountApplied,_that.priceCapReached,_that.contributions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String capConfigId,  String capRuleId,  String ruleLabel,  DateTime windowStartedAt,  DateTime windowEndedAt,  num priceCap,  num paidBefore,  num currentAmount,  num amountApplied,  bool priceCapReached,  List<LiveGlobalCapContribution> contributions)  $default,) {final _that = this;
switch (_that) {
case _LiveGlobalCapWindow():
return $default(_that.key,_that.capConfigId,_that.capRuleId,_that.ruleLabel,_that.windowStartedAt,_that.windowEndedAt,_that.priceCap,_that.paidBefore,_that.currentAmount,_that.amountApplied,_that.priceCapReached,_that.contributions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String capConfigId,  String capRuleId,  String ruleLabel,  DateTime windowStartedAt,  DateTime windowEndedAt,  num priceCap,  num paidBefore,  num currentAmount,  num amountApplied,  bool priceCapReached,  List<LiveGlobalCapContribution> contributions)?  $default,) {final _that = this;
switch (_that) {
case _LiveGlobalCapWindow() when $default != null:
return $default(_that.key,_that.capConfigId,_that.capRuleId,_that.ruleLabel,_that.windowStartedAt,_that.windowEndedAt,_that.priceCap,_that.paidBefore,_that.currentAmount,_that.amountApplied,_that.priceCapReached,_that.contributions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveGlobalCapWindow implements LiveGlobalCapWindow {
  const _LiveGlobalCapWindow({required this.key, required this.capConfigId, required this.capRuleId, required this.ruleLabel, required this.windowStartedAt, required this.windowEndedAt, required this.priceCap, required this.paidBefore, required this.currentAmount, required this.amountApplied, this.priceCapReached = false, final  List<LiveGlobalCapContribution> contributions = const []}): _contributions = contributions;
  factory _LiveGlobalCapWindow.fromJson(Map<String, dynamic> json) => _$LiveGlobalCapWindowFromJson(json);

@override final  String key;
@override final  String capConfigId;
@override final  String capRuleId;
@override final  String ruleLabel;
@override final  DateTime windowStartedAt;
@override final  DateTime windowEndedAt;
@override final  num priceCap;
@override final  num paidBefore;
@override final  num currentAmount;
@override final  num amountApplied;
@override@JsonKey() final  bool priceCapReached;
 final  List<LiveGlobalCapContribution> _contributions;
@override@JsonKey() List<LiveGlobalCapContribution> get contributions {
  if (_contributions is EqualUnmodifiableListView) return _contributions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contributions);
}


/// Create a copy of LiveGlobalCapWindow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveGlobalCapWindowCopyWith<_LiveGlobalCapWindow> get copyWith => __$LiveGlobalCapWindowCopyWithImpl<_LiveGlobalCapWindow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveGlobalCapWindowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveGlobalCapWindow&&(identical(other.key, key) || other.key == key)&&(identical(other.capConfigId, capConfigId) || other.capConfigId == capConfigId)&&(identical(other.capRuleId, capRuleId) || other.capRuleId == capRuleId)&&(identical(other.ruleLabel, ruleLabel) || other.ruleLabel == ruleLabel)&&(identical(other.windowStartedAt, windowStartedAt) || other.windowStartedAt == windowStartedAt)&&(identical(other.windowEndedAt, windowEndedAt) || other.windowEndedAt == windowEndedAt)&&(identical(other.priceCap, priceCap) || other.priceCap == priceCap)&&(identical(other.paidBefore, paidBefore) || other.paidBefore == paidBefore)&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.amountApplied, amountApplied) || other.amountApplied == amountApplied)&&(identical(other.priceCapReached, priceCapReached) || other.priceCapReached == priceCapReached)&&const DeepCollectionEquality().equals(other._contributions, _contributions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,capConfigId,capRuleId,ruleLabel,windowStartedAt,windowEndedAt,priceCap,paidBefore,currentAmount,amountApplied,priceCapReached,const DeepCollectionEquality().hash(_contributions));

@override
String toString() {
  return 'LiveGlobalCapWindow(key: $key, capConfigId: $capConfigId, capRuleId: $capRuleId, ruleLabel: $ruleLabel, windowStartedAt: $windowStartedAt, windowEndedAt: $windowEndedAt, priceCap: $priceCap, paidBefore: $paidBefore, currentAmount: $currentAmount, amountApplied: $amountApplied, priceCapReached: $priceCapReached, contributions: $contributions)';
}


}

/// @nodoc
abstract mixin class _$LiveGlobalCapWindowCopyWith<$Res> implements $LiveGlobalCapWindowCopyWith<$Res> {
  factory _$LiveGlobalCapWindowCopyWith(_LiveGlobalCapWindow value, $Res Function(_LiveGlobalCapWindow) _then) = __$LiveGlobalCapWindowCopyWithImpl;
@override @useResult
$Res call({
 String key, String capConfigId, String capRuleId, String ruleLabel, DateTime windowStartedAt, DateTime windowEndedAt, num priceCap, num paidBefore, num currentAmount, num amountApplied, bool priceCapReached, List<LiveGlobalCapContribution> contributions
});




}
/// @nodoc
class __$LiveGlobalCapWindowCopyWithImpl<$Res>
    implements _$LiveGlobalCapWindowCopyWith<$Res> {
  __$LiveGlobalCapWindowCopyWithImpl(this._self, this._then);

  final _LiveGlobalCapWindow _self;
  final $Res Function(_LiveGlobalCapWindow) _then;

/// Create a copy of LiveGlobalCapWindow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? capConfigId = null,Object? capRuleId = null,Object? ruleLabel = null,Object? windowStartedAt = null,Object? windowEndedAt = null,Object? priceCap = null,Object? paidBefore = null,Object? currentAmount = null,Object? amountApplied = null,Object? priceCapReached = null,Object? contributions = null,}) {
  return _then(_LiveGlobalCapWindow(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,capConfigId: null == capConfigId ? _self.capConfigId : capConfigId // ignore: cast_nullable_to_non_nullable
as String,capRuleId: null == capRuleId ? _self.capRuleId : capRuleId // ignore: cast_nullable_to_non_nullable
as String,ruleLabel: null == ruleLabel ? _self.ruleLabel : ruleLabel // ignore: cast_nullable_to_non_nullable
as String,windowStartedAt: null == windowStartedAt ? _self.windowStartedAt : windowStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime,windowEndedAt: null == windowEndedAt ? _self.windowEndedAt : windowEndedAt // ignore: cast_nullable_to_non_nullable
as DateTime,priceCap: null == priceCap ? _self.priceCap : priceCap // ignore: cast_nullable_to_non_nullable
as num,paidBefore: null == paidBefore ? _self.paidBefore : paidBefore // ignore: cast_nullable_to_non_nullable
as num,currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as num,amountApplied: null == amountApplied ? _self.amountApplied : amountApplied // ignore: cast_nullable_to_non_nullable
as num,priceCapReached: null == priceCapReached ? _self.priceCapReached : priceCapReached // ignore: cast_nullable_to_non_nullable
as bool,contributions: null == contributions ? _self._contributions : contributions // ignore: cast_nullable_to_non_nullable
as List<LiveGlobalCapContribution>,
  ));
}


}


/// @nodoc
mixin _$LiveGlobalCapContribution {

 String get sessionId; String get pricingConfigId; num get amount;
/// Create a copy of LiveGlobalCapContribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveGlobalCapContributionCopyWith<LiveGlobalCapContribution> get copyWith => _$LiveGlobalCapContributionCopyWithImpl<LiveGlobalCapContribution>(this as LiveGlobalCapContribution, _$identity);

  /// Serializes this LiveGlobalCapContribution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveGlobalCapContribution&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.pricingConfigId, pricingConfigId) || other.pricingConfigId == pricingConfigId)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,pricingConfigId,amount);

@override
String toString() {
  return 'LiveGlobalCapContribution(sessionId: $sessionId, pricingConfigId: $pricingConfigId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $LiveGlobalCapContributionCopyWith<$Res>  {
  factory $LiveGlobalCapContributionCopyWith(LiveGlobalCapContribution value, $Res Function(LiveGlobalCapContribution) _then) = _$LiveGlobalCapContributionCopyWithImpl;
@useResult
$Res call({
 String sessionId, String pricingConfigId, num amount
});




}
/// @nodoc
class _$LiveGlobalCapContributionCopyWithImpl<$Res>
    implements $LiveGlobalCapContributionCopyWith<$Res> {
  _$LiveGlobalCapContributionCopyWithImpl(this._self, this._then);

  final LiveGlobalCapContribution _self;
  final $Res Function(LiveGlobalCapContribution) _then;

/// Create a copy of LiveGlobalCapContribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? pricingConfigId = null,Object? amount = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,pricingConfigId: null == pricingConfigId ? _self.pricingConfigId : pricingConfigId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveGlobalCapContribution].
extension LiveGlobalCapContributionPatterns on LiveGlobalCapContribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveGlobalCapContribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveGlobalCapContribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveGlobalCapContribution value)  $default,){
final _that = this;
switch (_that) {
case _LiveGlobalCapContribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveGlobalCapContribution value)?  $default,){
final _that = this;
switch (_that) {
case _LiveGlobalCapContribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String pricingConfigId,  num amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveGlobalCapContribution() when $default != null:
return $default(_that.sessionId,_that.pricingConfigId,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String pricingConfigId,  num amount)  $default,) {final _that = this;
switch (_that) {
case _LiveGlobalCapContribution():
return $default(_that.sessionId,_that.pricingConfigId,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String pricingConfigId,  num amount)?  $default,) {final _that = this;
switch (_that) {
case _LiveGlobalCapContribution() when $default != null:
return $default(_that.sessionId,_that.pricingConfigId,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveGlobalCapContribution implements LiveGlobalCapContribution {
  const _LiveGlobalCapContribution({required this.sessionId, required this.pricingConfigId, required this.amount});
  factory _LiveGlobalCapContribution.fromJson(Map<String, dynamic> json) => _$LiveGlobalCapContributionFromJson(json);

@override final  String sessionId;
@override final  String pricingConfigId;
@override final  num amount;

/// Create a copy of LiveGlobalCapContribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveGlobalCapContributionCopyWith<_LiveGlobalCapContribution> get copyWith => __$LiveGlobalCapContributionCopyWithImpl<_LiveGlobalCapContribution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveGlobalCapContributionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveGlobalCapContribution&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.pricingConfigId, pricingConfigId) || other.pricingConfigId == pricingConfigId)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,pricingConfigId,amount);

@override
String toString() {
  return 'LiveGlobalCapContribution(sessionId: $sessionId, pricingConfigId: $pricingConfigId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$LiveGlobalCapContributionCopyWith<$Res> implements $LiveGlobalCapContributionCopyWith<$Res> {
  factory _$LiveGlobalCapContributionCopyWith(_LiveGlobalCapContribution value, $Res Function(_LiveGlobalCapContribution) _then) = __$LiveGlobalCapContributionCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String pricingConfigId, num amount
});




}
/// @nodoc
class __$LiveGlobalCapContributionCopyWithImpl<$Res>
    implements _$LiveGlobalCapContributionCopyWith<$Res> {
  __$LiveGlobalCapContributionCopyWithImpl(this._self, this._then);

  final _LiveGlobalCapContribution _self;
  final $Res Function(_LiveGlobalCapContribution) _then;

/// Create a copy of LiveGlobalCapContribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? pricingConfigId = null,Object? amount = null,}) {
  return _then(_LiveGlobalCapContribution(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,pricingConfigId: null == pricingConfigId ? _self.pricingConfigId : pricingConfigId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$LivePricingCharge {

 String get pricingConfigId; String get planName; String? get ruleLabel; num get amount;
/// Create a copy of LivePricingCharge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivePricingChargeCopyWith<LivePricingCharge> get copyWith => _$LivePricingChargeCopyWithImpl<LivePricingCharge>(this as LivePricingCharge, _$identity);

  /// Serializes this LivePricingCharge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivePricingCharge&&(identical(other.pricingConfigId, pricingConfigId) || other.pricingConfigId == pricingConfigId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.ruleLabel, ruleLabel) || other.ruleLabel == ruleLabel)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pricingConfigId,planName,ruleLabel,amount);

@override
String toString() {
  return 'LivePricingCharge(pricingConfigId: $pricingConfigId, planName: $planName, ruleLabel: $ruleLabel, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $LivePricingChargeCopyWith<$Res>  {
  factory $LivePricingChargeCopyWith(LivePricingCharge value, $Res Function(LivePricingCharge) _then) = _$LivePricingChargeCopyWithImpl;
@useResult
$Res call({
 String pricingConfigId, String planName, String? ruleLabel, num amount
});




}
/// @nodoc
class _$LivePricingChargeCopyWithImpl<$Res>
    implements $LivePricingChargeCopyWith<$Res> {
  _$LivePricingChargeCopyWithImpl(this._self, this._then);

  final LivePricingCharge _self;
  final $Res Function(LivePricingCharge) _then;

/// Create a copy of LivePricingCharge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pricingConfigId = null,Object? planName = null,Object? ruleLabel = freezed,Object? amount = null,}) {
  return _then(_self.copyWith(
pricingConfigId: null == pricingConfigId ? _self.pricingConfigId : pricingConfigId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,ruleLabel: freezed == ruleLabel ? _self.ruleLabel : ruleLabel // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [LivePricingCharge].
extension LivePricingChargePatterns on LivePricingCharge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivePricingCharge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivePricingCharge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivePricingCharge value)  $default,){
final _that = this;
switch (_that) {
case _LivePricingCharge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivePricingCharge value)?  $default,){
final _that = this;
switch (_that) {
case _LivePricingCharge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pricingConfigId,  String planName,  String? ruleLabel,  num amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivePricingCharge() when $default != null:
return $default(_that.pricingConfigId,_that.planName,_that.ruleLabel,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pricingConfigId,  String planName,  String? ruleLabel,  num amount)  $default,) {final _that = this;
switch (_that) {
case _LivePricingCharge():
return $default(_that.pricingConfigId,_that.planName,_that.ruleLabel,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pricingConfigId,  String planName,  String? ruleLabel,  num amount)?  $default,) {final _that = this;
switch (_that) {
case _LivePricingCharge() when $default != null:
return $default(_that.pricingConfigId,_that.planName,_that.ruleLabel,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivePricingCharge extends LivePricingCharge {
  const _LivePricingCharge({required this.pricingConfigId, required this.planName, this.ruleLabel, required this.amount}): super._();
  factory _LivePricingCharge.fromJson(Map<String, dynamic> json) => _$LivePricingChargeFromJson(json);

@override final  String pricingConfigId;
@override final  String planName;
@override final  String? ruleLabel;
@override final  num amount;

/// Create a copy of LivePricingCharge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivePricingChargeCopyWith<_LivePricingCharge> get copyWith => __$LivePricingChargeCopyWithImpl<_LivePricingCharge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivePricingChargeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivePricingCharge&&(identical(other.pricingConfigId, pricingConfigId) || other.pricingConfigId == pricingConfigId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.ruleLabel, ruleLabel) || other.ruleLabel == ruleLabel)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pricingConfigId,planName,ruleLabel,amount);

@override
String toString() {
  return 'LivePricingCharge(pricingConfigId: $pricingConfigId, planName: $planName, ruleLabel: $ruleLabel, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$LivePricingChargeCopyWith<$Res> implements $LivePricingChargeCopyWith<$Res> {
  factory _$LivePricingChargeCopyWith(_LivePricingCharge value, $Res Function(_LivePricingCharge) _then) = __$LivePricingChargeCopyWithImpl;
@override @useResult
$Res call({
 String pricingConfigId, String planName, String? ruleLabel, num amount
});




}
/// @nodoc
class __$LivePricingChargeCopyWithImpl<$Res>
    implements _$LivePricingChargeCopyWith<$Res> {
  __$LivePricingChargeCopyWithImpl(this._self, this._then);

  final _LivePricingCharge _self;
  final $Res Function(_LivePricingCharge) _then;

/// Create a copy of LivePricingCharge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pricingConfigId = null,Object? planName = null,Object? ruleLabel = freezed,Object? amount = null,}) {
  return _then(_LivePricingCharge(
pricingConfigId: null == pricingConfigId ? _self.pricingConfigId : pricingConfigId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,ruleLabel: freezed == ruleLabel ? _self.ruleLabel : ruleLabel // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
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
mixin _$PlayerIdentity {

 String get provider; String get subject; DateTime? get createdAt;
/// Create a copy of PlayerIdentity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerIdentityCopyWith<PlayerIdentity> get copyWith => _$PlayerIdentityCopyWithImpl<PlayerIdentity>(this as PlayerIdentity, _$identity);

  /// Serializes this PlayerIdentity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerIdentity&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,subject,createdAt);

@override
String toString() {
  return 'PlayerIdentity(provider: $provider, subject: $subject, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PlayerIdentityCopyWith<$Res>  {
  factory $PlayerIdentityCopyWith(PlayerIdentity value, $Res Function(PlayerIdentity) _then) = _$PlayerIdentityCopyWithImpl;
@useResult
$Res call({
 String provider, String subject, DateTime? createdAt
});




}
/// @nodoc
class _$PlayerIdentityCopyWithImpl<$Res>
    implements $PlayerIdentityCopyWith<$Res> {
  _$PlayerIdentityCopyWithImpl(this._self, this._then);

  final PlayerIdentity _self;
  final $Res Function(PlayerIdentity) _then;

/// Create a copy of PlayerIdentity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? subject = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerIdentity].
extension PlayerIdentityPatterns on PlayerIdentity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerIdentity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerIdentity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerIdentity value)  $default,){
final _that = this;
switch (_that) {
case _PlayerIdentity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerIdentity value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerIdentity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String provider,  String subject,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerIdentity() when $default != null:
return $default(_that.provider,_that.subject,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String provider,  String subject,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _PlayerIdentity():
return $default(_that.provider,_that.subject,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String provider,  String subject,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PlayerIdentity() when $default != null:
return $default(_that.provider,_that.subject,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerIdentity implements PlayerIdentity {
  const _PlayerIdentity({required this.provider, required this.subject, this.createdAt});
  factory _PlayerIdentity.fromJson(Map<String, dynamic> json) => _$PlayerIdentityFromJson(json);

@override final  String provider;
@override final  String subject;
@override final  DateTime? createdAt;

/// Create a copy of PlayerIdentity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerIdentityCopyWith<_PlayerIdentity> get copyWith => __$PlayerIdentityCopyWithImpl<_PlayerIdentity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerIdentityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerIdentity&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,subject,createdAt);

@override
String toString() {
  return 'PlayerIdentity(provider: $provider, subject: $subject, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PlayerIdentityCopyWith<$Res> implements $PlayerIdentityCopyWith<$Res> {
  factory _$PlayerIdentityCopyWith(_PlayerIdentity value, $Res Function(_PlayerIdentity) _then) = __$PlayerIdentityCopyWithImpl;
@override @useResult
$Res call({
 String provider, String subject, DateTime? createdAt
});




}
/// @nodoc
class __$PlayerIdentityCopyWithImpl<$Res>
    implements _$PlayerIdentityCopyWith<$Res> {
  __$PlayerIdentityCopyWithImpl(this._self, this._then);

  final _PlayerIdentity _self;
  final $Res Function(_PlayerIdentity) _then;

/// Create a copy of PlayerIdentity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? subject = null,Object? createdAt = freezed,}) {
  return _then(_PlayerIdentity(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Player {

 String get id; String get displayName; String get status; num get walletTotal; String? get activeSessionId; int get stayDurationMinutes; DateTime? get createdAt; List<PlayerIdentity> get identities;
/// Create a copy of Player
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerCopyWith<Player> get copyWith => _$PlayerCopyWithImpl<Player>(this as Player, _$identity);

  /// Serializes this Player to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Player&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.walletTotal, walletTotal) || other.walletTotal == walletTotal)&&(identical(other.activeSessionId, activeSessionId) || other.activeSessionId == activeSessionId)&&(identical(other.stayDurationMinutes, stayDurationMinutes) || other.stayDurationMinutes == stayDurationMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.identities, identities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,status,walletTotal,activeSessionId,stayDurationMinutes,createdAt,const DeepCollectionEquality().hash(identities));

@override
String toString() {
  return 'Player(id: $id, displayName: $displayName, status: $status, walletTotal: $walletTotal, activeSessionId: $activeSessionId, stayDurationMinutes: $stayDurationMinutes, createdAt: $createdAt, identities: $identities)';
}


}

/// @nodoc
abstract mixin class $PlayerCopyWith<$Res>  {
  factory $PlayerCopyWith(Player value, $Res Function(Player) _then) = _$PlayerCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String status, num walletTotal, String? activeSessionId, int stayDurationMinutes, DateTime? createdAt, List<PlayerIdentity> identities
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? status = null,Object? walletTotal = null,Object? activeSessionId = freezed,Object? stayDurationMinutes = null,Object? createdAt = freezed,Object? identities = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,walletTotal: null == walletTotal ? _self.walletTotal : walletTotal // ignore: cast_nullable_to_non_nullable
as num,activeSessionId: freezed == activeSessionId ? _self.activeSessionId : activeSessionId // ignore: cast_nullable_to_non_nullable
as String?,stayDurationMinutes: null == stayDurationMinutes ? _self.stayDurationMinutes : stayDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,identities: null == identities ? _self.identities : identities // ignore: cast_nullable_to_non_nullable
as List<PlayerIdentity>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String status,  num walletTotal,  String? activeSessionId,  int stayDurationMinutes,  DateTime? createdAt,  List<PlayerIdentity> identities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.displayName,_that.status,_that.walletTotal,_that.activeSessionId,_that.stayDurationMinutes,_that.createdAt,_that.identities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String status,  num walletTotal,  String? activeSessionId,  int stayDurationMinutes,  DateTime? createdAt,  List<PlayerIdentity> identities)  $default,) {final _that = this;
switch (_that) {
case _Player():
return $default(_that.id,_that.displayName,_that.status,_that.walletTotal,_that.activeSessionId,_that.stayDurationMinutes,_that.createdAt,_that.identities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String status,  num walletTotal,  String? activeSessionId,  int stayDurationMinutes,  DateTime? createdAt,  List<PlayerIdentity> identities)?  $default,) {final _that = this;
switch (_that) {
case _Player() when $default != null:
return $default(_that.id,_that.displayName,_that.status,_that.walletTotal,_that.activeSessionId,_that.stayDurationMinutes,_that.createdAt,_that.identities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Player implements Player {
  const _Player({required this.id, required this.displayName, required this.status, this.walletTotal = 0, this.activeSessionId, this.stayDurationMinutes = 0, this.createdAt, final  List<PlayerIdentity> identities = const []}): _identities = identities;
  factory _Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String status;
@override@JsonKey() final  num walletTotal;
@override final  String? activeSessionId;
@override@JsonKey() final  int stayDurationMinutes;
@override final  DateTime? createdAt;
 final  List<PlayerIdentity> _identities;
@override@JsonKey() List<PlayerIdentity> get identities {
  if (_identities is EqualUnmodifiableListView) return _identities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_identities);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Player&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&(identical(other.walletTotal, walletTotal) || other.walletTotal == walletTotal)&&(identical(other.activeSessionId, activeSessionId) || other.activeSessionId == activeSessionId)&&(identical(other.stayDurationMinutes, stayDurationMinutes) || other.stayDurationMinutes == stayDurationMinutes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._identities, _identities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,status,walletTotal,activeSessionId,stayDurationMinutes,createdAt,const DeepCollectionEquality().hash(_identities));

@override
String toString() {
  return 'Player(id: $id, displayName: $displayName, status: $status, walletTotal: $walletTotal, activeSessionId: $activeSessionId, stayDurationMinutes: $stayDurationMinutes, createdAt: $createdAt, identities: $identities)';
}


}

/// @nodoc
abstract mixin class _$PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$PlayerCopyWith(_Player value, $Res Function(_Player) _then) = __$PlayerCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String status, num walletTotal, String? activeSessionId, int stayDurationMinutes, DateTime? createdAt, List<PlayerIdentity> identities
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? status = null,Object? walletTotal = null,Object? activeSessionId = freezed,Object? stayDurationMinutes = null,Object? createdAt = freezed,Object? identities = null,}) {
  return _then(_Player(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,walletTotal: null == walletTotal ? _self.walletTotal : walletTotal // ignore: cast_nullable_to_non_nullable
as num,activeSessionId: freezed == activeSessionId ? _self.activeSessionId : activeSessionId // ignore: cast_nullable_to_non_nullable
as String?,stayDurationMinutes: null == stayDurationMinutes ? _self.stayDurationMinutes : stayDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,identities: null == identities ? _self._identities : identities // ignore: cast_nullable_to_non_nullable
as List<PlayerIdentity>,
  ));
}


}


/// @nodoc
mixin _$PricingEffect {

 String get id; String get name; String get type; String get scope; num? get value; bool get consumable; int? get limitPerDay; DateTime? get activeAt; DateTime? get expiresAt;@JsonKey(readValue: readMap) Map<String, dynamic>? get config;@JsonKey(readValue: readIsArchived) bool get isArchived;
/// Create a copy of PricingEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricingEffectCopyWith<PricingEffect> get copyWith => _$PricingEffectCopyWithImpl<PricingEffect>(this as PricingEffect, _$identity);

  /// Serializes this PricingEffect to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricingEffect&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.value, value) || other.value == value)&&(identical(other.consumable, consumable) || other.consumable == consumable)&&(identical(other.limitPerDay, limitPerDay) || other.limitPerDay == limitPerDay)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other.config, config)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,scope,value,consumable,limitPerDay,activeAt,expiresAt,const DeepCollectionEquality().hash(config),isArchived);

@override
String toString() {
  return 'PricingEffect(id: $id, name: $name, type: $type, scope: $scope, value: $value, consumable: $consumable, limitPerDay: $limitPerDay, activeAt: $activeAt, expiresAt: $expiresAt, config: $config, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class $PricingEffectCopyWith<$Res>  {
  factory $PricingEffectCopyWith(PricingEffect value, $Res Function(PricingEffect) _then) = _$PricingEffectCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, String scope, num? value, bool consumable, int? limitPerDay, DateTime? activeAt, DateTime? expiresAt,@JsonKey(readValue: readMap) Map<String, dynamic>? config,@JsonKey(readValue: readIsArchived) bool isArchived
});




}
/// @nodoc
class _$PricingEffectCopyWithImpl<$Res>
    implements $PricingEffectCopyWith<$Res> {
  _$PricingEffectCopyWithImpl(this._self, this._then);

  final PricingEffect _self;
  final $Res Function(PricingEffect) _then;

/// Create a copy of PricingEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? scope = null,Object? value = freezed,Object? consumable = null,Object? limitPerDay = freezed,Object? activeAt = freezed,Object? expiresAt = freezed,Object? config = freezed,Object? isArchived = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,consumable: null == consumable ? _self.consumable : consumable // ignore: cast_nullable_to_non_nullable
as bool,limitPerDay: freezed == limitPerDay ? _self.limitPerDay : limitPerDay // ignore: cast_nullable_to_non_nullable
as int?,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PricingEffect].
extension PricingEffectPatterns on PricingEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PricingEffect value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PricingEffect() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PricingEffect value)  $default,){
final _that = this;
switch (_that) {
case _PricingEffect():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PricingEffect value)?  $default,){
final _that = this;
switch (_that) {
case _PricingEffect() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String scope,  num? value,  bool consumable,  int? limitPerDay,  DateTime? activeAt,  DateTime? expiresAt, @JsonKey(readValue: readMap)  Map<String, dynamic>? config, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricingEffect() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.scope,_that.value,_that.consumable,_that.limitPerDay,_that.activeAt,_that.expiresAt,_that.config,_that.isArchived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String scope,  num? value,  bool consumable,  int? limitPerDay,  DateTime? activeAt,  DateTime? expiresAt, @JsonKey(readValue: readMap)  Map<String, dynamic>? config, @JsonKey(readValue: readIsArchived)  bool isArchived)  $default,) {final _that = this;
switch (_that) {
case _PricingEffect():
return $default(_that.id,_that.name,_that.type,_that.scope,_that.value,_that.consumable,_that.limitPerDay,_that.activeAt,_that.expiresAt,_that.config,_that.isArchived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  String scope,  num? value,  bool consumable,  int? limitPerDay,  DateTime? activeAt,  DateTime? expiresAt, @JsonKey(readValue: readMap)  Map<String, dynamic>? config, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,) {final _that = this;
switch (_that) {
case _PricingEffect() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.scope,_that.value,_that.consumable,_that.limitPerDay,_that.activeAt,_that.expiresAt,_that.config,_that.isArchived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PricingEffect implements PricingEffect {
  const _PricingEffect({required this.id, required this.name, required this.type, required this.scope, this.value, this.consumable = false, this.limitPerDay, this.activeAt, this.expiresAt, @JsonKey(readValue: readMap) final  Map<String, dynamic>? config, @JsonKey(readValue: readIsArchived) this.isArchived = false}): _config = config;
  factory _PricingEffect.fromJson(Map<String, dynamic> json) => _$PricingEffectFromJson(json);

@override final  String id;
@override final  String name;
@override final  String type;
@override final  String scope;
@override final  num? value;
@override@JsonKey() final  bool consumable;
@override final  int? limitPerDay;
@override final  DateTime? activeAt;
@override final  DateTime? expiresAt;
 final  Map<String, dynamic>? _config;
@override@JsonKey(readValue: readMap) Map<String, dynamic>? get config {
  final value = _config;
  if (value == null) return null;
  if (_config is EqualUnmodifiableMapView) return _config;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(readValue: readIsArchived) final  bool isArchived;

/// Create a copy of PricingEffect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricingEffectCopyWith<_PricingEffect> get copyWith => __$PricingEffectCopyWithImpl<_PricingEffect>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PricingEffectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricingEffect&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.value, value) || other.value == value)&&(identical(other.consumable, consumable) || other.consumable == consumable)&&(identical(other.limitPerDay, limitPerDay) || other.limitPerDay == limitPerDay)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other._config, _config)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,scope,value,consumable,limitPerDay,activeAt,expiresAt,const DeepCollectionEquality().hash(_config),isArchived);

@override
String toString() {
  return 'PricingEffect(id: $id, name: $name, type: $type, scope: $scope, value: $value, consumable: $consumable, limitPerDay: $limitPerDay, activeAt: $activeAt, expiresAt: $expiresAt, config: $config, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class _$PricingEffectCopyWith<$Res> implements $PricingEffectCopyWith<$Res> {
  factory _$PricingEffectCopyWith(_PricingEffect value, $Res Function(_PricingEffect) _then) = __$PricingEffectCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, String scope, num? value, bool consumable, int? limitPerDay, DateTime? activeAt, DateTime? expiresAt,@JsonKey(readValue: readMap) Map<String, dynamic>? config,@JsonKey(readValue: readIsArchived) bool isArchived
});




}
/// @nodoc
class __$PricingEffectCopyWithImpl<$Res>
    implements _$PricingEffectCopyWith<$Res> {
  __$PricingEffectCopyWithImpl(this._self, this._then);

  final _PricingEffect _self;
  final $Res Function(_PricingEffect) _then;

/// Create a copy of PricingEffect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? scope = null,Object? value = freezed,Object? consumable = null,Object? limitPerDay = freezed,Object? activeAt = freezed,Object? expiresAt = freezed,Object? config = freezed,Object? isArchived = null,}) {
  return _then(_PricingEffect(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,consumable: null == consumable ? _self.consumable : consumable // ignore: cast_nullable_to_non_nullable
as bool,limitPerDay: freezed == limitPerDay ? _self.limitPerDay : limitPerDay // ignore: cast_nullable_to_non_nullable
as int?,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,config: freezed == config ? _self._config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AssetDefinition {

 String get type; String get code;@JsonKey(readValue: readDisplayName) String get displayName; bool get stackable;@JsonKey(readValue: readIsArchived) bool get isArchived; String? get pricingEffectId; PricingEffect? get pricingEffect; DateTime? get activeAt; DateTime? get expiresAt;
/// Create a copy of AssetDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetDefinitionCopyWith<AssetDefinition> get copyWith => _$AssetDefinitionCopyWithImpl<AssetDefinition>(this as AssetDefinition, _$identity);

  /// Serializes this AssetDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetDefinition&&(identical(other.type, type) || other.type == type)&&(identical(other.code, code) || other.code == code)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.stackable, stackable) || other.stackable == stackable)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.pricingEffectId, pricingEffectId) || other.pricingEffectId == pricingEffectId)&&(identical(other.pricingEffect, pricingEffect) || other.pricingEffect == pricingEffect)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,code,displayName,stackable,isArchived,pricingEffectId,pricingEffect,activeAt,expiresAt);

@override
String toString() {
  return 'AssetDefinition(type: $type, code: $code, displayName: $displayName, stackable: $stackable, isArchived: $isArchived, pricingEffectId: $pricingEffectId, pricingEffect: $pricingEffect, activeAt: $activeAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $AssetDefinitionCopyWith<$Res>  {
  factory $AssetDefinitionCopyWith(AssetDefinition value, $Res Function(AssetDefinition) _then) = _$AssetDefinitionCopyWithImpl;
@useResult
$Res call({
 String type, String code,@JsonKey(readValue: readDisplayName) String displayName, bool stackable,@JsonKey(readValue: readIsArchived) bool isArchived, String? pricingEffectId, PricingEffect? pricingEffect, DateTime? activeAt, DateTime? expiresAt
});


$PricingEffectCopyWith<$Res>? get pricingEffect;

}
/// @nodoc
class _$AssetDefinitionCopyWithImpl<$Res>
    implements $AssetDefinitionCopyWith<$Res> {
  _$AssetDefinitionCopyWithImpl(this._self, this._then);

  final AssetDefinition _self;
  final $Res Function(AssetDefinition) _then;

/// Create a copy of AssetDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? code = null,Object? displayName = null,Object? stackable = null,Object? isArchived = null,Object? pricingEffectId = freezed,Object? pricingEffect = freezed,Object? activeAt = freezed,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,stackable: null == stackable ? _self.stackable : stackable // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,pricingEffectId: freezed == pricingEffectId ? _self.pricingEffectId : pricingEffectId // ignore: cast_nullable_to_non_nullable
as String?,pricingEffect: freezed == pricingEffect ? _self.pricingEffect : pricingEffect // ignore: cast_nullable_to_non_nullable
as PricingEffect?,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of AssetDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PricingEffectCopyWith<$Res>? get pricingEffect {
    if (_self.pricingEffect == null) {
    return null;
  }

  return $PricingEffectCopyWith<$Res>(_self.pricingEffect!, (value) {
    return _then(_self.copyWith(pricingEffect: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String code, @JsonKey(readValue: readDisplayName)  String displayName,  bool stackable, @JsonKey(readValue: readIsArchived)  bool isArchived,  String? pricingEffectId,  PricingEffect? pricingEffect,  DateTime? activeAt,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetDefinition() when $default != null:
return $default(_that.type,_that.code,_that.displayName,_that.stackable,_that.isArchived,_that.pricingEffectId,_that.pricingEffect,_that.activeAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String code, @JsonKey(readValue: readDisplayName)  String displayName,  bool stackable, @JsonKey(readValue: readIsArchived)  bool isArchived,  String? pricingEffectId,  PricingEffect? pricingEffect,  DateTime? activeAt,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _AssetDefinition():
return $default(_that.type,_that.code,_that.displayName,_that.stackable,_that.isArchived,_that.pricingEffectId,_that.pricingEffect,_that.activeAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String code, @JsonKey(readValue: readDisplayName)  String displayName,  bool stackable, @JsonKey(readValue: readIsArchived)  bool isArchived,  String? pricingEffectId,  PricingEffect? pricingEffect,  DateTime? activeAt,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _AssetDefinition() when $default != null:
return $default(_that.type,_that.code,_that.displayName,_that.stackable,_that.isArchived,_that.pricingEffectId,_that.pricingEffect,_that.activeAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetDefinition implements AssetDefinition {
  const _AssetDefinition({required this.type, required this.code, @JsonKey(readValue: readDisplayName) required this.displayName, this.stackable = true, @JsonKey(readValue: readIsArchived) this.isArchived = false, this.pricingEffectId, this.pricingEffect, this.activeAt, this.expiresAt});
  factory _AssetDefinition.fromJson(Map<String, dynamic> json) => _$AssetDefinitionFromJson(json);

@override final  String type;
@override final  String code;
@override@JsonKey(readValue: readDisplayName) final  String displayName;
@override@JsonKey() final  bool stackable;
@override@JsonKey(readValue: readIsArchived) final  bool isArchived;
@override final  String? pricingEffectId;
@override final  PricingEffect? pricingEffect;
@override final  DateTime? activeAt;
@override final  DateTime? expiresAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetDefinition&&(identical(other.type, type) || other.type == type)&&(identical(other.code, code) || other.code == code)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.stackable, stackable) || other.stackable == stackable)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.pricingEffectId, pricingEffectId) || other.pricingEffectId == pricingEffectId)&&(identical(other.pricingEffect, pricingEffect) || other.pricingEffect == pricingEffect)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,code,displayName,stackable,isArchived,pricingEffectId,pricingEffect,activeAt,expiresAt);

@override
String toString() {
  return 'AssetDefinition(type: $type, code: $code, displayName: $displayName, stackable: $stackable, isArchived: $isArchived, pricingEffectId: $pricingEffectId, pricingEffect: $pricingEffect, activeAt: $activeAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$AssetDefinitionCopyWith<$Res> implements $AssetDefinitionCopyWith<$Res> {
  factory _$AssetDefinitionCopyWith(_AssetDefinition value, $Res Function(_AssetDefinition) _then) = __$AssetDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String type, String code,@JsonKey(readValue: readDisplayName) String displayName, bool stackable,@JsonKey(readValue: readIsArchived) bool isArchived, String? pricingEffectId, PricingEffect? pricingEffect, DateTime? activeAt, DateTime? expiresAt
});


@override $PricingEffectCopyWith<$Res>? get pricingEffect;

}
/// @nodoc
class __$AssetDefinitionCopyWithImpl<$Res>
    implements _$AssetDefinitionCopyWith<$Res> {
  __$AssetDefinitionCopyWithImpl(this._self, this._then);

  final _AssetDefinition _self;
  final $Res Function(_AssetDefinition) _then;

/// Create a copy of AssetDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? code = null,Object? displayName = null,Object? stackable = null,Object? isArchived = null,Object? pricingEffectId = freezed,Object? pricingEffect = freezed,Object? activeAt = freezed,Object? expiresAt = freezed,}) {
  return _then(_AssetDefinition(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,stackable: null == stackable ? _self.stackable : stackable // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,pricingEffectId: freezed == pricingEffectId ? _self.pricingEffectId : pricingEffectId // ignore: cast_nullable_to_non_nullable
as String?,pricingEffect: freezed == pricingEffect ? _self.pricingEffect : pricingEffect // ignore: cast_nullable_to_non_nullable
as PricingEffect?,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of AssetDefinition
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PricingEffectCopyWith<$Res>? get pricingEffect {
    if (_self.pricingEffect == null) {
    return null;
  }

  return $PricingEffectCopyWith<$Res>(_self.pricingEffect!, (value) {
    return _then(_self.copyWith(pricingEffect: value));
  });
}
}


/// @nodoc
mixin _$AssetHolding {

 String get id; String get assetType; String get assetCode; String? get assetName;@JsonKey(readValue: readAmount) num get amount; DateTime? get activeAt; DateTime? get expiresAt; String get availability; List<String> get unavailableReasons;
/// Create a copy of AssetHolding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetHoldingCopyWith<AssetHolding> get copyWith => _$AssetHoldingCopyWithImpl<AssetHolding>(this as AssetHolding, _$identity);

  /// Serializes this AssetHolding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetHolding&&(identical(other.id, id) || other.id == id)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.availability, availability) || other.availability == availability)&&const DeepCollectionEquality().equals(other.unavailableReasons, unavailableReasons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,assetType,assetCode,assetName,amount,activeAt,expiresAt,availability,const DeepCollectionEquality().hash(unavailableReasons));

@override
String toString() {
  return 'AssetHolding(id: $id, assetType: $assetType, assetCode: $assetCode, assetName: $assetName, amount: $amount, activeAt: $activeAt, expiresAt: $expiresAt, availability: $availability, unavailableReasons: $unavailableReasons)';
}


}

/// @nodoc
abstract mixin class $AssetHoldingCopyWith<$Res>  {
  factory $AssetHoldingCopyWith(AssetHolding value, $Res Function(AssetHolding) _then) = _$AssetHoldingCopyWithImpl;
@useResult
$Res call({
 String id, String assetType, String assetCode, String? assetName,@JsonKey(readValue: readAmount) num amount, DateTime? activeAt, DateTime? expiresAt, String availability, List<String> unavailableReasons
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? assetType = null,Object? assetCode = null,Object? assetName = freezed,Object? amount = null,Object? activeAt = freezed,Object? expiresAt = freezed,Object? availability = null,Object? unavailableReasons = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,assetName: freezed == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as String,unavailableReasons: null == unavailableReasons ? _self.unavailableReasons : unavailableReasons // ignore: cast_nullable_to_non_nullable
as List<String>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount,  DateTime? activeAt,  DateTime? expiresAt,  String availability,  List<String> unavailableReasons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetHolding() when $default != null:
return $default(_that.id,_that.assetType,_that.assetCode,_that.assetName,_that.amount,_that.activeAt,_that.expiresAt,_that.availability,_that.unavailableReasons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount,  DateTime? activeAt,  DateTime? expiresAt,  String availability,  List<String> unavailableReasons)  $default,) {final _that = this;
switch (_that) {
case _AssetHolding():
return $default(_that.id,_that.assetType,_that.assetCode,_that.assetName,_that.amount,_that.activeAt,_that.expiresAt,_that.availability,_that.unavailableReasons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount,  DateTime? activeAt,  DateTime? expiresAt,  String availability,  List<String> unavailableReasons)?  $default,) {final _that = this;
switch (_that) {
case _AssetHolding() when $default != null:
return $default(_that.id,_that.assetType,_that.assetCode,_that.assetName,_that.amount,_that.activeAt,_that.expiresAt,_that.availability,_that.unavailableReasons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetHolding implements AssetHolding {
  const _AssetHolding({required this.id, required this.assetType, required this.assetCode, this.assetName, @JsonKey(readValue: readAmount) required this.amount, this.activeAt, this.expiresAt, this.availability = 'available', final  List<String> unavailableReasons = const []}): _unavailableReasons = unavailableReasons;
  factory _AssetHolding.fromJson(Map<String, dynamic> json) => _$AssetHoldingFromJson(json);

@override final  String id;
@override final  String assetType;
@override final  String assetCode;
@override final  String? assetName;
@override@JsonKey(readValue: readAmount) final  num amount;
@override final  DateTime? activeAt;
@override final  DateTime? expiresAt;
@override@JsonKey() final  String availability;
 final  List<String> _unavailableReasons;
@override@JsonKey() List<String> get unavailableReasons {
  if (_unavailableReasons is EqualUnmodifiableListView) return _unavailableReasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unavailableReasons);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetHolding&&(identical(other.id, id) || other.id == id)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.availability, availability) || other.availability == availability)&&const DeepCollectionEquality().equals(other._unavailableReasons, _unavailableReasons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,assetType,assetCode,assetName,amount,activeAt,expiresAt,availability,const DeepCollectionEquality().hash(_unavailableReasons));

@override
String toString() {
  return 'AssetHolding(id: $id, assetType: $assetType, assetCode: $assetCode, assetName: $assetName, amount: $amount, activeAt: $activeAt, expiresAt: $expiresAt, availability: $availability, unavailableReasons: $unavailableReasons)';
}


}

/// @nodoc
abstract mixin class _$AssetHoldingCopyWith<$Res> implements $AssetHoldingCopyWith<$Res> {
  factory _$AssetHoldingCopyWith(_AssetHolding value, $Res Function(_AssetHolding) _then) = __$AssetHoldingCopyWithImpl;
@override @useResult
$Res call({
 String id, String assetType, String assetCode, String? assetName,@JsonKey(readValue: readAmount) num amount, DateTime? activeAt, DateTime? expiresAt, String availability, List<String> unavailableReasons
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? assetType = null,Object? assetCode = null,Object? assetName = freezed,Object? amount = null,Object? activeAt = freezed,Object? expiresAt = freezed,Object? availability = null,Object? unavailableReasons = null,}) {
  return _then(_AssetHolding(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,assetName: freezed == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as String,unavailableReasons: null == unavailableReasons ? _self._unavailableReasons : unavailableReasons // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$AssetLedgerEntry {

 String get id; String get assetType; String get assetCode; String? get assetName;@JsonKey(readValue: readAmount) num get amount;@JsonKey(readValue: readDirection) String get direction; String get reason; String? get refId; String? get transactionId; DateTime get createdAt;
/// Create a copy of AssetLedgerEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetLedgerEntryCopyWith<AssetLedgerEntry> get copyWith => _$AssetLedgerEntryCopyWithImpl<AssetLedgerEntry>(this as AssetLedgerEntry, _$identity);

  /// Serializes this AssetLedgerEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetLedgerEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.refId, refId) || other.refId == refId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,assetType,assetCode,assetName,amount,direction,reason,refId,transactionId,createdAt);

@override
String toString() {
  return 'AssetLedgerEntry(id: $id, assetType: $assetType, assetCode: $assetCode, assetName: $assetName, amount: $amount, direction: $direction, reason: $reason, refId: $refId, transactionId: $transactionId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AssetLedgerEntryCopyWith<$Res>  {
  factory $AssetLedgerEntryCopyWith(AssetLedgerEntry value, $Res Function(AssetLedgerEntry) _then) = _$AssetLedgerEntryCopyWithImpl;
@useResult
$Res call({
 String id, String assetType, String assetCode, String? assetName,@JsonKey(readValue: readAmount) num amount,@JsonKey(readValue: readDirection) String direction, String reason, String? refId, String? transactionId, DateTime createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? assetType = null,Object? assetCode = null,Object? assetName = freezed,Object? amount = null,Object? direction = null,Object? reason = null,Object? refId = freezed,Object? transactionId = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,assetName: freezed == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,refId: freezed == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as String?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount, @JsonKey(readValue: readDirection)  String direction,  String reason,  String? refId,  String? transactionId,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetLedgerEntry() when $default != null:
return $default(_that.id,_that.assetType,_that.assetCode,_that.assetName,_that.amount,_that.direction,_that.reason,_that.refId,_that.transactionId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount, @JsonKey(readValue: readDirection)  String direction,  String reason,  String? refId,  String? transactionId,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AssetLedgerEntry():
return $default(_that.id,_that.assetType,_that.assetCode,_that.assetName,_that.amount,_that.direction,_that.reason,_that.refId,_that.transactionId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String assetType,  String assetCode,  String? assetName, @JsonKey(readValue: readAmount)  num amount, @JsonKey(readValue: readDirection)  String direction,  String reason,  String? refId,  String? transactionId,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AssetLedgerEntry() when $default != null:
return $default(_that.id,_that.assetType,_that.assetCode,_that.assetName,_that.amount,_that.direction,_that.reason,_that.refId,_that.transactionId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetLedgerEntry implements AssetLedgerEntry {
  const _AssetLedgerEntry({this.id = '', required this.assetType, required this.assetCode, this.assetName, @JsonKey(readValue: readAmount) required this.amount, @JsonKey(readValue: readDirection) required this.direction, required this.reason, this.refId, this.transactionId, required this.createdAt});
  factory _AssetLedgerEntry.fromJson(Map<String, dynamic> json) => _$AssetLedgerEntryFromJson(json);

@override@JsonKey() final  String id;
@override final  String assetType;
@override final  String assetCode;
@override final  String? assetName;
@override@JsonKey(readValue: readAmount) final  num amount;
@override@JsonKey(readValue: readDirection) final  String direction;
@override final  String reason;
@override final  String? refId;
@override final  String? transactionId;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetLedgerEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.refId, refId) || other.refId == refId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,assetType,assetCode,assetName,amount,direction,reason,refId,transactionId,createdAt);

@override
String toString() {
  return 'AssetLedgerEntry(id: $id, assetType: $assetType, assetCode: $assetCode, assetName: $assetName, amount: $amount, direction: $direction, reason: $reason, refId: $refId, transactionId: $transactionId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AssetLedgerEntryCopyWith<$Res> implements $AssetLedgerEntryCopyWith<$Res> {
  factory _$AssetLedgerEntryCopyWith(_AssetLedgerEntry value, $Res Function(_AssetLedgerEntry) _then) = __$AssetLedgerEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String assetType, String assetCode, String? assetName,@JsonKey(readValue: readAmount) num amount,@JsonKey(readValue: readDirection) String direction, String reason, String? refId, String? transactionId, DateTime createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? assetType = null,Object? assetCode = null,Object? assetName = freezed,Object? amount = null,Object? direction = null,Object? reason = null,Object? refId = freezed,Object? transactionId = freezed,Object? createdAt = null,}) {
  return _then(_AssetLedgerEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,assetName: freezed == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,refId: freezed == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as String?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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

 String get assetType; String get assetCode; num get amount; String get mergeStrategy; DateTime? get activeAt; DateTime? get expiresAt; int? get durationMs;
/// Create a copy of AssetGrant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetGrantCopyWith<AssetGrant> get copyWith => _$AssetGrantCopyWithImpl<AssetGrant>(this as AssetGrant, _$identity);

  /// Serializes this AssetGrant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetGrant&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.mergeStrategy, mergeStrategy) || other.mergeStrategy == mergeStrategy)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetType,assetCode,amount,mergeStrategy,activeAt,expiresAt,durationMs);

@override
String toString() {
  return 'AssetGrant(assetType: $assetType, assetCode: $assetCode, amount: $amount, mergeStrategy: $mergeStrategy, activeAt: $activeAt, expiresAt: $expiresAt, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class $AssetGrantCopyWith<$Res>  {
  factory $AssetGrantCopyWith(AssetGrant value, $Res Function(AssetGrant) _then) = _$AssetGrantCopyWithImpl;
@useResult
$Res call({
 String assetType, String assetCode, num amount, String mergeStrategy, DateTime? activeAt, DateTime? expiresAt, int? durationMs
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
@pragma('vm:prefer-inline') @override $Res call({Object? assetType = null,Object? assetCode = null,Object? amount = null,Object? mergeStrategy = null,Object? activeAt = freezed,Object? expiresAt = freezed,Object? durationMs = freezed,}) {
  return _then(_self.copyWith(
assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,mergeStrategy: null == mergeStrategy ? _self.mergeStrategy : mergeStrategy // ignore: cast_nullable_to_non_nullable
as String,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String assetType,  String assetCode,  num amount,  String mergeStrategy,  DateTime? activeAt,  DateTime? expiresAt,  int? durationMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetGrant() when $default != null:
return $default(_that.assetType,_that.assetCode,_that.amount,_that.mergeStrategy,_that.activeAt,_that.expiresAt,_that.durationMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String assetType,  String assetCode,  num amount,  String mergeStrategy,  DateTime? activeAt,  DateTime? expiresAt,  int? durationMs)  $default,) {final _that = this;
switch (_that) {
case _AssetGrant():
return $default(_that.assetType,_that.assetCode,_that.amount,_that.mergeStrategy,_that.activeAt,_that.expiresAt,_that.durationMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String assetType,  String assetCode,  num amount,  String mergeStrategy,  DateTime? activeAt,  DateTime? expiresAt,  int? durationMs)?  $default,) {final _that = this;
switch (_that) {
case _AssetGrant() when $default != null:
return $default(_that.assetType,_that.assetCode,_that.amount,_that.mergeStrategy,_that.activeAt,_that.expiresAt,_that.durationMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetGrant implements AssetGrant {
  const _AssetGrant({required this.assetType, required this.assetCode, required this.amount, this.mergeStrategy = 'stack', this.activeAt, this.expiresAt, this.durationMs});
  factory _AssetGrant.fromJson(Map<String, dynamic> json) => _$AssetGrantFromJson(json);

@override final  String assetType;
@override final  String assetCode;
@override final  num amount;
@override@JsonKey() final  String mergeStrategy;
@override final  DateTime? activeAt;
@override final  DateTime? expiresAt;
@override final  int? durationMs;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetGrant&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.mergeStrategy, mergeStrategy) || other.mergeStrategy == mergeStrategy)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.durationMs, durationMs) || other.durationMs == durationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetType,assetCode,amount,mergeStrategy,activeAt,expiresAt,durationMs);

@override
String toString() {
  return 'AssetGrant(assetType: $assetType, assetCode: $assetCode, amount: $amount, mergeStrategy: $mergeStrategy, activeAt: $activeAt, expiresAt: $expiresAt, durationMs: $durationMs)';
}


}

/// @nodoc
abstract mixin class _$AssetGrantCopyWith<$Res> implements $AssetGrantCopyWith<$Res> {
  factory _$AssetGrantCopyWith(_AssetGrant value, $Res Function(_AssetGrant) _then) = __$AssetGrantCopyWithImpl;
@override @useResult
$Res call({
 String assetType, String assetCode, num amount, String mergeStrategy, DateTime? activeAt, DateTime? expiresAt, int? durationMs
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
@override @pragma('vm:prefer-inline') $Res call({Object? assetType = null,Object? assetCode = null,Object? amount = null,Object? mergeStrategy = null,Object? activeAt = freezed,Object? expiresAt = freezed,Object? durationMs = freezed,}) {
  return _then(_AssetGrant(
assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String,assetCode: null == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,mergeStrategy: null == mergeStrategy ? _self.mergeStrategy : mergeStrategy // ignore: cast_nullable_to_non_nullable
as String,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationMs: freezed == durationMs ? _self.durationMs : durationMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$Present {

 String get id; String get name; List<AssetGrant> get grants; bool get oncePerPlayer; DateTime? get activeAt; DateTime? get expiresAt;@JsonKey(readValue: readIsArchived) bool get isArchived;
/// Create a copy of Present
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresentCopyWith<Present> get copyWith => _$PresentCopyWithImpl<Present>(this as Present, _$identity);

  /// Serializes this Present to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Present&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.grants, grants)&&(identical(other.oncePerPlayer, oncePerPlayer) || other.oncePerPlayer == oncePerPlayer)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(grants),oncePerPlayer,activeAt,expiresAt,isArchived);

@override
String toString() {
  return 'Present(id: $id, name: $name, grants: $grants, oncePerPlayer: $oncePerPlayer, activeAt: $activeAt, expiresAt: $expiresAt, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class $PresentCopyWith<$Res>  {
  factory $PresentCopyWith(Present value, $Res Function(Present) _then) = _$PresentCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<AssetGrant> grants, bool oncePerPlayer, DateTime? activeAt, DateTime? expiresAt,@JsonKey(readValue: readIsArchived) bool isArchived
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? grants = null,Object? oncePerPlayer = null,Object? activeAt = freezed,Object? expiresAt = freezed,Object? isArchived = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,grants: null == grants ? _self.grants : grants // ignore: cast_nullable_to_non_nullable
as List<AssetGrant>,oncePerPlayer: null == oncePerPlayer ? _self.oncePerPlayer : oncePerPlayer // ignore: cast_nullable_to_non_nullable
as bool,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<AssetGrant> grants,  bool oncePerPlayer,  DateTime? activeAt,  DateTime? expiresAt, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Present() when $default != null:
return $default(_that.id,_that.name,_that.grants,_that.oncePerPlayer,_that.activeAt,_that.expiresAt,_that.isArchived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<AssetGrant> grants,  bool oncePerPlayer,  DateTime? activeAt,  DateTime? expiresAt, @JsonKey(readValue: readIsArchived)  bool isArchived)  $default,) {final _that = this;
switch (_that) {
case _Present():
return $default(_that.id,_that.name,_that.grants,_that.oncePerPlayer,_that.activeAt,_that.expiresAt,_that.isArchived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<AssetGrant> grants,  bool oncePerPlayer,  DateTime? activeAt,  DateTime? expiresAt, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,) {final _that = this;
switch (_that) {
case _Present() when $default != null:
return $default(_that.id,_that.name,_that.grants,_that.oncePerPlayer,_that.activeAt,_that.expiresAt,_that.isArchived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Present implements Present {
  const _Present({required this.id, required this.name, required final  List<AssetGrant> grants, this.oncePerPlayer = false, this.activeAt, this.expiresAt, @JsonKey(readValue: readIsArchived) this.isArchived = false}): _grants = grants;
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
@override final  DateTime? activeAt;
@override final  DateTime? expiresAt;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Present&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._grants, _grants)&&(identical(other.oncePerPlayer, oncePerPlayer) || other.oncePerPlayer == oncePerPlayer)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_grants),oncePerPlayer,activeAt,expiresAt,isArchived);

@override
String toString() {
  return 'Present(id: $id, name: $name, grants: $grants, oncePerPlayer: $oncePerPlayer, activeAt: $activeAt, expiresAt: $expiresAt, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class _$PresentCopyWith<$Res> implements $PresentCopyWith<$Res> {
  factory _$PresentCopyWith(_Present value, $Res Function(_Present) _then) = __$PresentCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<AssetGrant> grants, bool oncePerPlayer, DateTime? activeAt, DateTime? expiresAt,@JsonKey(readValue: readIsArchived) bool isArchived
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? grants = null,Object? oncePerPlayer = null,Object? activeAt = freezed,Object? expiresAt = freezed,Object? isArchived = null,}) {
  return _then(_Present(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,grants: null == grants ? _self._grants : grants // ignore: cast_nullable_to_non_nullable
as List<AssetGrant>,oncePerPlayer: null == oncePerPlayer ? _self.oncePerPlayer : oncePerPlayer // ignore: cast_nullable_to_non_nullable
as bool,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$RedeemCode {

 String get id; String get code; String? get presentId; DateTime? get activeAt; List<AssetGrant> get grants;@JsonKey(readValue: readUsageLimit) int get usageLimit; int get usageCount; List<RedeemCodeRedemption> get redemptions; DateTime? get expiresAt; bool get isRevoked; DateTime? get createdAt;
/// Create a copy of RedeemCode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RedeemCodeCopyWith<RedeemCode> get copyWith => _$RedeemCodeCopyWithImpl<RedeemCode>(this as RedeemCode, _$identity);

  /// Serializes this RedeemCode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RedeemCode&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.presentId, presentId) || other.presentId == presentId)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&const DeepCollectionEquality().equals(other.grants, grants)&&(identical(other.usageLimit, usageLimit) || other.usageLimit == usageLimit)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&const DeepCollectionEquality().equals(other.redemptions, redemptions)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isRevoked, isRevoked) || other.isRevoked == isRevoked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,presentId,activeAt,const DeepCollectionEquality().hash(grants),usageLimit,usageCount,const DeepCollectionEquality().hash(redemptions),expiresAt,isRevoked,createdAt);

@override
String toString() {
  return 'RedeemCode(id: $id, code: $code, presentId: $presentId, activeAt: $activeAt, grants: $grants, usageLimit: $usageLimit, usageCount: $usageCount, redemptions: $redemptions, expiresAt: $expiresAt, isRevoked: $isRevoked, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RedeemCodeCopyWith<$Res>  {
  factory $RedeemCodeCopyWith(RedeemCode value, $Res Function(RedeemCode) _then) = _$RedeemCodeCopyWithImpl;
@useResult
$Res call({
 String id, String code, String? presentId, DateTime? activeAt, List<AssetGrant> grants,@JsonKey(readValue: readUsageLimit) int usageLimit, int usageCount, List<RedeemCodeRedemption> redemptions, DateTime? expiresAt, bool isRevoked, DateTime? createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? presentId = freezed,Object? activeAt = freezed,Object? grants = null,Object? usageLimit = null,Object? usageCount = null,Object? redemptions = null,Object? expiresAt = freezed,Object? isRevoked = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,presentId: freezed == presentId ? _self.presentId : presentId // ignore: cast_nullable_to_non_nullable
as String?,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,grants: null == grants ? _self.grants : grants // ignore: cast_nullable_to_non_nullable
as List<AssetGrant>,usageLimit: null == usageLimit ? _self.usageLimit : usageLimit // ignore: cast_nullable_to_non_nullable
as int,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,redemptions: null == redemptions ? _self.redemptions : redemptions // ignore: cast_nullable_to_non_nullable
as List<RedeemCodeRedemption>,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String? presentId,  DateTime? activeAt,  List<AssetGrant> grants, @JsonKey(readValue: readUsageLimit)  int usageLimit,  int usageCount,  List<RedeemCodeRedemption> redemptions,  DateTime? expiresAt,  bool isRevoked,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RedeemCode() when $default != null:
return $default(_that.id,_that.code,_that.presentId,_that.activeAt,_that.grants,_that.usageLimit,_that.usageCount,_that.redemptions,_that.expiresAt,_that.isRevoked,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String? presentId,  DateTime? activeAt,  List<AssetGrant> grants, @JsonKey(readValue: readUsageLimit)  int usageLimit,  int usageCount,  List<RedeemCodeRedemption> redemptions,  DateTime? expiresAt,  bool isRevoked,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _RedeemCode():
return $default(_that.id,_that.code,_that.presentId,_that.activeAt,_that.grants,_that.usageLimit,_that.usageCount,_that.redemptions,_that.expiresAt,_that.isRevoked,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String? presentId,  DateTime? activeAt,  List<AssetGrant> grants, @JsonKey(readValue: readUsageLimit)  int usageLimit,  int usageCount,  List<RedeemCodeRedemption> redemptions,  DateTime? expiresAt,  bool isRevoked,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RedeemCode() when $default != null:
return $default(_that.id,_that.code,_that.presentId,_that.activeAt,_that.grants,_that.usageLimit,_that.usageCount,_that.redemptions,_that.expiresAt,_that.isRevoked,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RedeemCode implements RedeemCode {
  const _RedeemCode({required this.id, required this.code, this.presentId, this.activeAt, final  List<AssetGrant> grants = const [], @JsonKey(readValue: readUsageLimit) this.usageLimit = 1, this.usageCount = 0, final  List<RedeemCodeRedemption> redemptions = const [], this.expiresAt, this.isRevoked = false, this.createdAt}): _grants = grants,_redemptions = redemptions;
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
 final  List<RedeemCodeRedemption> _redemptions;
@override@JsonKey() List<RedeemCodeRedemption> get redemptions {
  if (_redemptions is EqualUnmodifiableListView) return _redemptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_redemptions);
}

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RedeemCode&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.presentId, presentId) || other.presentId == presentId)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&const DeepCollectionEquality().equals(other._grants, _grants)&&(identical(other.usageLimit, usageLimit) || other.usageLimit == usageLimit)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&const DeepCollectionEquality().equals(other._redemptions, _redemptions)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isRevoked, isRevoked) || other.isRevoked == isRevoked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,presentId,activeAt,const DeepCollectionEquality().hash(_grants),usageLimit,usageCount,const DeepCollectionEquality().hash(_redemptions),expiresAt,isRevoked,createdAt);

@override
String toString() {
  return 'RedeemCode(id: $id, code: $code, presentId: $presentId, activeAt: $activeAt, grants: $grants, usageLimit: $usageLimit, usageCount: $usageCount, redemptions: $redemptions, expiresAt: $expiresAt, isRevoked: $isRevoked, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RedeemCodeCopyWith<$Res> implements $RedeemCodeCopyWith<$Res> {
  factory _$RedeemCodeCopyWith(_RedeemCode value, $Res Function(_RedeemCode) _then) = __$RedeemCodeCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String? presentId, DateTime? activeAt, List<AssetGrant> grants,@JsonKey(readValue: readUsageLimit) int usageLimit, int usageCount, List<RedeemCodeRedemption> redemptions, DateTime? expiresAt, bool isRevoked, DateTime? createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? presentId = freezed,Object? activeAt = freezed,Object? grants = null,Object? usageLimit = null,Object? usageCount = null,Object? redemptions = null,Object? expiresAt = freezed,Object? isRevoked = null,Object? createdAt = freezed,}) {
  return _then(_RedeemCode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,presentId: freezed == presentId ? _self.presentId : presentId // ignore: cast_nullable_to_non_nullable
as String?,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,grants: null == grants ? _self._grants : grants // ignore: cast_nullable_to_non_nullable
as List<AssetGrant>,usageLimit: null == usageLimit ? _self.usageLimit : usageLimit // ignore: cast_nullable_to_non_nullable
as int,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,redemptions: null == redemptions ? _self._redemptions : redemptions // ignore: cast_nullable_to_non_nullable
as List<RedeemCodeRedemption>,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isRevoked: null == isRevoked ? _self.isRevoked : isRevoked // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$RedeemCodeRedemption {

 String get playerId; String get playerDisplayName; DateTime get redeemedAt;
/// Create a copy of RedeemCodeRedemption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RedeemCodeRedemptionCopyWith<RedeemCodeRedemption> get copyWith => _$RedeemCodeRedemptionCopyWithImpl<RedeemCodeRedemption>(this as RedeemCodeRedemption, _$identity);

  /// Serializes this RedeemCodeRedemption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RedeemCodeRedemption&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.playerDisplayName, playerDisplayName) || other.playerDisplayName == playerDisplayName)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,playerDisplayName,redeemedAt);

@override
String toString() {
  return 'RedeemCodeRedemption(playerId: $playerId, playerDisplayName: $playerDisplayName, redeemedAt: $redeemedAt)';
}


}

/// @nodoc
abstract mixin class $RedeemCodeRedemptionCopyWith<$Res>  {
  factory $RedeemCodeRedemptionCopyWith(RedeemCodeRedemption value, $Res Function(RedeemCodeRedemption) _then) = _$RedeemCodeRedemptionCopyWithImpl;
@useResult
$Res call({
 String playerId, String playerDisplayName, DateTime redeemedAt
});




}
/// @nodoc
class _$RedeemCodeRedemptionCopyWithImpl<$Res>
    implements $RedeemCodeRedemptionCopyWith<$Res> {
  _$RedeemCodeRedemptionCopyWithImpl(this._self, this._then);

  final RedeemCodeRedemption _self;
  final $Res Function(RedeemCodeRedemption) _then;

/// Create a copy of RedeemCodeRedemption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? playerDisplayName = null,Object? redeemedAt = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,playerDisplayName: null == playerDisplayName ? _self.playerDisplayName : playerDisplayName // ignore: cast_nullable_to_non_nullable
as String,redeemedAt: null == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RedeemCodeRedemption].
extension RedeemCodeRedemptionPatterns on RedeemCodeRedemption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RedeemCodeRedemption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RedeemCodeRedemption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RedeemCodeRedemption value)  $default,){
final _that = this;
switch (_that) {
case _RedeemCodeRedemption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RedeemCodeRedemption value)?  $default,){
final _that = this;
switch (_that) {
case _RedeemCodeRedemption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  String playerDisplayName,  DateTime redeemedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RedeemCodeRedemption() when $default != null:
return $default(_that.playerId,_that.playerDisplayName,_that.redeemedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  String playerDisplayName,  DateTime redeemedAt)  $default,) {final _that = this;
switch (_that) {
case _RedeemCodeRedemption():
return $default(_that.playerId,_that.playerDisplayName,_that.redeemedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  String playerDisplayName,  DateTime redeemedAt)?  $default,) {final _that = this;
switch (_that) {
case _RedeemCodeRedemption() when $default != null:
return $default(_that.playerId,_that.playerDisplayName,_that.redeemedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RedeemCodeRedemption implements RedeemCodeRedemption {
  const _RedeemCodeRedemption({required this.playerId, required this.playerDisplayName, required this.redeemedAt});
  factory _RedeemCodeRedemption.fromJson(Map<String, dynamic> json) => _$RedeemCodeRedemptionFromJson(json);

@override final  String playerId;
@override final  String playerDisplayName;
@override final  DateTime redeemedAt;

/// Create a copy of RedeemCodeRedemption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RedeemCodeRedemptionCopyWith<_RedeemCodeRedemption> get copyWith => __$RedeemCodeRedemptionCopyWithImpl<_RedeemCodeRedemption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RedeemCodeRedemptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RedeemCodeRedemption&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.playerDisplayName, playerDisplayName) || other.playerDisplayName == playerDisplayName)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,playerDisplayName,redeemedAt);

@override
String toString() {
  return 'RedeemCodeRedemption(playerId: $playerId, playerDisplayName: $playerDisplayName, redeemedAt: $redeemedAt)';
}


}

/// @nodoc
abstract mixin class _$RedeemCodeRedemptionCopyWith<$Res> implements $RedeemCodeRedemptionCopyWith<$Res> {
  factory _$RedeemCodeRedemptionCopyWith(_RedeemCodeRedemption value, $Res Function(_RedeemCodeRedemption) _then) = __$RedeemCodeRedemptionCopyWithImpl;
@override @useResult
$Res call({
 String playerId, String playerDisplayName, DateTime redeemedAt
});




}
/// @nodoc
class __$RedeemCodeRedemptionCopyWithImpl<$Res>
    implements _$RedeemCodeRedemptionCopyWith<$Res> {
  __$RedeemCodeRedemptionCopyWithImpl(this._self, this._then);

  final _RedeemCodeRedemption _self;
  final $Res Function(_RedeemCodeRedemption) _then;

/// Create a copy of RedeemCodeRedemption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? playerDisplayName = null,Object? redeemedAt = null,}) {
  return _then(_RedeemCodeRedemption(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,playerDisplayName: null == playerDisplayName ? _self.playerDisplayName : playerDisplayName // ignore: cast_nullable_to_non_nullable
as String,redeemedAt: null == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PlayerRedeemRecord {

 String get codeId; String get code; String get presentId; String get presentName; DateTime get redeemedAt;
/// Create a copy of PlayerRedeemRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerRedeemRecordCopyWith<PlayerRedeemRecord> get copyWith => _$PlayerRedeemRecordCopyWithImpl<PlayerRedeemRecord>(this as PlayerRedeemRecord, _$identity);

  /// Serializes this PlayerRedeemRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerRedeemRecord&&(identical(other.codeId, codeId) || other.codeId == codeId)&&(identical(other.code, code) || other.code == code)&&(identical(other.presentId, presentId) || other.presentId == presentId)&&(identical(other.presentName, presentName) || other.presentName == presentName)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,codeId,code,presentId,presentName,redeemedAt);

@override
String toString() {
  return 'PlayerRedeemRecord(codeId: $codeId, code: $code, presentId: $presentId, presentName: $presentName, redeemedAt: $redeemedAt)';
}


}

/// @nodoc
abstract mixin class $PlayerRedeemRecordCopyWith<$Res>  {
  factory $PlayerRedeemRecordCopyWith(PlayerRedeemRecord value, $Res Function(PlayerRedeemRecord) _then) = _$PlayerRedeemRecordCopyWithImpl;
@useResult
$Res call({
 String codeId, String code, String presentId, String presentName, DateTime redeemedAt
});




}
/// @nodoc
class _$PlayerRedeemRecordCopyWithImpl<$Res>
    implements $PlayerRedeemRecordCopyWith<$Res> {
  _$PlayerRedeemRecordCopyWithImpl(this._self, this._then);

  final PlayerRedeemRecord _self;
  final $Res Function(PlayerRedeemRecord) _then;

/// Create a copy of PlayerRedeemRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? codeId = null,Object? code = null,Object? presentId = null,Object? presentName = null,Object? redeemedAt = null,}) {
  return _then(_self.copyWith(
codeId: null == codeId ? _self.codeId : codeId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,presentId: null == presentId ? _self.presentId : presentId // ignore: cast_nullable_to_non_nullable
as String,presentName: null == presentName ? _self.presentName : presentName // ignore: cast_nullable_to_non_nullable
as String,redeemedAt: null == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerRedeemRecord].
extension PlayerRedeemRecordPatterns on PlayerRedeemRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerRedeemRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerRedeemRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerRedeemRecord value)  $default,){
final _that = this;
switch (_that) {
case _PlayerRedeemRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerRedeemRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerRedeemRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String codeId,  String code,  String presentId,  String presentName,  DateTime redeemedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerRedeemRecord() when $default != null:
return $default(_that.codeId,_that.code,_that.presentId,_that.presentName,_that.redeemedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String codeId,  String code,  String presentId,  String presentName,  DateTime redeemedAt)  $default,) {final _that = this;
switch (_that) {
case _PlayerRedeemRecord():
return $default(_that.codeId,_that.code,_that.presentId,_that.presentName,_that.redeemedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String codeId,  String code,  String presentId,  String presentName,  DateTime redeemedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlayerRedeemRecord() when $default != null:
return $default(_that.codeId,_that.code,_that.presentId,_that.presentName,_that.redeemedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerRedeemRecord implements PlayerRedeemRecord {
  const _PlayerRedeemRecord({required this.codeId, required this.code, required this.presentId, required this.presentName, required this.redeemedAt});
  factory _PlayerRedeemRecord.fromJson(Map<String, dynamic> json) => _$PlayerRedeemRecordFromJson(json);

@override final  String codeId;
@override final  String code;
@override final  String presentId;
@override final  String presentName;
@override final  DateTime redeemedAt;

/// Create a copy of PlayerRedeemRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerRedeemRecordCopyWith<_PlayerRedeemRecord> get copyWith => __$PlayerRedeemRecordCopyWithImpl<_PlayerRedeemRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerRedeemRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerRedeemRecord&&(identical(other.codeId, codeId) || other.codeId == codeId)&&(identical(other.code, code) || other.code == code)&&(identical(other.presentId, presentId) || other.presentId == presentId)&&(identical(other.presentName, presentName) || other.presentName == presentName)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,codeId,code,presentId,presentName,redeemedAt);

@override
String toString() {
  return 'PlayerRedeemRecord(codeId: $codeId, code: $code, presentId: $presentId, presentName: $presentName, redeemedAt: $redeemedAt)';
}


}

/// @nodoc
abstract mixin class _$PlayerRedeemRecordCopyWith<$Res> implements $PlayerRedeemRecordCopyWith<$Res> {
  factory _$PlayerRedeemRecordCopyWith(_PlayerRedeemRecord value, $Res Function(_PlayerRedeemRecord) _then) = __$PlayerRedeemRecordCopyWithImpl;
@override @useResult
$Res call({
 String codeId, String code, String presentId, String presentName, DateTime redeemedAt
});




}
/// @nodoc
class __$PlayerRedeemRecordCopyWithImpl<$Res>
    implements _$PlayerRedeemRecordCopyWith<$Res> {
  __$PlayerRedeemRecordCopyWithImpl(this._self, this._then);

  final _PlayerRedeemRecord _self;
  final $Res Function(_PlayerRedeemRecord) _then;

/// Create a copy of PlayerRedeemRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? codeId = null,Object? code = null,Object? presentId = null,Object? presentName = null,Object? redeemedAt = null,}) {
  return _then(_PlayerRedeemRecord(
codeId: null == codeId ? _self.codeId : codeId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,presentId: null == presentId ? _self.presentId : presentId // ignore: cast_nullable_to_non_nullable
as String,presentName: null == presentName ? _self.presentName : presentName // ignore: cast_nullable_to_non_nullable
as String,redeemedAt: null == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PriorityTimeRule {

 String get id; String get label; int get priority; String get status;@JsonKey(readValue: readHasTimeRange) bool get hasTimeRange;@JsonKey(readValue: readStartTime) String get startTime;@JsonKey(readValue: readEndTime) String get endTime; List<int> get weekdays;@JsonKey(readValue: readSpecificDates) List<String> get specificDates; String? get specificDate;@JsonKey(readValue: readStartDateTime) String? get startDateTime;@JsonKey(readValue: readEndDateTime) String? get endDateTime;@JsonKey(readValue: readUnitMinutes) int get unitMinutes;@JsonKey(readValue: readUnitPrice) num get unitPrice;@JsonKey(readValue: readGraceMinutes) int get graceMinutes;@JsonKey(readValue: readPriceCap) num? get priceCap;
/// Create a copy of PriorityTimeRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriorityTimeRuleCopyWith<PriorityTimeRule> get copyWith => _$PriorityTimeRuleCopyWithImpl<PriorityTimeRule>(this as PriorityTimeRule, _$identity);

  /// Serializes this PriorityTimeRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriorityTimeRule&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.hasTimeRange, hasTimeRange) || other.hasTimeRange == hasTimeRange)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other.weekdays, weekdays)&&const DeepCollectionEquality().equals(other.specificDates, specificDates)&&(identical(other.specificDate, specificDate) || other.specificDate == specificDate)&&(identical(other.startDateTime, startDateTime) || other.startDateTime == startDateTime)&&(identical(other.endDateTime, endDateTime) || other.endDateTime == endDateTime)&&(identical(other.unitMinutes, unitMinutes) || other.unitMinutes == unitMinutes)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.graceMinutes, graceMinutes) || other.graceMinutes == graceMinutes)&&(identical(other.priceCap, priceCap) || other.priceCap == priceCap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,priority,status,hasTimeRange,startTime,endTime,const DeepCollectionEquality().hash(weekdays),const DeepCollectionEquality().hash(specificDates),specificDate,startDateTime,endDateTime,unitMinutes,unitPrice,graceMinutes,priceCap);

@override
String toString() {
  return 'PriorityTimeRule(id: $id, label: $label, priority: $priority, status: $status, hasTimeRange: $hasTimeRange, startTime: $startTime, endTime: $endTime, weekdays: $weekdays, specificDates: $specificDates, specificDate: $specificDate, startDateTime: $startDateTime, endDateTime: $endDateTime, unitMinutes: $unitMinutes, unitPrice: $unitPrice, graceMinutes: $graceMinutes, priceCap: $priceCap)';
}


}

/// @nodoc
abstract mixin class $PriorityTimeRuleCopyWith<$Res>  {
  factory $PriorityTimeRuleCopyWith(PriorityTimeRule value, $Res Function(PriorityTimeRule) _then) = _$PriorityTimeRuleCopyWithImpl;
@useResult
$Res call({
 String id, String label, int priority, String status,@JsonKey(readValue: readHasTimeRange) bool hasTimeRange,@JsonKey(readValue: readStartTime) String startTime,@JsonKey(readValue: readEndTime) String endTime, List<int> weekdays,@JsonKey(readValue: readSpecificDates) List<String> specificDates, String? specificDate,@JsonKey(readValue: readStartDateTime) String? startDateTime,@JsonKey(readValue: readEndDateTime) String? endDateTime,@JsonKey(readValue: readUnitMinutes) int unitMinutes,@JsonKey(readValue: readUnitPrice) num unitPrice,@JsonKey(readValue: readGraceMinutes) int graceMinutes,@JsonKey(readValue: readPriceCap) num? priceCap
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? priority = null,Object? status = null,Object? hasTimeRange = null,Object? startTime = null,Object? endTime = null,Object? weekdays = null,Object? specificDates = null,Object? specificDate = freezed,Object? startDateTime = freezed,Object? endDateTime = freezed,Object? unitMinutes = null,Object? unitPrice = null,Object? graceMinutes = null,Object? priceCap = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,hasTimeRange: null == hasTimeRange ? _self.hasTimeRange : hasTimeRange // ignore: cast_nullable_to_non_nullable
as bool,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,weekdays: null == weekdays ? _self.weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as List<int>,specificDates: null == specificDates ? _self.specificDates : specificDates // ignore: cast_nullable_to_non_nullable
as List<String>,specificDate: freezed == specificDate ? _self.specificDate : specificDate // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  int priority,  String status, @JsonKey(readValue: readHasTimeRange)  bool hasTimeRange, @JsonKey(readValue: readStartTime)  String startTime, @JsonKey(readValue: readEndTime)  String endTime,  List<int> weekdays, @JsonKey(readValue: readSpecificDates)  List<String> specificDates,  String? specificDate, @JsonKey(readValue: readStartDateTime)  String? startDateTime, @JsonKey(readValue: readEndDateTime)  String? endDateTime, @JsonKey(readValue: readUnitMinutes)  int unitMinutes, @JsonKey(readValue: readUnitPrice)  num unitPrice, @JsonKey(readValue: readGraceMinutes)  int graceMinutes, @JsonKey(readValue: readPriceCap)  num? priceCap)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriorityTimeRule() when $default != null:
return $default(_that.id,_that.label,_that.priority,_that.status,_that.hasTimeRange,_that.startTime,_that.endTime,_that.weekdays,_that.specificDates,_that.specificDate,_that.startDateTime,_that.endDateTime,_that.unitMinutes,_that.unitPrice,_that.graceMinutes,_that.priceCap);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  int priority,  String status, @JsonKey(readValue: readHasTimeRange)  bool hasTimeRange, @JsonKey(readValue: readStartTime)  String startTime, @JsonKey(readValue: readEndTime)  String endTime,  List<int> weekdays, @JsonKey(readValue: readSpecificDates)  List<String> specificDates,  String? specificDate, @JsonKey(readValue: readStartDateTime)  String? startDateTime, @JsonKey(readValue: readEndDateTime)  String? endDateTime, @JsonKey(readValue: readUnitMinutes)  int unitMinutes, @JsonKey(readValue: readUnitPrice)  num unitPrice, @JsonKey(readValue: readGraceMinutes)  int graceMinutes, @JsonKey(readValue: readPriceCap)  num? priceCap)  $default,) {final _that = this;
switch (_that) {
case _PriorityTimeRule():
return $default(_that.id,_that.label,_that.priority,_that.status,_that.hasTimeRange,_that.startTime,_that.endTime,_that.weekdays,_that.specificDates,_that.specificDate,_that.startDateTime,_that.endDateTime,_that.unitMinutes,_that.unitPrice,_that.graceMinutes,_that.priceCap);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  int priority,  String status, @JsonKey(readValue: readHasTimeRange)  bool hasTimeRange, @JsonKey(readValue: readStartTime)  String startTime, @JsonKey(readValue: readEndTime)  String endTime,  List<int> weekdays, @JsonKey(readValue: readSpecificDates)  List<String> specificDates,  String? specificDate, @JsonKey(readValue: readStartDateTime)  String? startDateTime, @JsonKey(readValue: readEndDateTime)  String? endDateTime, @JsonKey(readValue: readUnitMinutes)  int unitMinutes, @JsonKey(readValue: readUnitPrice)  num unitPrice, @JsonKey(readValue: readGraceMinutes)  int graceMinutes, @JsonKey(readValue: readPriceCap)  num? priceCap)?  $default,) {final _that = this;
switch (_that) {
case _PriorityTimeRule() when $default != null:
return $default(_that.id,_that.label,_that.priority,_that.status,_that.hasTimeRange,_that.startTime,_that.endTime,_that.weekdays,_that.specificDates,_that.specificDate,_that.startDateTime,_that.endDateTime,_that.unitMinutes,_that.unitPrice,_that.graceMinutes,_that.priceCap);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PriorityTimeRule implements PriorityTimeRule {
  const _PriorityTimeRule({this.id = '', required this.label, required this.priority, this.status = 'active', @JsonKey(readValue: readHasTimeRange) this.hasTimeRange = false, @JsonKey(readValue: readStartTime) required this.startTime, @JsonKey(readValue: readEndTime) required this.endTime, final  List<int> weekdays = const [], @JsonKey(readValue: readSpecificDates) final  List<String> specificDates = const [], this.specificDate, @JsonKey(readValue: readStartDateTime) this.startDateTime, @JsonKey(readValue: readEndDateTime) this.endDateTime, @JsonKey(readValue: readUnitMinutes) this.unitMinutes = 0, @JsonKey(readValue: readUnitPrice) this.unitPrice = 0, @JsonKey(readValue: readGraceMinutes) this.graceMinutes = 0, @JsonKey(readValue: readPriceCap) this.priceCap}): _weekdays = weekdays,_specificDates = specificDates;
  factory _PriorityTimeRule.fromJson(Map<String, dynamic> json) => _$PriorityTimeRuleFromJson(json);

@override@JsonKey() final  String id;
@override final  String label;
@override final  int priority;
@override@JsonKey() final  String status;
@override@JsonKey(readValue: readHasTimeRange) final  bool hasTimeRange;
@override@JsonKey(readValue: readStartTime) final  String startTime;
@override@JsonKey(readValue: readEndTime) final  String endTime;
 final  List<int> _weekdays;
@override@JsonKey() List<int> get weekdays {
  if (_weekdays is EqualUnmodifiableListView) return _weekdays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekdays);
}

 final  List<String> _specificDates;
@override@JsonKey(readValue: readSpecificDates) List<String> get specificDates {
  if (_specificDates is EqualUnmodifiableListView) return _specificDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specificDates);
}

@override final  String? specificDate;
@override@JsonKey(readValue: readStartDateTime) final  String? startDateTime;
@override@JsonKey(readValue: readEndDateTime) final  String? endDateTime;
@override@JsonKey(readValue: readUnitMinutes) final  int unitMinutes;
@override@JsonKey(readValue: readUnitPrice) final  num unitPrice;
@override@JsonKey(readValue: readGraceMinutes) final  int graceMinutes;
@override@JsonKey(readValue: readPriceCap) final  num? priceCap;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriorityTimeRule&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.hasTimeRange, hasTimeRange) || other.hasTimeRange == hasTimeRange)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other._weekdays, _weekdays)&&const DeepCollectionEquality().equals(other._specificDates, _specificDates)&&(identical(other.specificDate, specificDate) || other.specificDate == specificDate)&&(identical(other.startDateTime, startDateTime) || other.startDateTime == startDateTime)&&(identical(other.endDateTime, endDateTime) || other.endDateTime == endDateTime)&&(identical(other.unitMinutes, unitMinutes) || other.unitMinutes == unitMinutes)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.graceMinutes, graceMinutes) || other.graceMinutes == graceMinutes)&&(identical(other.priceCap, priceCap) || other.priceCap == priceCap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,priority,status,hasTimeRange,startTime,endTime,const DeepCollectionEquality().hash(_weekdays),const DeepCollectionEquality().hash(_specificDates),specificDate,startDateTime,endDateTime,unitMinutes,unitPrice,graceMinutes,priceCap);

@override
String toString() {
  return 'PriorityTimeRule(id: $id, label: $label, priority: $priority, status: $status, hasTimeRange: $hasTimeRange, startTime: $startTime, endTime: $endTime, weekdays: $weekdays, specificDates: $specificDates, specificDate: $specificDate, startDateTime: $startDateTime, endDateTime: $endDateTime, unitMinutes: $unitMinutes, unitPrice: $unitPrice, graceMinutes: $graceMinutes, priceCap: $priceCap)';
}


}

/// @nodoc
abstract mixin class _$PriorityTimeRuleCopyWith<$Res> implements $PriorityTimeRuleCopyWith<$Res> {
  factory _$PriorityTimeRuleCopyWith(_PriorityTimeRule value, $Res Function(_PriorityTimeRule) _then) = __$PriorityTimeRuleCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, int priority, String status,@JsonKey(readValue: readHasTimeRange) bool hasTimeRange,@JsonKey(readValue: readStartTime) String startTime,@JsonKey(readValue: readEndTime) String endTime, List<int> weekdays,@JsonKey(readValue: readSpecificDates) List<String> specificDates, String? specificDate,@JsonKey(readValue: readStartDateTime) String? startDateTime,@JsonKey(readValue: readEndDateTime) String? endDateTime,@JsonKey(readValue: readUnitMinutes) int unitMinutes,@JsonKey(readValue: readUnitPrice) num unitPrice,@JsonKey(readValue: readGraceMinutes) int graceMinutes,@JsonKey(readValue: readPriceCap) num? priceCap
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? priority = null,Object? status = null,Object? hasTimeRange = null,Object? startTime = null,Object? endTime = null,Object? weekdays = null,Object? specificDates = null,Object? specificDate = freezed,Object? startDateTime = freezed,Object? endDateTime = freezed,Object? unitMinutes = null,Object? unitPrice = null,Object? graceMinutes = null,Object? priceCap = freezed,}) {
  return _then(_PriorityTimeRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,hasTimeRange: null == hasTimeRange ? _self.hasTimeRange : hasTimeRange // ignore: cast_nullable_to_non_nullable
as bool,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,weekdays: null == weekdays ? _self._weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as List<int>,specificDates: null == specificDates ? _self._specificDates : specificDates // ignore: cast_nullable_to_non_nullable
as List<String>,specificDate: freezed == specificDate ? _self.specificDate : specificDate // ignore: cast_nullable_to_non_nullable
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

 String get id; String get name; String get kind;@JsonKey(readValue: readPricingRules) List<PriorityTimeRule> get rules;@JsonKey(readValue: readProviderId) String? get providerId;@JsonKey(readValue: readFixedChargeLabel) String? get fixedChargeLabel;@JsonKey(readValue: readFixedChargeAmount) num? get fixedChargeAmount;@JsonKey(readValue: readIncludedPricingConfigIds) List<String> get includedPricingConfigIds;@JsonKey(readValue: readIsArchived) bool get isArchived;@JsonKey(readValue: readIsActive) bool get isActive;
/// Create a copy of PricingConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricingConfigCopyWith<PricingConfig> get copyWith => _$PricingConfigCopyWithImpl<PricingConfig>(this as PricingConfig, _$identity);

  /// Serializes this PricingConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricingConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.rules, rules)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.fixedChargeLabel, fixedChargeLabel) || other.fixedChargeLabel == fixedChargeLabel)&&(identical(other.fixedChargeAmount, fixedChargeAmount) || other.fixedChargeAmount == fixedChargeAmount)&&const DeepCollectionEquality().equals(other.includedPricingConfigIds, includedPricingConfigIds)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kind,const DeepCollectionEquality().hash(rules),providerId,fixedChargeLabel,fixedChargeAmount,const DeepCollectionEquality().hash(includedPricingConfigIds),isArchived,isActive);

@override
String toString() {
  return 'PricingConfig(id: $id, name: $name, kind: $kind, rules: $rules, providerId: $providerId, fixedChargeLabel: $fixedChargeLabel, fixedChargeAmount: $fixedChargeAmount, includedPricingConfigIds: $includedPricingConfigIds, isArchived: $isArchived, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $PricingConfigCopyWith<$Res>  {
  factory $PricingConfigCopyWith(PricingConfig value, $Res Function(PricingConfig) _then) = _$PricingConfigCopyWithImpl;
@useResult
$Res call({
 String id, String name, String kind,@JsonKey(readValue: readPricingRules) List<PriorityTimeRule> rules,@JsonKey(readValue: readProviderId) String? providerId,@JsonKey(readValue: readFixedChargeLabel) String? fixedChargeLabel,@JsonKey(readValue: readFixedChargeAmount) num? fixedChargeAmount,@JsonKey(readValue: readIncludedPricingConfigIds) List<String> includedPricingConfigIds,@JsonKey(readValue: readIsArchived) bool isArchived,@JsonKey(readValue: readIsActive) bool isActive
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? rules = null,Object? providerId = freezed,Object? fixedChargeLabel = freezed,Object? fixedChargeAmount = freezed,Object? includedPricingConfigIds = null,Object? isArchived = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<PriorityTimeRule>,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String?,fixedChargeLabel: freezed == fixedChargeLabel ? _self.fixedChargeLabel : fixedChargeLabel // ignore: cast_nullable_to_non_nullable
as String?,fixedChargeAmount: freezed == fixedChargeAmount ? _self.fixedChargeAmount : fixedChargeAmount // ignore: cast_nullable_to_non_nullable
as num?,includedPricingConfigIds: null == includedPricingConfigIds ? _self.includedPricingConfigIds : includedPricingConfigIds // ignore: cast_nullable_to_non_nullable
as List<String>,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String kind, @JsonKey(readValue: readPricingRules)  List<PriorityTimeRule> rules, @JsonKey(readValue: readProviderId)  String? providerId, @JsonKey(readValue: readFixedChargeLabel)  String? fixedChargeLabel, @JsonKey(readValue: readFixedChargeAmount)  num? fixedChargeAmount, @JsonKey(readValue: readIncludedPricingConfigIds)  List<String> includedPricingConfigIds, @JsonKey(readValue: readIsArchived)  bool isArchived, @JsonKey(readValue: readIsActive)  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.rules,_that.providerId,_that.fixedChargeLabel,_that.fixedChargeAmount,_that.includedPricingConfigIds,_that.isArchived,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String kind, @JsonKey(readValue: readPricingRules)  List<PriorityTimeRule> rules, @JsonKey(readValue: readProviderId)  String? providerId, @JsonKey(readValue: readFixedChargeLabel)  String? fixedChargeLabel, @JsonKey(readValue: readFixedChargeAmount)  num? fixedChargeAmount, @JsonKey(readValue: readIncludedPricingConfigIds)  List<String> includedPricingConfigIds, @JsonKey(readValue: readIsArchived)  bool isArchived, @JsonKey(readValue: readIsActive)  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _PricingConfig():
return $default(_that.id,_that.name,_that.kind,_that.rules,_that.providerId,_that.fixedChargeLabel,_that.fixedChargeAmount,_that.includedPricingConfigIds,_that.isArchived,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String kind, @JsonKey(readValue: readPricingRules)  List<PriorityTimeRule> rules, @JsonKey(readValue: readProviderId)  String? providerId, @JsonKey(readValue: readFixedChargeLabel)  String? fixedChargeLabel, @JsonKey(readValue: readFixedChargeAmount)  num? fixedChargeAmount, @JsonKey(readValue: readIncludedPricingConfigIds)  List<String> includedPricingConfigIds, @JsonKey(readValue: readIsArchived)  bool isArchived, @JsonKey(readValue: readIsActive)  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _PricingConfig() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.rules,_that.providerId,_that.fixedChargeLabel,_that.fixedChargeAmount,_that.includedPricingConfigIds,_that.isArchived,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PricingConfig implements PricingConfig {
  const _PricingConfig({required this.id, required this.name, required this.kind, @JsonKey(readValue: readPricingRules) required final  List<PriorityTimeRule> rules, @JsonKey(readValue: readProviderId) this.providerId, @JsonKey(readValue: readFixedChargeLabel) this.fixedChargeLabel, @JsonKey(readValue: readFixedChargeAmount) this.fixedChargeAmount, @JsonKey(readValue: readIncludedPricingConfigIds) final  List<String> includedPricingConfigIds = const [], @JsonKey(readValue: readIsArchived) this.isArchived = false, @JsonKey(readValue: readIsActive) this.isActive = true}): _rules = rules,_includedPricingConfigIds = includedPricingConfigIds;
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

@override@JsonKey(readValue: readProviderId) final  String? providerId;
@override@JsonKey(readValue: readFixedChargeLabel) final  String? fixedChargeLabel;
@override@JsonKey(readValue: readFixedChargeAmount) final  num? fixedChargeAmount;
 final  List<String> _includedPricingConfigIds;
@override@JsonKey(readValue: readIncludedPricingConfigIds) List<String> get includedPricingConfigIds {
  if (_includedPricingConfigIds is EqualUnmodifiableListView) return _includedPricingConfigIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_includedPricingConfigIds);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricingConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other._rules, _rules)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.fixedChargeLabel, fixedChargeLabel) || other.fixedChargeLabel == fixedChargeLabel)&&(identical(other.fixedChargeAmount, fixedChargeAmount) || other.fixedChargeAmount == fixedChargeAmount)&&const DeepCollectionEquality().equals(other._includedPricingConfigIds, _includedPricingConfigIds)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kind,const DeepCollectionEquality().hash(_rules),providerId,fixedChargeLabel,fixedChargeAmount,const DeepCollectionEquality().hash(_includedPricingConfigIds),isArchived,isActive);

@override
String toString() {
  return 'PricingConfig(id: $id, name: $name, kind: $kind, rules: $rules, providerId: $providerId, fixedChargeLabel: $fixedChargeLabel, fixedChargeAmount: $fixedChargeAmount, includedPricingConfigIds: $includedPricingConfigIds, isArchived: $isArchived, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$PricingConfigCopyWith<$Res> implements $PricingConfigCopyWith<$Res> {
  factory _$PricingConfigCopyWith(_PricingConfig value, $Res Function(_PricingConfig) _then) = __$PricingConfigCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String kind,@JsonKey(readValue: readPricingRules) List<PriorityTimeRule> rules,@JsonKey(readValue: readProviderId) String? providerId,@JsonKey(readValue: readFixedChargeLabel) String? fixedChargeLabel,@JsonKey(readValue: readFixedChargeAmount) num? fixedChargeAmount,@JsonKey(readValue: readIncludedPricingConfigIds) List<String> includedPricingConfigIds,@JsonKey(readValue: readIsArchived) bool isArchived,@JsonKey(readValue: readIsActive) bool isActive
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? rules = null,Object? providerId = freezed,Object? fixedChargeLabel = freezed,Object? fixedChargeAmount = freezed,Object? includedPricingConfigIds = null,Object? isArchived = null,Object? isActive = null,}) {
  return _then(_PricingConfig(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<PriorityTimeRule>,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String?,fixedChargeLabel: freezed == fixedChargeLabel ? _self.fixedChargeLabel : fixedChargeLabel // ignore: cast_nullable_to_non_nullable
as String?,fixedChargeAmount: freezed == fixedChargeAmount ? _self.fixedChargeAmount : fixedChargeAmount // ignore: cast_nullable_to_non_nullable
as num?,includedPricingConfigIds: null == includedPricingConfigIds ? _self._includedPricingConfigIds : includedPricingConfigIds // ignore: cast_nullable_to_non_nullable
as List<String>,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$UnitPricing {

 String get ruleId; int get startMinute; int get endMinute;@JsonKey(readValue: readStartTime) String get startTime;@JsonKey(readValue: readEndTime) String get endTime;@JsonKey(readValue: readTimelinePrice) num get price; bool get isClosed; String? get label;
/// Create a copy of UnitPricing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnitPricingCopyWith<UnitPricing> get copyWith => _$UnitPricingCopyWithImpl<UnitPricing>(this as UnitPricing, _$identity);

  /// Serializes this UnitPricing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnitPricing&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.startMinute, startMinute) || other.startMinute == startMinute)&&(identical(other.endMinute, endMinute) || other.endMinute == endMinute)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.price, price) || other.price == price)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ruleId,startMinute,endMinute,startTime,endTime,price,isClosed,label);

@override
String toString() {
  return 'UnitPricing(ruleId: $ruleId, startMinute: $startMinute, endMinute: $endMinute, startTime: $startTime, endTime: $endTime, price: $price, isClosed: $isClosed, label: $label)';
}


}

/// @nodoc
abstract mixin class $UnitPricingCopyWith<$Res>  {
  factory $UnitPricingCopyWith(UnitPricing value, $Res Function(UnitPricing) _then) = _$UnitPricingCopyWithImpl;
@useResult
$Res call({
 String ruleId, int startMinute, int endMinute,@JsonKey(readValue: readStartTime) String startTime,@JsonKey(readValue: readEndTime) String endTime,@JsonKey(readValue: readTimelinePrice) num price, bool isClosed, String? label
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
@pragma('vm:prefer-inline') @override $Res call({Object? ruleId = null,Object? startMinute = null,Object? endMinute = null,Object? startTime = null,Object? endTime = null,Object? price = null,Object? isClosed = null,Object? label = freezed,}) {
  return _then(_self.copyWith(
ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ruleId,  int startMinute,  int endMinute, @JsonKey(readValue: readStartTime)  String startTime, @JsonKey(readValue: readEndTime)  String endTime, @JsonKey(readValue: readTimelinePrice)  num price,  bool isClosed,  String? label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnitPricing() when $default != null:
return $default(_that.ruleId,_that.startMinute,_that.endMinute,_that.startTime,_that.endTime,_that.price,_that.isClosed,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ruleId,  int startMinute,  int endMinute, @JsonKey(readValue: readStartTime)  String startTime, @JsonKey(readValue: readEndTime)  String endTime, @JsonKey(readValue: readTimelinePrice)  num price,  bool isClosed,  String? label)  $default,) {final _that = this;
switch (_that) {
case _UnitPricing():
return $default(_that.ruleId,_that.startMinute,_that.endMinute,_that.startTime,_that.endTime,_that.price,_that.isClosed,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ruleId,  int startMinute,  int endMinute, @JsonKey(readValue: readStartTime)  String startTime, @JsonKey(readValue: readEndTime)  String endTime, @JsonKey(readValue: readTimelinePrice)  num price,  bool isClosed,  String? label)?  $default,) {final _that = this;
switch (_that) {
case _UnitPricing() when $default != null:
return $default(_that.ruleId,_that.startMinute,_that.endMinute,_that.startTime,_that.endTime,_that.price,_that.isClosed,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnitPricing implements UnitPricing {
  const _UnitPricing({this.ruleId = '', this.startMinute = 0, this.endMinute = 0, @JsonKey(readValue: readStartTime) required this.startTime, @JsonKey(readValue: readEndTime) required this.endTime, @JsonKey(readValue: readTimelinePrice) this.price = 0, this.isClosed = false, this.label});
  factory _UnitPricing.fromJson(Map<String, dynamic> json) => _$UnitPricingFromJson(json);

@override@JsonKey() final  String ruleId;
@override@JsonKey() final  int startMinute;
@override@JsonKey() final  int endMinute;
@override@JsonKey(readValue: readStartTime) final  String startTime;
@override@JsonKey(readValue: readEndTime) final  String endTime;
@override@JsonKey(readValue: readTimelinePrice) final  num price;
@override@JsonKey() final  bool isClosed;
@override final  String? label;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnitPricing&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.startMinute, startMinute) || other.startMinute == startMinute)&&(identical(other.endMinute, endMinute) || other.endMinute == endMinute)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.price, price) || other.price == price)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ruleId,startMinute,endMinute,startTime,endTime,price,isClosed,label);

@override
String toString() {
  return 'UnitPricing(ruleId: $ruleId, startMinute: $startMinute, endMinute: $endMinute, startTime: $startTime, endTime: $endTime, price: $price, isClosed: $isClosed, label: $label)';
}


}

/// @nodoc
abstract mixin class _$UnitPricingCopyWith<$Res> implements $UnitPricingCopyWith<$Res> {
  factory _$UnitPricingCopyWith(_UnitPricing value, $Res Function(_UnitPricing) _then) = __$UnitPricingCopyWithImpl;
@override @useResult
$Res call({
 String ruleId, int startMinute, int endMinute,@JsonKey(readValue: readStartTime) String startTime,@JsonKey(readValue: readEndTime) String endTime,@JsonKey(readValue: readTimelinePrice) num price, bool isClosed, String? label
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
@override @pragma('vm:prefer-inline') $Res call({Object? ruleId = null,Object? startMinute = null,Object? endMinute = null,Object? startTime = null,Object? endTime = null,Object? price = null,Object? isClosed = null,Object? label = freezed,}) {
  return _then(_UnitPricing(
ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PricingTimeline {

@JsonKey(readValue: readTimelineSegments) List<UnitPricing> get timeline;@JsonKey(readValue: readPricingConfigId) String get pricingConfigId;
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
@JsonKey(readValue: readTimelineSegments) List<UnitPricing> timeline,@JsonKey(readValue: readPricingConfigId) String pricingConfigId
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: readTimelineSegments)  List<UnitPricing> timeline, @JsonKey(readValue: readPricingConfigId)  String pricingConfigId)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: readTimelineSegments)  List<UnitPricing> timeline, @JsonKey(readValue: readPricingConfigId)  String pricingConfigId)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: readTimelineSegments)  List<UnitPricing> timeline, @JsonKey(readValue: readPricingConfigId)  String pricingConfigId)?  $default,) {final _that = this;
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
  const _PricingTimeline({@JsonKey(readValue: readTimelineSegments) final  List<UnitPricing> timeline = const [], @JsonKey(readValue: readPricingConfigId) this.pricingConfigId = ''}): _timeline = timeline;
  factory _PricingTimeline.fromJson(Map<String, dynamic> json) => _$PricingTimelineFromJson(json);

 final  List<UnitPricing> _timeline;
@override@JsonKey(readValue: readTimelineSegments) List<UnitPricing> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}

@override@JsonKey(readValue: readPricingConfigId) final  String pricingConfigId;

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
@JsonKey(readValue: readTimelineSegments) List<UnitPricing> timeline,@JsonKey(readValue: readPricingConfigId) String pricingConfigId
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

 String get id; String get name; num get price; String get kind; String get status; String? get assetType; String? get assetCode; DateTime? get activeAt; DateTime? get expiresAt; Map<String, dynamic>? get metadata; DateTime? get createdAt; DateTime? get updatedAt;@JsonKey(readValue: readIsArchived) bool get isArchived;
/// Create a copy of BusinessItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessItemCopyWith<BusinessItem> get copyWith => _$BusinessItemCopyWithImpl<BusinessItem>(this as BusinessItem, _$identity);

  /// Serializes this BusinessItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.status, status) || other.status == status)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,kind,status,assetType,assetCode,activeAt,expiresAt,const DeepCollectionEquality().hash(metadata),createdAt,updatedAt,isArchived);

@override
String toString() {
  return 'BusinessItem(id: $id, name: $name, price: $price, kind: $kind, status: $status, assetType: $assetType, assetCode: $assetCode, activeAt: $activeAt, expiresAt: $expiresAt, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class $BusinessItemCopyWith<$Res>  {
  factory $BusinessItemCopyWith(BusinessItem value, $Res Function(BusinessItem) _then) = _$BusinessItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, num price, String kind, String status, String? assetType, String? assetCode, DateTime? activeAt, DateTime? expiresAt, Map<String, dynamic>? metadata, DateTime? createdAt, DateTime? updatedAt,@JsonKey(readValue: readIsArchived) bool isArchived
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? price = null,Object? kind = null,Object? status = null,Object? assetType = freezed,Object? assetCode = freezed,Object? activeAt = freezed,Object? expiresAt = freezed,Object? metadata = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isArchived = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,assetType: freezed == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String?,assetCode: freezed == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String?,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  num price,  String kind,  String status,  String? assetType,  String? assetCode,  DateTime? activeAt,  DateTime? expiresAt,  Map<String, dynamic>? metadata,  DateTime? createdAt,  DateTime? updatedAt, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessItem() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.kind,_that.status,_that.assetType,_that.assetCode,_that.activeAt,_that.expiresAt,_that.metadata,_that.createdAt,_that.updatedAt,_that.isArchived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  num price,  String kind,  String status,  String? assetType,  String? assetCode,  DateTime? activeAt,  DateTime? expiresAt,  Map<String, dynamic>? metadata,  DateTime? createdAt,  DateTime? updatedAt, @JsonKey(readValue: readIsArchived)  bool isArchived)  $default,) {final _that = this;
switch (_that) {
case _BusinessItem():
return $default(_that.id,_that.name,_that.price,_that.kind,_that.status,_that.assetType,_that.assetCode,_that.activeAt,_that.expiresAt,_that.metadata,_that.createdAt,_that.updatedAt,_that.isArchived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  num price,  String kind,  String status,  String? assetType,  String? assetCode,  DateTime? activeAt,  DateTime? expiresAt,  Map<String, dynamic>? metadata,  DateTime? createdAt,  DateTime? updatedAt, @JsonKey(readValue: readIsArchived)  bool isArchived)?  $default,) {final _that = this;
switch (_that) {
case _BusinessItem() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.kind,_that.status,_that.assetType,_that.assetCode,_that.activeAt,_that.expiresAt,_that.metadata,_that.createdAt,_that.updatedAt,_that.isArchived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessItem implements BusinessItem {
  const _BusinessItem({required this.id, required this.name, required this.price, required this.kind, this.status = 'active', this.assetType, this.assetCode, this.activeAt, this.expiresAt, final  Map<String, dynamic>? metadata, this.createdAt, this.updatedAt, @JsonKey(readValue: readIsArchived) this.isArchived = false}): _metadata = metadata;
  factory _BusinessItem.fromJson(Map<String, dynamic> json) => _$BusinessItemFromJson(json);

@override final  String id;
@override final  String name;
@override final  num price;
@override final  String kind;
@override@JsonKey() final  String status;
@override final  String? assetType;
@override final  String? assetCode;
@override final  DateTime? activeAt;
@override final  DateTime? expiresAt;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.status, status) || other.status == status)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.activeAt, activeAt) || other.activeAt == activeAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,kind,status,assetType,assetCode,activeAt,expiresAt,const DeepCollectionEquality().hash(_metadata),createdAt,updatedAt,isArchived);

@override
String toString() {
  return 'BusinessItem(id: $id, name: $name, price: $price, kind: $kind, status: $status, assetType: $assetType, assetCode: $assetCode, activeAt: $activeAt, expiresAt: $expiresAt, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class _$BusinessItemCopyWith<$Res> implements $BusinessItemCopyWith<$Res> {
  factory _$BusinessItemCopyWith(_BusinessItem value, $Res Function(_BusinessItem) _then) = __$BusinessItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, num price, String kind, String status, String? assetType, String? assetCode, DateTime? activeAt, DateTime? expiresAt, Map<String, dynamic>? metadata, DateTime? createdAt, DateTime? updatedAt,@JsonKey(readValue: readIsArchived) bool isArchived
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? price = null,Object? kind = null,Object? status = null,Object? assetType = freezed,Object? assetCode = freezed,Object? activeAt = freezed,Object? expiresAt = freezed,Object? metadata = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isArchived = null,}) {
  return _then(_BusinessItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,assetType: freezed == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String?,assetCode: freezed == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String?,activeAt: freezed == activeAt ? _self.activeAt : activeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$BusinessItemOrder {

 String get id; String get playerId;@JsonKey(readValue: readItemId) String get itemId;@JsonKey(readValue: readItemName) String get itemName; String get businessItemKind; num get price; String get status; DateTime get createdAt; String? get sessionId; String? get assetType; String? get assetCode; Map<String, dynamic>? get metadata; DateTime? get updatedAt; DateTime? get fulfilledAt; DateTime? get cancelledAt;
/// Create a copy of BusinessItemOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessItemOrderCopyWith<BusinessItemOrder> get copyWith => _$BusinessItemOrderCopyWithImpl<BusinessItemOrder>(this as BusinessItemOrder, _$identity);

  /// Serializes this BusinessItemOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessItemOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.businessItemKind, businessItemKind) || other.businessItemKind == businessItemKind)&&(identical(other.price, price) || other.price == price)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.fulfilledAt, fulfilledAt) || other.fulfilledAt == fulfilledAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,playerId,itemId,itemName,businessItemKind,price,status,createdAt,sessionId,assetType,assetCode,const DeepCollectionEquality().hash(metadata),updatedAt,fulfilledAt,cancelledAt);

@override
String toString() {
  return 'BusinessItemOrder(id: $id, playerId: $playerId, itemId: $itemId, itemName: $itemName, businessItemKind: $businessItemKind, price: $price, status: $status, createdAt: $createdAt, sessionId: $sessionId, assetType: $assetType, assetCode: $assetCode, metadata: $metadata, updatedAt: $updatedAt, fulfilledAt: $fulfilledAt, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class $BusinessItemOrderCopyWith<$Res>  {
  factory $BusinessItemOrderCopyWith(BusinessItemOrder value, $Res Function(BusinessItemOrder) _then) = _$BusinessItemOrderCopyWithImpl;
@useResult
$Res call({
 String id, String playerId,@JsonKey(readValue: readItemId) String itemId,@JsonKey(readValue: readItemName) String itemName, String businessItemKind, num price, String status, DateTime createdAt, String? sessionId, String? assetType, String? assetCode, Map<String, dynamic>? metadata, DateTime? updatedAt, DateTime? fulfilledAt, DateTime? cancelledAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playerId = null,Object? itemId = null,Object? itemName = null,Object? businessItemKind = null,Object? price = null,Object? status = null,Object? createdAt = null,Object? sessionId = freezed,Object? assetType = freezed,Object? assetCode = freezed,Object? metadata = freezed,Object? updatedAt = freezed,Object? fulfilledAt = freezed,Object? cancelledAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,businessItemKind: null == businessItemKind ? _self.businessItemKind : businessItemKind // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,assetType: freezed == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String?,assetCode: freezed == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fulfilledAt: freezed == fulfilledAt ? _self.fulfilledAt : fulfilledAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String playerId, @JsonKey(readValue: readItemId)  String itemId, @JsonKey(readValue: readItemName)  String itemName,  String businessItemKind,  num price,  String status,  DateTime createdAt,  String? sessionId,  String? assetType,  String? assetCode,  Map<String, dynamic>? metadata,  DateTime? updatedAt,  DateTime? fulfilledAt,  DateTime? cancelledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessItemOrder() when $default != null:
return $default(_that.id,_that.playerId,_that.itemId,_that.itemName,_that.businessItemKind,_that.price,_that.status,_that.createdAt,_that.sessionId,_that.assetType,_that.assetCode,_that.metadata,_that.updatedAt,_that.fulfilledAt,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String playerId, @JsonKey(readValue: readItemId)  String itemId, @JsonKey(readValue: readItemName)  String itemName,  String businessItemKind,  num price,  String status,  DateTime createdAt,  String? sessionId,  String? assetType,  String? assetCode,  Map<String, dynamic>? metadata,  DateTime? updatedAt,  DateTime? fulfilledAt,  DateTime? cancelledAt)  $default,) {final _that = this;
switch (_that) {
case _BusinessItemOrder():
return $default(_that.id,_that.playerId,_that.itemId,_that.itemName,_that.businessItemKind,_that.price,_that.status,_that.createdAt,_that.sessionId,_that.assetType,_that.assetCode,_that.metadata,_that.updatedAt,_that.fulfilledAt,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String playerId, @JsonKey(readValue: readItemId)  String itemId, @JsonKey(readValue: readItemName)  String itemName,  String businessItemKind,  num price,  String status,  DateTime createdAt,  String? sessionId,  String? assetType,  String? assetCode,  Map<String, dynamic>? metadata,  DateTime? updatedAt,  DateTime? fulfilledAt,  DateTime? cancelledAt)?  $default,) {final _that = this;
switch (_that) {
case _BusinessItemOrder() when $default != null:
return $default(_that.id,_that.playerId,_that.itemId,_that.itemName,_that.businessItemKind,_that.price,_that.status,_that.createdAt,_that.sessionId,_that.assetType,_that.assetCode,_that.metadata,_that.updatedAt,_that.fulfilledAt,_that.cancelledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessItemOrder implements BusinessItemOrder {
  const _BusinessItemOrder({required this.id, required this.playerId, @JsonKey(readValue: readItemId) required this.itemId, @JsonKey(readValue: readItemName) required this.itemName, this.businessItemKind = '', required this.price, required this.status, required this.createdAt, this.sessionId, this.assetType, this.assetCode, final  Map<String, dynamic>? metadata, this.updatedAt, this.fulfilledAt, this.cancelledAt}): _metadata = metadata;
  factory _BusinessItemOrder.fromJson(Map<String, dynamic> json) => _$BusinessItemOrderFromJson(json);

@override final  String id;
@override final  String playerId;
@override@JsonKey(readValue: readItemId) final  String itemId;
@override@JsonKey(readValue: readItemName) final  String itemName;
@override@JsonKey() final  String businessItemKind;
@override final  num price;
@override final  String status;
@override final  DateTime createdAt;
@override final  String? sessionId;
@override final  String? assetType;
@override final  String? assetCode;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  DateTime? updatedAt;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessItemOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.businessItemKind, businessItemKind) || other.businessItemKind == businessItemKind)&&(identical(other.price, price) || other.price == price)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.fulfilledAt, fulfilledAt) || other.fulfilledAt == fulfilledAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,playerId,itemId,itemName,businessItemKind,price,status,createdAt,sessionId,assetType,assetCode,const DeepCollectionEquality().hash(_metadata),updatedAt,fulfilledAt,cancelledAt);

@override
String toString() {
  return 'BusinessItemOrder(id: $id, playerId: $playerId, itemId: $itemId, itemName: $itemName, businessItemKind: $businessItemKind, price: $price, status: $status, createdAt: $createdAt, sessionId: $sessionId, assetType: $assetType, assetCode: $assetCode, metadata: $metadata, updatedAt: $updatedAt, fulfilledAt: $fulfilledAt, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class _$BusinessItemOrderCopyWith<$Res> implements $BusinessItemOrderCopyWith<$Res> {
  factory _$BusinessItemOrderCopyWith(_BusinessItemOrder value, $Res Function(_BusinessItemOrder) _then) = __$BusinessItemOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String playerId,@JsonKey(readValue: readItemId) String itemId,@JsonKey(readValue: readItemName) String itemName, String businessItemKind, num price, String status, DateTime createdAt, String? sessionId, String? assetType, String? assetCode, Map<String, dynamic>? metadata, DateTime? updatedAt, DateTime? fulfilledAt, DateTime? cancelledAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playerId = null,Object? itemId = null,Object? itemName = null,Object? businessItemKind = null,Object? price = null,Object? status = null,Object? createdAt = null,Object? sessionId = freezed,Object? assetType = freezed,Object? assetCode = freezed,Object? metadata = freezed,Object? updatedAt = freezed,Object? fulfilledAt = freezed,Object? cancelledAt = freezed,}) {
  return _then(_BusinessItemOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,businessItemKind: null == businessItemKind ? _self.businessItemKind : businessItemKind // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,assetType: freezed == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as String?,assetCode: freezed == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fulfilledAt: freezed == fulfilledAt ? _self.fulfilledAt : fulfilledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$DeviceState {

 String get deviceId; String get label; String get type;@JsonKey(readValue: readTargetKind) String get targetKind; String? get executorKind; String get status; String? get state; Map<String, dynamic>? get metadata; DateTime get reportedAt; String get reportedBy;
/// Create a copy of DeviceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceStateCopyWith<DeviceState> get copyWith => _$DeviceStateCopyWithImpl<DeviceState>(this as DeviceState, _$identity);

  /// Serializes this DeviceState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceState&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.targetKind, targetKind) || other.targetKind == targetKind)&&(identical(other.executorKind, executorKind) || other.executorKind == executorKind)&&(identical(other.status, status) || other.status == status)&&(identical(other.state, state) || other.state == state)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.reportedBy, reportedBy) || other.reportedBy == reportedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,label,type,targetKind,executorKind,status,state,const DeepCollectionEquality().hash(metadata),reportedAt,reportedBy);

@override
String toString() {
  return 'DeviceState(deviceId: $deviceId, label: $label, type: $type, targetKind: $targetKind, executorKind: $executorKind, status: $status, state: $state, metadata: $metadata, reportedAt: $reportedAt, reportedBy: $reportedBy)';
}


}

/// @nodoc
abstract mixin class $DeviceStateCopyWith<$Res>  {
  factory $DeviceStateCopyWith(DeviceState value, $Res Function(DeviceState) _then) = _$DeviceStateCopyWithImpl;
@useResult
$Res call({
 String deviceId, String label, String type,@JsonKey(readValue: readTargetKind) String targetKind, String? executorKind, String status, String? state, Map<String, dynamic>? metadata, DateTime reportedAt, String reportedBy
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
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? label = null,Object? type = null,Object? targetKind = null,Object? executorKind = freezed,Object? status = null,Object? state = freezed,Object? metadata = freezed,Object? reportedAt = null,Object? reportedBy = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,targetKind: null == targetKind ? _self.targetKind : targetKind // ignore: cast_nullable_to_non_nullable
as String,executorKind: freezed == executorKind ? _self.executorKind : executorKind // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  String label,  String type, @JsonKey(readValue: readTargetKind)  String targetKind,  String? executorKind,  String status,  String? state,  Map<String, dynamic>? metadata,  DateTime reportedAt,  String reportedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceState() when $default != null:
return $default(_that.deviceId,_that.label,_that.type,_that.targetKind,_that.executorKind,_that.status,_that.state,_that.metadata,_that.reportedAt,_that.reportedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  String label,  String type, @JsonKey(readValue: readTargetKind)  String targetKind,  String? executorKind,  String status,  String? state,  Map<String, dynamic>? metadata,  DateTime reportedAt,  String reportedBy)  $default,) {final _that = this;
switch (_that) {
case _DeviceState():
return $default(_that.deviceId,_that.label,_that.type,_that.targetKind,_that.executorKind,_that.status,_that.state,_that.metadata,_that.reportedAt,_that.reportedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  String label,  String type, @JsonKey(readValue: readTargetKind)  String targetKind,  String? executorKind,  String status,  String? state,  Map<String, dynamic>? metadata,  DateTime reportedAt,  String reportedBy)?  $default,) {final _that = this;
switch (_that) {
case _DeviceState() when $default != null:
return $default(_that.deviceId,_that.label,_that.type,_that.targetKind,_that.executorKind,_that.status,_that.state,_that.metadata,_that.reportedAt,_that.reportedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceState implements DeviceState {
  const _DeviceState({required this.deviceId, required this.label, required this.type, @JsonKey(readValue: readTargetKind) this.targetKind = 'facility', this.executorKind, required this.status, this.state, final  Map<String, dynamic>? metadata, required this.reportedAt, required this.reportedBy}): _metadata = metadata;
  factory _DeviceState.fromJson(Map<String, dynamic> json) => _$DeviceStateFromJson(json);

@override final  String deviceId;
@override final  String label;
@override final  String type;
@override@JsonKey(readValue: readTargetKind) final  String targetKind;
@override final  String? executorKind;
@override final  String status;
@override final  String? state;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceState&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.targetKind, targetKind) || other.targetKind == targetKind)&&(identical(other.executorKind, executorKind) || other.executorKind == executorKind)&&(identical(other.status, status) || other.status == status)&&(identical(other.state, state) || other.state == state)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.reportedBy, reportedBy) || other.reportedBy == reportedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,label,type,targetKind,executorKind,status,state,const DeepCollectionEquality().hash(_metadata),reportedAt,reportedBy);

@override
String toString() {
  return 'DeviceState(deviceId: $deviceId, label: $label, type: $type, targetKind: $targetKind, executorKind: $executorKind, status: $status, state: $state, metadata: $metadata, reportedAt: $reportedAt, reportedBy: $reportedBy)';
}


}

/// @nodoc
abstract mixin class _$DeviceStateCopyWith<$Res> implements $DeviceStateCopyWith<$Res> {
  factory _$DeviceStateCopyWith(_DeviceState value, $Res Function(_DeviceState) _then) = __$DeviceStateCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, String label, String type,@JsonKey(readValue: readTargetKind) String targetKind, String? executorKind, String status, String? state, Map<String, dynamic>? metadata, DateTime reportedAt, String reportedBy
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
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? label = null,Object? type = null,Object? targetKind = null,Object? executorKind = freezed,Object? status = null,Object? state = freezed,Object? metadata = freezed,Object? reportedAt = null,Object? reportedBy = null,}) {
  return _then(_DeviceState(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,targetKind: null == targetKind ? _self.targetKind : targetKind // ignore: cast_nullable_to_non_nullable
as String,executorKind: freezed == executorKind ? _self.executorKind : executorKind // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportedBy: null == reportedBy ? _self.reportedBy : reportedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MachineConnection {

 String get machineId; String get status; List<String> get capabilities; DateTime get connectedAt; DateTime get lastSeenAt; DateTime? get disconnectedAt;
/// Create a copy of MachineConnection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MachineConnectionCopyWith<MachineConnection> get copyWith => _$MachineConnectionCopyWithImpl<MachineConnection>(this as MachineConnection, _$identity);

  /// Serializes this MachineConnection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MachineConnection&&(identical(other.machineId, machineId) || other.machineId == machineId)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.capabilities, capabilities)&&(identical(other.connectedAt, connectedAt) || other.connectedAt == connectedAt)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.disconnectedAt, disconnectedAt) || other.disconnectedAt == disconnectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,machineId,status,const DeepCollectionEquality().hash(capabilities),connectedAt,lastSeenAt,disconnectedAt);

@override
String toString() {
  return 'MachineConnection(machineId: $machineId, status: $status, capabilities: $capabilities, connectedAt: $connectedAt, lastSeenAt: $lastSeenAt, disconnectedAt: $disconnectedAt)';
}


}

/// @nodoc
abstract mixin class $MachineConnectionCopyWith<$Res>  {
  factory $MachineConnectionCopyWith(MachineConnection value, $Res Function(MachineConnection) _then) = _$MachineConnectionCopyWithImpl;
@useResult
$Res call({
 String machineId, String status, List<String> capabilities, DateTime connectedAt, DateTime lastSeenAt, DateTime? disconnectedAt
});




}
/// @nodoc
class _$MachineConnectionCopyWithImpl<$Res>
    implements $MachineConnectionCopyWith<$Res> {
  _$MachineConnectionCopyWithImpl(this._self, this._then);

  final MachineConnection _self;
  final $Res Function(MachineConnection) _then;

/// Create a copy of MachineConnection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? machineId = null,Object? status = null,Object? capabilities = null,Object? connectedAt = null,Object? lastSeenAt = null,Object? disconnectedAt = freezed,}) {
  return _then(_self.copyWith(
machineId: null == machineId ? _self.machineId : machineId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,capabilities: null == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<String>,connectedAt: null == connectedAt ? _self.connectedAt : connectedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastSeenAt: null == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,disconnectedAt: freezed == disconnectedAt ? _self.disconnectedAt : disconnectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MachineConnection].
extension MachineConnectionPatterns on MachineConnection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MachineConnection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MachineConnection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MachineConnection value)  $default,){
final _that = this;
switch (_that) {
case _MachineConnection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MachineConnection value)?  $default,){
final _that = this;
switch (_that) {
case _MachineConnection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String machineId,  String status,  List<String> capabilities,  DateTime connectedAt,  DateTime lastSeenAt,  DateTime? disconnectedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MachineConnection() when $default != null:
return $default(_that.machineId,_that.status,_that.capabilities,_that.connectedAt,_that.lastSeenAt,_that.disconnectedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String machineId,  String status,  List<String> capabilities,  DateTime connectedAt,  DateTime lastSeenAt,  DateTime? disconnectedAt)  $default,) {final _that = this;
switch (_that) {
case _MachineConnection():
return $default(_that.machineId,_that.status,_that.capabilities,_that.connectedAt,_that.lastSeenAt,_that.disconnectedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String machineId,  String status,  List<String> capabilities,  DateTime connectedAt,  DateTime lastSeenAt,  DateTime? disconnectedAt)?  $default,) {final _that = this;
switch (_that) {
case _MachineConnection() when $default != null:
return $default(_that.machineId,_that.status,_that.capabilities,_that.connectedAt,_that.lastSeenAt,_that.disconnectedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MachineConnection implements MachineConnection {
  const _MachineConnection({required this.machineId, required this.status, final  List<String> capabilities = const [], required this.connectedAt, required this.lastSeenAt, this.disconnectedAt}): _capabilities = capabilities;
  factory _MachineConnection.fromJson(Map<String, dynamic> json) => _$MachineConnectionFromJson(json);

@override final  String machineId;
@override final  String status;
 final  List<String> _capabilities;
@override@JsonKey() List<String> get capabilities {
  if (_capabilities is EqualUnmodifiableListView) return _capabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_capabilities);
}

@override final  DateTime connectedAt;
@override final  DateTime lastSeenAt;
@override final  DateTime? disconnectedAt;

/// Create a copy of MachineConnection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MachineConnectionCopyWith<_MachineConnection> get copyWith => __$MachineConnectionCopyWithImpl<_MachineConnection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MachineConnectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MachineConnection&&(identical(other.machineId, machineId) || other.machineId == machineId)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._capabilities, _capabilities)&&(identical(other.connectedAt, connectedAt) || other.connectedAt == connectedAt)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.disconnectedAt, disconnectedAt) || other.disconnectedAt == disconnectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,machineId,status,const DeepCollectionEquality().hash(_capabilities),connectedAt,lastSeenAt,disconnectedAt);

@override
String toString() {
  return 'MachineConnection(machineId: $machineId, status: $status, capabilities: $capabilities, connectedAt: $connectedAt, lastSeenAt: $lastSeenAt, disconnectedAt: $disconnectedAt)';
}


}

/// @nodoc
abstract mixin class _$MachineConnectionCopyWith<$Res> implements $MachineConnectionCopyWith<$Res> {
  factory _$MachineConnectionCopyWith(_MachineConnection value, $Res Function(_MachineConnection) _then) = __$MachineConnectionCopyWithImpl;
@override @useResult
$Res call({
 String machineId, String status, List<String> capabilities, DateTime connectedAt, DateTime lastSeenAt, DateTime? disconnectedAt
});




}
/// @nodoc
class __$MachineConnectionCopyWithImpl<$Res>
    implements _$MachineConnectionCopyWith<$Res> {
  __$MachineConnectionCopyWithImpl(this._self, this._then);

  final _MachineConnection _self;
  final $Res Function(_MachineConnection) _then;

/// Create a copy of MachineConnection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? machineId = null,Object? status = null,Object? capabilities = null,Object? connectedAt = null,Object? lastSeenAt = null,Object? disconnectedAt = freezed,}) {
  return _then(_MachineConnection(
machineId: null == machineId ? _self.machineId : machineId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,capabilities: null == capabilities ? _self._capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<String>,connectedAt: null == connectedAt ? _self.connectedAt : connectedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastSeenAt: null == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,disconnectedAt: freezed == disconnectedAt ? _self.disconnectedAt : disconnectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$DeviceCommand {

 String get id;@JsonKey(readValue: readCommandType) String get commandType; String get deviceId;@JsonKey(readValue: readTargetKind) String get targetKind; String? get executorKind;@JsonKey(readValue: readRequester) String get requester; String? get playerId; String? get staffId; String get status; Map<String, dynamic>? get payload;@JsonKey(readValue: readCreatedAt) DateTime get createdAt; DateTime? get ackedAt; DateTime? get expiredAt;
/// Create a copy of DeviceCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceCommandCopyWith<DeviceCommand> get copyWith => _$DeviceCommandCopyWithImpl<DeviceCommand>(this as DeviceCommand, _$identity);

  /// Serializes this DeviceCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.commandType, commandType) || other.commandType == commandType)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.targetKind, targetKind) || other.targetKind == targetKind)&&(identical(other.executorKind, executorKind) || other.executorKind == executorKind)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.payload, payload)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.ackedAt, ackedAt) || other.ackedAt == ackedAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,commandType,deviceId,targetKind,executorKind,requester,playerId,staffId,status,const DeepCollectionEquality().hash(payload),createdAt,ackedAt,expiredAt);

@override
String toString() {
  return 'DeviceCommand(id: $id, commandType: $commandType, deviceId: $deviceId, targetKind: $targetKind, executorKind: $executorKind, requester: $requester, playerId: $playerId, staffId: $staffId, status: $status, payload: $payload, createdAt: $createdAt, ackedAt: $ackedAt, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class $DeviceCommandCopyWith<$Res>  {
  factory $DeviceCommandCopyWith(DeviceCommand value, $Res Function(DeviceCommand) _then) = _$DeviceCommandCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(readValue: readCommandType) String commandType, String deviceId,@JsonKey(readValue: readTargetKind) String targetKind, String? executorKind,@JsonKey(readValue: readRequester) String requester, String? playerId, String? staffId, String status, Map<String, dynamic>? payload,@JsonKey(readValue: readCreatedAt) DateTime createdAt, DateTime? ackedAt, DateTime? expiredAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? commandType = null,Object? deviceId = null,Object? targetKind = null,Object? executorKind = freezed,Object? requester = null,Object? playerId = freezed,Object? staffId = freezed,Object? status = null,Object? payload = freezed,Object? createdAt = null,Object? ackedAt = freezed,Object? expiredAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,commandType: null == commandType ? _self.commandType : commandType // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,targetKind: null == targetKind ? _self.targetKind : targetKind // ignore: cast_nullable_to_non_nullable
as String,executorKind: freezed == executorKind ? _self.executorKind : executorKind // ignore: cast_nullable_to_non_nullable
as String?,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,ackedAt: freezed == ackedAt ? _self.ackedAt : ackedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(readValue: readCommandType)  String commandType,  String deviceId, @JsonKey(readValue: readTargetKind)  String targetKind,  String? executorKind, @JsonKey(readValue: readRequester)  String requester,  String? playerId,  String? staffId,  String status,  Map<String, dynamic>? payload, @JsonKey(readValue: readCreatedAt)  DateTime createdAt,  DateTime? ackedAt,  DateTime? expiredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceCommand() when $default != null:
return $default(_that.id,_that.commandType,_that.deviceId,_that.targetKind,_that.executorKind,_that.requester,_that.playerId,_that.staffId,_that.status,_that.payload,_that.createdAt,_that.ackedAt,_that.expiredAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(readValue: readCommandType)  String commandType,  String deviceId, @JsonKey(readValue: readTargetKind)  String targetKind,  String? executorKind, @JsonKey(readValue: readRequester)  String requester,  String? playerId,  String? staffId,  String status,  Map<String, dynamic>? payload, @JsonKey(readValue: readCreatedAt)  DateTime createdAt,  DateTime? ackedAt,  DateTime? expiredAt)  $default,) {final _that = this;
switch (_that) {
case _DeviceCommand():
return $default(_that.id,_that.commandType,_that.deviceId,_that.targetKind,_that.executorKind,_that.requester,_that.playerId,_that.staffId,_that.status,_that.payload,_that.createdAt,_that.ackedAt,_that.expiredAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(readValue: readCommandType)  String commandType,  String deviceId, @JsonKey(readValue: readTargetKind)  String targetKind,  String? executorKind, @JsonKey(readValue: readRequester)  String requester,  String? playerId,  String? staffId,  String status,  Map<String, dynamic>? payload, @JsonKey(readValue: readCreatedAt)  DateTime createdAt,  DateTime? ackedAt,  DateTime? expiredAt)?  $default,) {final _that = this;
switch (_that) {
case _DeviceCommand() when $default != null:
return $default(_that.id,_that.commandType,_that.deviceId,_that.targetKind,_that.executorKind,_that.requester,_that.playerId,_that.staffId,_that.status,_that.payload,_that.createdAt,_that.ackedAt,_that.expiredAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceCommand implements DeviceCommand {
  const _DeviceCommand({required this.id, @JsonKey(readValue: readCommandType) required this.commandType, required this.deviceId, @JsonKey(readValue: readTargetKind) this.targetKind = 'facility', this.executorKind, @JsonKey(readValue: readRequester) required this.requester, this.playerId, this.staffId, required this.status, final  Map<String, dynamic>? payload, @JsonKey(readValue: readCreatedAt) required this.createdAt, this.ackedAt, this.expiredAt}): _payload = payload;
  factory _DeviceCommand.fromJson(Map<String, dynamic> json) => _$DeviceCommandFromJson(json);

@override final  String id;
@override@JsonKey(readValue: readCommandType) final  String commandType;
@override final  String deviceId;
@override@JsonKey(readValue: readTargetKind) final  String targetKind;
@override final  String? executorKind;
@override@JsonKey(readValue: readRequester) final  String requester;
@override final  String? playerId;
@override final  String? staffId;
@override final  String status;
 final  Map<String, dynamic>? _payload;
@override Map<String, dynamic>? get payload {
  final value = _payload;
  if (value == null) return null;
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(readValue: readCreatedAt) final  DateTime createdAt;
@override final  DateTime? ackedAt;
@override final  DateTime? expiredAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.commandType, commandType) || other.commandType == commandType)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.targetKind, targetKind) || other.targetKind == targetKind)&&(identical(other.executorKind, executorKind) || other.executorKind == executorKind)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._payload, _payload)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.ackedAt, ackedAt) || other.ackedAt == ackedAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,commandType,deviceId,targetKind,executorKind,requester,playerId,staffId,status,const DeepCollectionEquality().hash(_payload),createdAt,ackedAt,expiredAt);

@override
String toString() {
  return 'DeviceCommand(id: $id, commandType: $commandType, deviceId: $deviceId, targetKind: $targetKind, executorKind: $executorKind, requester: $requester, playerId: $playerId, staffId: $staffId, status: $status, payload: $payload, createdAt: $createdAt, ackedAt: $ackedAt, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class _$DeviceCommandCopyWith<$Res> implements $DeviceCommandCopyWith<$Res> {
  factory _$DeviceCommandCopyWith(_DeviceCommand value, $Res Function(_DeviceCommand) _then) = __$DeviceCommandCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(readValue: readCommandType) String commandType, String deviceId,@JsonKey(readValue: readTargetKind) String targetKind, String? executorKind,@JsonKey(readValue: readRequester) String requester, String? playerId, String? staffId, String status, Map<String, dynamic>? payload,@JsonKey(readValue: readCreatedAt) DateTime createdAt, DateTime? ackedAt, DateTime? expiredAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? commandType = null,Object? deviceId = null,Object? targetKind = null,Object? executorKind = freezed,Object? requester = null,Object? playerId = freezed,Object? staffId = freezed,Object? status = null,Object? payload = freezed,Object? createdAt = null,Object? ackedAt = freezed,Object? expiredAt = freezed,}) {
  return _then(_DeviceCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,commandType: null == commandType ? _self.commandType : commandType // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,targetKind: null == targetKind ? _self.targetKind : targetKind // ignore: cast_nullable_to_non_nullable
as String,executorKind: freezed == executorKind ? _self.executorKind : executorKind // ignore: cast_nullable_to_non_nullable
as String?,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,ackedAt: freezed == ackedAt ? _self.ackedAt : ackedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
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

 String get playerId;@JsonKey(readValue: readDisplayName) String get displayName; int? get durationMinutes; num get subtotal; num get total; DateTime get settledAt;
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
 String playerId,@JsonKey(readValue: readDisplayName) String displayName, int? durationMinutes, num subtotal, num total, DateTime settledAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? displayName = null,Object? durationMinutes = freezed,Object? subtotal = null,Object? total = null,Object? settledAt = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId, @JsonKey(readValue: readDisplayName)  String displayName,  int? durationMinutes,  num subtotal,  num total,  DateTime settledAt)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId, @JsonKey(readValue: readDisplayName)  String displayName,  int? durationMinutes,  num subtotal,  num total,  DateTime settledAt)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId, @JsonKey(readValue: readDisplayName)  String displayName,  int? durationMinutes,  num subtotal,  num total,  DateTime settledAt)?  $default,) {final _that = this;
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
  const _SettlementReportRow({required this.playerId, @JsonKey(readValue: readDisplayName) required this.displayName, this.durationMinutes, required this.subtotal, required this.total, required this.settledAt});
  factory _SettlementReportRow.fromJson(Map<String, dynamic> json) => _$SettlementReportRowFromJson(json);

@override final  String playerId;
@override@JsonKey(readValue: readDisplayName) final  String displayName;
@override final  int? durationMinutes;
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
 String playerId,@JsonKey(readValue: readDisplayName) String displayName, int? durationMinutes, num subtotal, num total, DateTime settledAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? displayName = null,Object? durationMinutes = freezed,Object? subtotal = null,Object? total = null,Object? settledAt = null,}) {
  return _then(_SettlementReportRow(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
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
  const _ApiToken({required this.id, required this.label, @JsonKey(includeToJson: false) this.token, required this.createdAt, this.role = 'integration', this.tokenPrefix = '', @JsonKey(readValue: readIsRevoked) this.isRevoked = false});
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
