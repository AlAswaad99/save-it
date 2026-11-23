// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'core_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Profile {

 String get id; UserRole get role; String? get fullName; String? get email; String? get phone; DateTime? get termsAcceptedAt; CustomerStatus get status; DateTime? get statusChangedAt; DateTime? get suspensionLiftedAt; bool get isActive; DateTime get createdAt;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Profile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.termsAcceptedAt, _this.termsAcceptedAt) || other.termsAcceptedAt == _this.termsAcceptedAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.statusChangedAt, _this.statusChangedAt) || other.statusChangedAt == _this.statusChangedAt)&&(identical(other.suspensionLiftedAt, _this.suspensionLiftedAt) || other.suspensionLiftedAt == _this.suspensionLiftedAt)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Profile;
  return Object.hash(runtimeType,_this.id,_this.role,_this.fullName,_this.email,_this.phone,_this.termsAcceptedAt,_this.status,_this.statusChangedAt,_this.suspensionLiftedAt,_this.isActive,_this.createdAt);
}

@override
String toString() {
  final _this = this as Profile;
  return 'Profile(id: ${_this.id}, role: ${_this.role}, fullName: ${_this.fullName}, email: ${_this.email}, phone: ${_this.phone}, termsAcceptedAt: ${_this.termsAcceptedAt}, status: ${_this.status}, statusChangedAt: ${_this.statusChangedAt}, suspensionLiftedAt: ${_this.suspensionLiftedAt}, isActive: ${_this.isActive}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 String id, UserRole role, String? fullName, String? email, String? phone, DateTime? termsAcceptedAt, CustomerStatus status, DateTime? statusChangedAt, DateTime? suspensionLiftedAt, bool isActive, DateTime createdAt
});




}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = null,Object? fullName = freezed,Object? email = freezed,Object? phone = freezed,Object? termsAcceptedAt = freezed,Object? status = null,Object? statusChangedAt = freezed,Object? suspensionLiftedAt = freezed,Object? isActive = null,Object? createdAt = null,}) {
  return _then(Profile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,termsAcceptedAt: freezed == termsAcceptedAt ? _self.termsAcceptedAt : termsAcceptedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CustomerStatus,statusChangedAt: freezed == statusChangedAt ? _self.statusChangedAt : statusChangedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,suspensionLiftedAt: freezed == suspensionLiftedAt ? _self.suspensionLiftedAt : suspensionLiftedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Profile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Profile value)  $default,){
final _that = this;
switch (_that) {
case _Profile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Profile value)?  $default,){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  UserRole role,  String? fullName,  String? email,  String? phone,  DateTime? termsAcceptedAt,  CustomerStatus status,  DateTime? statusChangedAt,  DateTime? suspensionLiftedAt,  bool isActive,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.role,_that.fullName,_that.email,_that.phone,_that.termsAcceptedAt,_that.status,_that.statusChangedAt,_that.suspensionLiftedAt,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  UserRole role,  String? fullName,  String? email,  String? phone,  DateTime? termsAcceptedAt,  CustomerStatus status,  DateTime? statusChangedAt,  DateTime? suspensionLiftedAt,  bool isActive,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Profile():
return $default(_that.id,_that.role,_that.fullName,_that.email,_that.phone,_that.termsAcceptedAt,_that.status,_that.statusChangedAt,_that.suspensionLiftedAt,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  UserRole role,  String? fullName,  String? email,  String? phone,  DateTime? termsAcceptedAt,  CustomerStatus status,  DateTime? statusChangedAt,  DateTime? suspensionLiftedAt,  bool isActive,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.role,_that.fullName,_that.email,_that.phone,_that.termsAcceptedAt,_that.status,_that.statusChangedAt,_that.suspensionLiftedAt,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Profile implements Profile {
  const _Profile({required this.id, required this.role, this.fullName, this.email, this.phone, this.termsAcceptedAt, required this.status, this.statusChangedAt, this.suspensionLiftedAt, required this.isActive, required this.createdAt});
  factory _Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

@override final  String id;
@override final  UserRole role;
@override final  String? fullName;
@override final  String? email;
@override final  String? phone;
@override final  DateTime? termsAcceptedAt;
@override final  CustomerStatus status;
@override final  DateTime? statusChangedAt;
@override final  DateTime? suspensionLiftedAt;
@override final  bool isActive;
@override final  DateTime createdAt;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCopyWith<_Profile> get copyWith => __$ProfileCopyWithImpl<_Profile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.termsAcceptedAt, termsAcceptedAt) || other.termsAcceptedAt == termsAcceptedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusChangedAt, statusChangedAt) || other.statusChangedAt == statusChangedAt)&&(identical(other.suspensionLiftedAt, suspensionLiftedAt) || other.suspensionLiftedAt == suspensionLiftedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,role,fullName,email,phone,termsAcceptedAt,status,statusChangedAt,suspensionLiftedAt,isActive,createdAt);
}

@override
String toString() {
    return 'Profile(id: $id, role: $role, fullName: $fullName, email: $email, phone: $phone, termsAcceptedAt: $termsAcceptedAt, status: $status, statusChangedAt: $statusChangedAt, suspensionLiftedAt: $suspensionLiftedAt, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) = __$ProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, UserRole role, String? fullName, String? email, String? phone, DateTime? termsAcceptedAt, CustomerStatus status, DateTime? statusChangedAt, DateTime? suspensionLiftedAt, bool isActive, DateTime createdAt
});




}
/// @nodoc
class __$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = null,Object? fullName = freezed,Object? email = freezed,Object? phone = freezed,Object? termsAcceptedAt = freezed,Object? status = null,Object? statusChangedAt = freezed,Object? suspensionLiftedAt = freezed,Object? isActive = null,Object? createdAt = null,}) {
  return _then(_Profile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,termsAcceptedAt: freezed == termsAcceptedAt ? _self.termsAcceptedAt : termsAcceptedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CustomerStatus,statusChangedAt: freezed == statusChangedAt ? _self.statusChangedAt : statusChangedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,suspensionLiftedAt: freezed == suspensionLiftedAt ? _self.suspensionLiftedAt : suspensionLiftedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$Area {

 int get id; String get name;@JsonKey(fromJson: geoPointRequiredFromJson, toJson: geoPointRequiredToJson) GeoPoint get location; int get sort;
/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaCopyWith<Area> get copyWith => _$AreaCopyWithImpl<Area>(this as Area, _$identity);

  /// Serializes this Area to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Area;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Area&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.sort, _this.sort) || other.sort == _this.sort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Area;
  return Object.hash(runtimeType,_this.id,_this.name,_this.location,_this.sort);
}

@override
String toString() {
  final _this = this as Area;
  return 'Area(id: ${_this.id}, name: ${_this.name}, location: ${_this.location}, sort: ${_this.sort})';
}


}

/// @nodoc
abstract mixin class $AreaCopyWith<$Res>  {
  factory $AreaCopyWith(Area value, $Res Function(Area) _then) = _$AreaCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(fromJson: geoPointRequiredFromJson, toJson: geoPointRequiredToJson) GeoPoint location, int sort
});




}
/// @nodoc
class _$AreaCopyWithImpl<$Res>
    implements $AreaCopyWith<$Res> {
  _$AreaCopyWithImpl(this._self, this._then);

  final Area _self;
  final $Res Function(Area) _then;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? location = null,Object? sort = null,}) {
  return _then(Area(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Area].
extension AreaPatterns on Area {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Area value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Area() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Area value)  $default,){
final _that = this;
switch (_that) {
case _Area():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Area value)?  $default,){
final _that = this;
switch (_that) {
case _Area() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(fromJson: geoPointRequiredFromJson, toJson: geoPointRequiredToJson)  GeoPoint location,  int sort)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Area() when $default != null:
return $default(_that.id,_that.name,_that.location,_that.sort);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(fromJson: geoPointRequiredFromJson, toJson: geoPointRequiredToJson)  GeoPoint location,  int sort)  $default,) {final _that = this;
switch (_that) {
case _Area():
return $default(_that.id,_that.name,_that.location,_that.sort);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(fromJson: geoPointRequiredFromJson, toJson: geoPointRequiredToJson)  GeoPoint location,  int sort)?  $default,) {final _that = this;
switch (_that) {
case _Area() when $default != null:
return $default(_that.id,_that.name,_that.location,_that.sort);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Area implements Area {
  const _Area({required this.id, required this.name, @JsonKey(fromJson: geoPointRequiredFromJson, toJson: geoPointRequiredToJson) required this.location, required this.sort});
  factory _Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(fromJson: geoPointRequiredFromJson, toJson: geoPointRequiredToJson) final  GeoPoint location;
@override final  int sort;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreaCopyWith<_Area> get copyWith => __$AreaCopyWithImpl<_Area>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Area&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.sort, sort) || other.sort == sort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,location,sort);
}

@override
String toString() {
    return 'Area(id: $id, name: $name, location: $location, sort: $sort)';
}


}

/// @nodoc
abstract mixin class _$AreaCopyWith<$Res> implements $AreaCopyWith<$Res> {
  factory _$AreaCopyWith(_Area value, $Res Function(_Area) _then) = __$AreaCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(fromJson: geoPointRequiredFromJson, toJson: geoPointRequiredToJson) GeoPoint location, int sort
});




}
/// @nodoc
class __$AreaCopyWithImpl<$Res>
    implements _$AreaCopyWith<$Res> {
  __$AreaCopyWithImpl(this._self, this._then);

  final _Area _self;
  final $Res Function(_Area) _then;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? location = null,Object? sort = null,}) {
  return _then(_Area(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Restaurant {

 String get id; String get userId; String get name; String? get logoPath; String? get address; String? get placeId;@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson) GeoPoint? get location; String? get phone; String get loginEmail; int get areaId; RestaurantStatus get status; DateTime? get termsAcceptedAt; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantCopyWith<Restaurant> get copyWith => _$RestaurantCopyWithImpl<Restaurant>(this as Restaurant, _$identity);

  /// Serializes this Restaurant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Restaurant;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Restaurant&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.logoPath, _this.logoPath) || other.logoPath == _this.logoPath)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.placeId, _this.placeId) || other.placeId == _this.placeId)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.loginEmail, _this.loginEmail) || other.loginEmail == _this.loginEmail)&&(identical(other.areaId, _this.areaId) || other.areaId == _this.areaId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.termsAcceptedAt, _this.termsAcceptedAt) || other.termsAcceptedAt == _this.termsAcceptedAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Restaurant;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.name,_this.logoPath,_this.address,_this.placeId,_this.location,_this.phone,_this.loginEmail,_this.areaId,_this.status,_this.termsAcceptedAt,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Restaurant;
  return 'Restaurant(id: ${_this.id}, userId: ${_this.userId}, name: ${_this.name}, logoPath: ${_this.logoPath}, address: ${_this.address}, placeId: ${_this.placeId}, location: ${_this.location}, phone: ${_this.phone}, loginEmail: ${_this.loginEmail}, areaId: ${_this.areaId}, status: ${_this.status}, termsAcceptedAt: ${_this.termsAcceptedAt}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $RestaurantCopyWith<$Res>  {
  factory $RestaurantCopyWith(Restaurant value, $Res Function(Restaurant) _then) = _$RestaurantCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String name, String? logoPath, String? address, String? placeId,@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson) GeoPoint? location, String? phone, String loginEmail, int areaId, RestaurantStatus status, DateTime? termsAcceptedAt, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$RestaurantCopyWithImpl<$Res>
    implements $RestaurantCopyWith<$Res> {
  _$RestaurantCopyWithImpl(this._self, this._then);

  final Restaurant _self;
  final $Res Function(Restaurant) _then;

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? logoPath = freezed,Object? address = freezed,Object? placeId = freezed,Object? location = freezed,Object? phone = freezed,Object? loginEmail = null,Object? areaId = null,Object? status = null,Object? termsAcceptedAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Restaurant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoPath: freezed == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,loginEmail: null == loginEmail ? _self.loginEmail : loginEmail // ignore: cast_nullable_to_non_nullable
as String,areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RestaurantStatus,termsAcceptedAt: freezed == termsAcceptedAt ? _self.termsAcceptedAt : termsAcceptedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Restaurant].
extension RestaurantPatterns on Restaurant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Restaurant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Restaurant value)  $default,){
final _that = this;
switch (_that) {
case _Restaurant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Restaurant value)?  $default,){
final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String? logoPath,  String? address,  String? placeId, @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)  GeoPoint? location,  String? phone,  String loginEmail,  int areaId,  RestaurantStatus status,  DateTime? termsAcceptedAt,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.logoPath,_that.address,_that.placeId,_that.location,_that.phone,_that.loginEmail,_that.areaId,_that.status,_that.termsAcceptedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String? logoPath,  String? address,  String? placeId, @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)  GeoPoint? location,  String? phone,  String loginEmail,  int areaId,  RestaurantStatus status,  DateTime? termsAcceptedAt,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Restaurant():
return $default(_that.id,_that.userId,_that.name,_that.logoPath,_that.address,_that.placeId,_that.location,_that.phone,_that.loginEmail,_that.areaId,_that.status,_that.termsAcceptedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String name,  String? logoPath,  String? address,  String? placeId, @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)  GeoPoint? location,  String? phone,  String loginEmail,  int areaId,  RestaurantStatus status,  DateTime? termsAcceptedAt,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Restaurant() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.logoPath,_that.address,_that.placeId,_that.location,_that.phone,_that.loginEmail,_that.areaId,_that.status,_that.termsAcceptedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Restaurant implements Restaurant {
  const _Restaurant({required this.id, required this.userId, required this.name, this.logoPath, this.address, this.placeId, @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson) this.location, this.phone, required this.loginEmail, required this.areaId, required this.status, this.termsAcceptedAt, required this.createdAt, required this.updatedAt});
  factory _Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String name;
@override final  String? logoPath;
@override final  String? address;
@override final  String? placeId;
@override@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson) final  GeoPoint? location;
@override final  String? phone;
@override final  String loginEmail;
@override final  int areaId;
@override final  RestaurantStatus status;
@override final  DateTime? termsAcceptedAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantCopyWith<_Restaurant> get copyWith => __$RestaurantCopyWithImpl<_Restaurant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Restaurant&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoPath, logoPath) || other.logoPath == logoPath)&&(identical(other.address, address) || other.address == address)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.location, location) || other.location == location)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.loginEmail, loginEmail) || other.loginEmail == loginEmail)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.status, status) || other.status == status)&&(identical(other.termsAcceptedAt, termsAcceptedAt) || other.termsAcceptedAt == termsAcceptedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,name,logoPath,address,placeId,location,phone,loginEmail,areaId,status,termsAcceptedAt,createdAt,updatedAt);
}

@override
String toString() {
    return 'Restaurant(id: $id, userId: $userId, name: $name, logoPath: $logoPath, address: $address, placeId: $placeId, location: $location, phone: $phone, loginEmail: $loginEmail, areaId: $areaId, status: $status, termsAcceptedAt: $termsAcceptedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RestaurantCopyWith<$Res> implements $RestaurantCopyWith<$Res> {
  factory _$RestaurantCopyWith(_Restaurant value, $Res Function(_Restaurant) _then) = __$RestaurantCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String name, String? logoPath, String? address, String? placeId,@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson) GeoPoint? location, String? phone, String loginEmail, int areaId, RestaurantStatus status, DateTime? termsAcceptedAt, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$RestaurantCopyWithImpl<$Res>
    implements _$RestaurantCopyWith<$Res> {
  __$RestaurantCopyWithImpl(this._self, this._then);

  final _Restaurant _self;
  final $Res Function(_Restaurant) _then;

/// Create a copy of Restaurant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? logoPath = freezed,Object? address = freezed,Object? placeId = freezed,Object? location = freezed,Object? phone = freezed,Object? loginEmail = null,Object? areaId = null,Object? status = null,Object? termsAcceptedAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Restaurant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoPath: freezed == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,loginEmail: null == loginEmail ? _self.loginEmail : loginEmail // ignore: cast_nullable_to_non_nullable
as String,areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RestaurantStatus,termsAcceptedAt: freezed == termsAcceptedAt ? _self.termsAcceptedAt : termsAcceptedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$OpeningHours {

 String get restaurantId; int get weekday; String? get opensAt; String? get closesAt; bool get isClosed;
/// Create a copy of OpeningHours
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpeningHoursCopyWith<OpeningHours> get copyWith => _$OpeningHoursCopyWithImpl<OpeningHours>(this as OpeningHours, _$identity);

  /// Serializes this OpeningHours to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OpeningHours;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpeningHours&&(identical(other.restaurantId, _this.restaurantId) || other.restaurantId == _this.restaurantId)&&(identical(other.weekday, _this.weekday) || other.weekday == _this.weekday)&&(identical(other.opensAt, _this.opensAt) || other.opensAt == _this.opensAt)&&(identical(other.closesAt, _this.closesAt) || other.closesAt == _this.closesAt)&&(identical(other.isClosed, _this.isClosed) || other.isClosed == _this.isClosed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OpeningHours;
  return Object.hash(runtimeType,_this.restaurantId,_this.weekday,_this.opensAt,_this.closesAt,_this.isClosed);
}

@override
String toString() {
  final _this = this as OpeningHours;
  return 'OpeningHours(restaurantId: ${_this.restaurantId}, weekday: ${_this.weekday}, opensAt: ${_this.opensAt}, closesAt: ${_this.closesAt}, isClosed: ${_this.isClosed})';
}


}

/// @nodoc
abstract mixin class $OpeningHoursCopyWith<$Res>  {
  factory $OpeningHoursCopyWith(OpeningHours value, $Res Function(OpeningHours) _then) = _$OpeningHoursCopyWithImpl;
@useResult
$Res call({
 String restaurantId, int weekday, String? opensAt, String? closesAt, bool isClosed
});




}
/// @nodoc
class _$OpeningHoursCopyWithImpl<$Res>
    implements $OpeningHoursCopyWith<$Res> {
  _$OpeningHoursCopyWithImpl(this._self, this._then);

  final OpeningHours _self;
  final $Res Function(OpeningHours) _then;

/// Create a copy of OpeningHours
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? restaurantId = null,Object? weekday = null,Object? opensAt = freezed,Object? closesAt = freezed,Object? isClosed = null,}) {
  return _then(OpeningHours(
restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,opensAt: freezed == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as String?,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as String?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OpeningHours].
extension OpeningHoursPatterns on OpeningHours {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpeningHours value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpeningHours() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpeningHours value)  $default,){
final _that = this;
switch (_that) {
case _OpeningHours():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpeningHours value)?  $default,){
final _that = this;
switch (_that) {
case _OpeningHours() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String restaurantId,  int weekday,  String? opensAt,  String? closesAt,  bool isClosed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpeningHours() when $default != null:
return $default(_that.restaurantId,_that.weekday,_that.opensAt,_that.closesAt,_that.isClosed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String restaurantId,  int weekday,  String? opensAt,  String? closesAt,  bool isClosed)  $default,) {final _that = this;
switch (_that) {
case _OpeningHours():
return $default(_that.restaurantId,_that.weekday,_that.opensAt,_that.closesAt,_that.isClosed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String restaurantId,  int weekday,  String? opensAt,  String? closesAt,  bool isClosed)?  $default,) {final _that = this;
switch (_that) {
case _OpeningHours() when $default != null:
return $default(_that.restaurantId,_that.weekday,_that.opensAt,_that.closesAt,_that.isClosed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpeningHours implements OpeningHours {
  const _OpeningHours({required this.restaurantId, required this.weekday, this.opensAt, this.closesAt, required this.isClosed});
  factory _OpeningHours.fromJson(Map<String, dynamic> json) => _$OpeningHoursFromJson(json);

@override final  String restaurantId;
@override final  int weekday;
@override final  String? opensAt;
@override final  String? closesAt;
@override final  bool isClosed;

/// Create a copy of OpeningHours
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpeningHoursCopyWith<_OpeningHours> get copyWith => __$OpeningHoursCopyWithImpl<_OpeningHours>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpeningHoursToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpeningHours&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.opensAt, opensAt) || other.opensAt == opensAt)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,restaurantId,weekday,opensAt,closesAt,isClosed);
}

@override
String toString() {
    return 'OpeningHours(restaurantId: $restaurantId, weekday: $weekday, opensAt: $opensAt, closesAt: $closesAt, isClosed: $isClosed)';
}


}

/// @nodoc
abstract mixin class _$OpeningHoursCopyWith<$Res> implements $OpeningHoursCopyWith<$Res> {
  factory _$OpeningHoursCopyWith(_OpeningHours value, $Res Function(_OpeningHours) _then) = __$OpeningHoursCopyWithImpl;
@override @useResult
$Res call({
 String restaurantId, int weekday, String? opensAt, String? closesAt, bool isClosed
});




}
/// @nodoc
class __$OpeningHoursCopyWithImpl<$Res>
    implements _$OpeningHoursCopyWith<$Res> {
  __$OpeningHoursCopyWithImpl(this._self, this._then);

  final _OpeningHours _self;
  final $Res Function(_OpeningHours) _then;

/// Create a copy of OpeningHours
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? restaurantId = null,Object? weekday = null,Object? opensAt = freezed,Object? closesAt = freezed,Object? isClosed = null,}) {
  return _then(_OpeningHours(
restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,opensAt: freezed == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as String?,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as String?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Category {

 int get id; String get name; int get sort;
/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryCopyWith<Category> get copyWith => _$CategoryCopyWithImpl<Category>(this as Category, _$identity);

  /// Serializes this Category to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Category;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Category&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.sort, _this.sort) || other.sort == _this.sort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Category;
  return Object.hash(runtimeType,_this.id,_this.name,_this.sort);
}

@override
String toString() {
  final _this = this as Category;
  return 'Category(id: ${_this.id}, name: ${_this.name}, sort: ${_this.sort})';
}


}

/// @nodoc
abstract mixin class $CategoryCopyWith<$Res>  {
  factory $CategoryCopyWith(Category value, $Res Function(Category) _then) = _$CategoryCopyWithImpl;
@useResult
$Res call({
 int id, String name, int sort
});




}
/// @nodoc
class _$CategoryCopyWithImpl<$Res>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._self, this._then);

  final Category _self;
  final $Res Function(Category) _then;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sort = null,}) {
  return _then(Category(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Category].
extension CategoryPatterns on Category {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Category value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Category() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Category value)  $default,){
final _that = this;
switch (_that) {
case _Category():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Category value)?  $default,){
final _that = this;
switch (_that) {
case _Category() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int sort)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Category() when $default != null:
return $default(_that.id,_that.name,_that.sort);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int sort)  $default,) {final _that = this;
switch (_that) {
case _Category():
return $default(_that.id,_that.name,_that.sort);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int sort)?  $default,) {final _that = this;
switch (_that) {
case _Category() when $default != null:
return $default(_that.id,_that.name,_that.sort);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Category implements Category {
  const _Category({required this.id, required this.name, required this.sort});
  factory _Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

@override final  int id;
@override final  String name;
@override final  int sort;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryCopyWith<_Category> get copyWith => __$CategoryCopyWithImpl<_Category>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Category&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sort, sort) || other.sort == sort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,sort);
}

@override
String toString() {
    return 'Category(id: $id, name: $name, sort: $sort)';
}


}

/// @nodoc
abstract mixin class _$CategoryCopyWith<$Res> implements $CategoryCopyWith<$Res> {
  factory _$CategoryCopyWith(_Category value, $Res Function(_Category) _then) = __$CategoryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int sort
});




}
/// @nodoc
class __$CategoryCopyWithImpl<$Res>
    implements _$CategoryCopyWith<$Res> {
  __$CategoryCopyWithImpl(this._self, this._then);

  final _Category _self;
  final $Res Function(_Category) _then;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sort = null,}) {
  return _then(_Category(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DietaryTag {

 int get id; String get name; int get sort;
/// Create a copy of DietaryTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DietaryTagCopyWith<DietaryTag> get copyWith => _$DietaryTagCopyWithImpl<DietaryTag>(this as DietaryTag, _$identity);

  /// Serializes this DietaryTag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DietaryTag;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DietaryTag&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.sort, _this.sort) || other.sort == _this.sort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DietaryTag;
  return Object.hash(runtimeType,_this.id,_this.name,_this.sort);
}

@override
String toString() {
  final _this = this as DietaryTag;
  return 'DietaryTag(id: ${_this.id}, name: ${_this.name}, sort: ${_this.sort})';
}


}

/// @nodoc
abstract mixin class $DietaryTagCopyWith<$Res>  {
  factory $DietaryTagCopyWith(DietaryTag value, $Res Function(DietaryTag) _then) = _$DietaryTagCopyWithImpl;
@useResult
$Res call({
 int id, String name, int sort
});




}
/// @nodoc
class _$DietaryTagCopyWithImpl<$Res>
    implements $DietaryTagCopyWith<$Res> {
  _$DietaryTagCopyWithImpl(this._self, this._then);

  final DietaryTag _self;
  final $Res Function(DietaryTag) _then;

/// Create a copy of DietaryTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sort = null,}) {
  return _then(DietaryTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DietaryTag].
extension DietaryTagPatterns on DietaryTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DietaryTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DietaryTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DietaryTag value)  $default,){
final _that = this;
switch (_that) {
case _DietaryTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DietaryTag value)?  $default,){
final _that = this;
switch (_that) {
case _DietaryTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int sort)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DietaryTag() when $default != null:
return $default(_that.id,_that.name,_that.sort);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int sort)  $default,) {final _that = this;
switch (_that) {
case _DietaryTag():
return $default(_that.id,_that.name,_that.sort);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int sort)?  $default,) {final _that = this;
switch (_that) {
case _DietaryTag() when $default != null:
return $default(_that.id,_that.name,_that.sort);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DietaryTag implements DietaryTag {
  const _DietaryTag({required this.id, required this.name, required this.sort});
  factory _DietaryTag.fromJson(Map<String, dynamic> json) => _$DietaryTagFromJson(json);

@override final  int id;
@override final  String name;
@override final  int sort;

/// Create a copy of DietaryTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DietaryTagCopyWith<_DietaryTag> get copyWith => __$DietaryTagCopyWithImpl<_DietaryTag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DietaryTagToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DietaryTag&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sort, sort) || other.sort == sort));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,sort);
}

@override
String toString() {
    return 'DietaryTag(id: $id, name: $name, sort: $sort)';
}


}

/// @nodoc
abstract mixin class _$DietaryTagCopyWith<$Res> implements $DietaryTagCopyWith<$Res> {
  factory _$DietaryTagCopyWith(_DietaryTag value, $Res Function(_DietaryTag) _then) = __$DietaryTagCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int sort
});




}
/// @nodoc
class __$DietaryTagCopyWithImpl<$Res>
    implements _$DietaryTagCopyWith<$Res> {
  __$DietaryTagCopyWithImpl(this._self, this._then);

  final _DietaryTag _self;
  final $Res Function(_DietaryTag) _then;

/// Create a copy of DietaryTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sort = null,}) {
  return _then(_DietaryTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PickupWindow {

 String get id; String get restaurantId; String get date; DateTime get startsAt; DateTime get endsAt;
/// Create a copy of PickupWindow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PickupWindowCopyWith<PickupWindow> get copyWith => _$PickupWindowCopyWithImpl<PickupWindow>(this as PickupWindow, _$identity);

  /// Serializes this PickupWindow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PickupWindow;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PickupWindow&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.restaurantId, _this.restaurantId) || other.restaurantId == _this.restaurantId)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PickupWindow;
  return Object.hash(runtimeType,_this.id,_this.restaurantId,_this.date,_this.startsAt,_this.endsAt);
}

@override
String toString() {
  final _this = this as PickupWindow;
  return 'PickupWindow(id: ${_this.id}, restaurantId: ${_this.restaurantId}, date: ${_this.date}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt})';
}


}

/// @nodoc
abstract mixin class $PickupWindowCopyWith<$Res>  {
  factory $PickupWindowCopyWith(PickupWindow value, $Res Function(PickupWindow) _then) = _$PickupWindowCopyWithImpl;
@useResult
$Res call({
 String id, String restaurantId, String date, DateTime startsAt, DateTime endsAt
});




}
/// @nodoc
class _$PickupWindowCopyWithImpl<$Res>
    implements $PickupWindowCopyWith<$Res> {
  _$PickupWindowCopyWithImpl(this._self, this._then);

  final PickupWindow _self;
  final $Res Function(PickupWindow) _then;

/// Create a copy of PickupWindow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? restaurantId = null,Object? date = null,Object? startsAt = null,Object? endsAt = null,}) {
  return _then(PickupWindow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PickupWindow].
extension PickupWindowPatterns on PickupWindow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PickupWindow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PickupWindow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PickupWindow value)  $default,){
final _that = this;
switch (_that) {
case _PickupWindow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PickupWindow value)?  $default,){
final _that = this;
switch (_that) {
case _PickupWindow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String restaurantId,  String date,  DateTime startsAt,  DateTime endsAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PickupWindow() when $default != null:
return $default(_that.id,_that.restaurantId,_that.date,_that.startsAt,_that.endsAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String restaurantId,  String date,  DateTime startsAt,  DateTime endsAt)  $default,) {final _that = this;
switch (_that) {
case _PickupWindow():
return $default(_that.id,_that.restaurantId,_that.date,_that.startsAt,_that.endsAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String restaurantId,  String date,  DateTime startsAt,  DateTime endsAt)?  $default,) {final _that = this;
switch (_that) {
case _PickupWindow() when $default != null:
return $default(_that.id,_that.restaurantId,_that.date,_that.startsAt,_that.endsAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PickupWindow implements PickupWindow {
  const _PickupWindow({required this.id, required this.restaurantId, required this.date, required this.startsAt, required this.endsAt});
  factory _PickupWindow.fromJson(Map<String, dynamic> json) => _$PickupWindowFromJson(json);

@override final  String id;
@override final  String restaurantId;
@override final  String date;
@override final  DateTime startsAt;
@override final  DateTime endsAt;

/// Create a copy of PickupWindow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PickupWindowCopyWith<_PickupWindow> get copyWith => __$PickupWindowCopyWithImpl<_PickupWindow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PickupWindowToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PickupWindow&&(identical(other.id, id) || other.id == id)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.date, date) || other.date == date)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,restaurantId,date,startsAt,endsAt);
}

@override
String toString() {
    return 'PickupWindow(id: $id, restaurantId: $restaurantId, date: $date, startsAt: $startsAt, endsAt: $endsAt)';
}


}

/// @nodoc
abstract mixin class _$PickupWindowCopyWith<$Res> implements $PickupWindowCopyWith<$Res> {
  factory _$PickupWindowCopyWith(_PickupWindow value, $Res Function(_PickupWindow) _then) = __$PickupWindowCopyWithImpl;
@override @useResult
$Res call({
 String id, String restaurantId, String date, DateTime startsAt, DateTime endsAt
});




}
/// @nodoc
class __$PickupWindowCopyWithImpl<$Res>
    implements _$PickupWindowCopyWith<$Res> {
  __$PickupWindowCopyWithImpl(this._self, this._then);

  final _PickupWindow _self;
  final $Res Function(_PickupWindow) _then;

/// Create a copy of PickupWindow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? restaurantId = null,Object? date = null,Object? startsAt = null,Object? endsAt = null,}) {
  return _then(_PickupWindow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$Listing {

 String get id; String get restaurantId; String get date; String get name; int get categoryId;@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String get originalPrice;@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String get discountedPrice; int get quantity; int get quantityReserved; String? get photoPath; ListingStatus get status; String? get copiedFromId; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingCopyWith<Listing> get copyWith => _$ListingCopyWithImpl<Listing>(this as Listing, _$identity);

  /// Serializes this Listing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Listing;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Listing&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.restaurantId, _this.restaurantId) || other.restaurantId == _this.restaurantId)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.originalPrice, _this.originalPrice) || other.originalPrice == _this.originalPrice)&&(identical(other.discountedPrice, _this.discountedPrice) || other.discountedPrice == _this.discountedPrice)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.quantityReserved, _this.quantityReserved) || other.quantityReserved == _this.quantityReserved)&&(identical(other.photoPath, _this.photoPath) || other.photoPath == _this.photoPath)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.copiedFromId, _this.copiedFromId) || other.copiedFromId == _this.copiedFromId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Listing;
  return Object.hash(runtimeType,_this.id,_this.restaurantId,_this.date,_this.name,_this.categoryId,_this.originalPrice,_this.discountedPrice,_this.quantity,_this.quantityReserved,_this.photoPath,_this.status,_this.copiedFromId,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Listing;
  return 'Listing(id: ${_this.id}, restaurantId: ${_this.restaurantId}, date: ${_this.date}, name: ${_this.name}, categoryId: ${_this.categoryId}, originalPrice: ${_this.originalPrice}, discountedPrice: ${_this.discountedPrice}, quantity: ${_this.quantity}, quantityReserved: ${_this.quantityReserved}, photoPath: ${_this.photoPath}, status: ${_this.status}, copiedFromId: ${_this.copiedFromId}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $ListingCopyWith<$Res>  {
  factory $ListingCopyWith(Listing value, $Res Function(Listing) _then) = _$ListingCopyWithImpl;
@useResult
$Res call({
 String id, String restaurantId, String date, String name, int categoryId,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String originalPrice,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String discountedPrice, int quantity, int quantityReserved, String? photoPath, ListingStatus status, String? copiedFromId, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ListingCopyWithImpl<$Res>
    implements $ListingCopyWith<$Res> {
  _$ListingCopyWithImpl(this._self, this._then);

  final Listing _self;
  final $Res Function(Listing) _then;

/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? restaurantId = null,Object? date = null,Object? name = null,Object? categoryId = null,Object? originalPrice = null,Object? discountedPrice = null,Object? quantity = null,Object? quantityReserved = null,Object? photoPath = freezed,Object? status = null,Object? copiedFromId = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Listing(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,originalPrice: null == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as String,discountedPrice: null == discountedPrice ? _self.discountedPrice : discountedPrice // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,quantityReserved: null == quantityReserved ? _self.quantityReserved : quantityReserved // ignore: cast_nullable_to_non_nullable
as int,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListingStatus,copiedFromId: freezed == copiedFromId ? _self.copiedFromId : copiedFromId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Listing].
extension ListingPatterns on Listing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Listing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Listing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Listing value)  $default,){
final _that = this;
switch (_that) {
case _Listing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Listing value)?  $default,){
final _that = this;
switch (_that) {
case _Listing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String restaurantId,  String date,  String name,  int categoryId, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String originalPrice, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String discountedPrice,  int quantity,  int quantityReserved,  String? photoPath,  ListingStatus status,  String? copiedFromId,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Listing() when $default != null:
return $default(_that.id,_that.restaurantId,_that.date,_that.name,_that.categoryId,_that.originalPrice,_that.discountedPrice,_that.quantity,_that.quantityReserved,_that.photoPath,_that.status,_that.copiedFromId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String restaurantId,  String date,  String name,  int categoryId, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String originalPrice, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String discountedPrice,  int quantity,  int quantityReserved,  String? photoPath,  ListingStatus status,  String? copiedFromId,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Listing():
return $default(_that.id,_that.restaurantId,_that.date,_that.name,_that.categoryId,_that.originalPrice,_that.discountedPrice,_that.quantity,_that.quantityReserved,_that.photoPath,_that.status,_that.copiedFromId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String restaurantId,  String date,  String name,  int categoryId, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String originalPrice, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String discountedPrice,  int quantity,  int quantityReserved,  String? photoPath,  ListingStatus status,  String? copiedFromId,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Listing() when $default != null:
return $default(_that.id,_that.restaurantId,_that.date,_that.name,_that.categoryId,_that.originalPrice,_that.discountedPrice,_that.quantity,_that.quantityReserved,_that.photoPath,_that.status,_that.copiedFromId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Listing implements Listing {
  const _Listing({required this.id, required this.restaurantId, required this.date, required this.name, required this.categoryId, @JsonKey(fromJson: numericFromJson, toJson: numericToJson) required this.originalPrice, @JsonKey(fromJson: numericFromJson, toJson: numericToJson) required this.discountedPrice, required this.quantity, required this.quantityReserved, this.photoPath, required this.status, this.copiedFromId, required this.createdAt, required this.updatedAt});
  factory _Listing.fromJson(Map<String, dynamic> json) => _$ListingFromJson(json);

@override final  String id;
@override final  String restaurantId;
@override final  String date;
@override final  String name;
@override final  int categoryId;
@override@JsonKey(fromJson: numericFromJson, toJson: numericToJson) final  String originalPrice;
@override@JsonKey(fromJson: numericFromJson, toJson: numericToJson) final  String discountedPrice;
@override final  int quantity;
@override final  int quantityReserved;
@override final  String? photoPath;
@override final  ListingStatus status;
@override final  String? copiedFromId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingCopyWith<_Listing> get copyWith => __$ListingCopyWithImpl<_Listing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Listing&&(identical(other.id, id) || other.id == id)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.date, date) || other.date == date)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.discountedPrice, discountedPrice) || other.discountedPrice == discountedPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.quantityReserved, quantityReserved) || other.quantityReserved == quantityReserved)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.status, status) || other.status == status)&&(identical(other.copiedFromId, copiedFromId) || other.copiedFromId == copiedFromId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,restaurantId,date,name,categoryId,originalPrice,discountedPrice,quantity,quantityReserved,photoPath,status,copiedFromId,createdAt,updatedAt);
}

@override
String toString() {
    return 'Listing(id: $id, restaurantId: $restaurantId, date: $date, name: $name, categoryId: $categoryId, originalPrice: $originalPrice, discountedPrice: $discountedPrice, quantity: $quantity, quantityReserved: $quantityReserved, photoPath: $photoPath, status: $status, copiedFromId: $copiedFromId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ListingCopyWith<$Res> implements $ListingCopyWith<$Res> {
  factory _$ListingCopyWith(_Listing value, $Res Function(_Listing) _then) = __$ListingCopyWithImpl;
@override @useResult
$Res call({
 String id, String restaurantId, String date, String name, int categoryId,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String originalPrice,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String discountedPrice, int quantity, int quantityReserved, String? photoPath, ListingStatus status, String? copiedFromId, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ListingCopyWithImpl<$Res>
    implements _$ListingCopyWith<$Res> {
  __$ListingCopyWithImpl(this._self, this._then);

  final _Listing _self;
  final $Res Function(_Listing) _then;

/// Create a copy of Listing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? restaurantId = null,Object? date = null,Object? name = null,Object? categoryId = null,Object? originalPrice = null,Object? discountedPrice = null,Object? quantity = null,Object? quantityReserved = null,Object? photoPath = freezed,Object? status = null,Object? copiedFromId = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Listing(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,originalPrice: null == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as String,discountedPrice: null == discountedPrice ? _self.discountedPrice : discountedPrice // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,quantityReserved: null == quantityReserved ? _self.quantityReserved : quantityReserved // ignore: cast_nullable_to_non_nullable
as int,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListingStatus,copiedFromId: freezed == copiedFromId ? _self.copiedFromId : copiedFromId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ListingTag {

 String get listingId; int get tagId;
/// Create a copy of ListingTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingTagCopyWith<ListingTag> get copyWith => _$ListingTagCopyWithImpl<ListingTag>(this as ListingTag, _$identity);

  /// Serializes this ListingTag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ListingTag;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingTag&&(identical(other.listingId, _this.listingId) || other.listingId == _this.listingId)&&(identical(other.tagId, _this.tagId) || other.tagId == _this.tagId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ListingTag;
  return Object.hash(runtimeType,_this.listingId,_this.tagId);
}

@override
String toString() {
  final _this = this as ListingTag;
  return 'ListingTag(listingId: ${_this.listingId}, tagId: ${_this.tagId})';
}


}

/// @nodoc
abstract mixin class $ListingTagCopyWith<$Res>  {
  factory $ListingTagCopyWith(ListingTag value, $Res Function(ListingTag) _then) = _$ListingTagCopyWithImpl;
@useResult
$Res call({
 String listingId, int tagId
});




}
/// @nodoc
class _$ListingTagCopyWithImpl<$Res>
    implements $ListingTagCopyWith<$Res> {
  _$ListingTagCopyWithImpl(this._self, this._then);

  final ListingTag _self;
  final $Res Function(ListingTag) _then;

/// Create a copy of ListingTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listingId = null,Object? tagId = null,}) {
  return _then(ListingTag(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,tagId: null == tagId ? _self.tagId : tagId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ListingTag].
extension ListingTagPatterns on ListingTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingTag value)  $default,){
final _that = this;
switch (_that) {
case _ListingTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingTag value)?  $default,){
final _that = this;
switch (_that) {
case _ListingTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String listingId,  int tagId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingTag() when $default != null:
return $default(_that.listingId,_that.tagId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String listingId,  int tagId)  $default,) {final _that = this;
switch (_that) {
case _ListingTag():
return $default(_that.listingId,_that.tagId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String listingId,  int tagId)?  $default,) {final _that = this;
switch (_that) {
case _ListingTag() when $default != null:
return $default(_that.listingId,_that.tagId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListingTag implements ListingTag {
  const _ListingTag({required this.listingId, required this.tagId});
  factory _ListingTag.fromJson(Map<String, dynamic> json) => _$ListingTagFromJson(json);

@override final  String listingId;
@override final  int tagId;

/// Create a copy of ListingTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingTagCopyWith<_ListingTag> get copyWith => __$ListingTagCopyWithImpl<_ListingTag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingTagToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingTag&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.tagId, tagId) || other.tagId == tagId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,listingId,tagId);
}

@override
String toString() {
    return 'ListingTag(listingId: $listingId, tagId: $tagId)';
}


}

/// @nodoc
abstract mixin class _$ListingTagCopyWith<$Res> implements $ListingTagCopyWith<$Res> {
  factory _$ListingTagCopyWith(_ListingTag value, $Res Function(_ListingTag) _then) = __$ListingTagCopyWithImpl;
@override @useResult
$Res call({
 String listingId, int tagId
});




}
/// @nodoc
class __$ListingTagCopyWithImpl<$Res>
    implements _$ListingTagCopyWith<$Res> {
  __$ListingTagCopyWithImpl(this._self, this._then);

  final _ListingTag _self;
  final $Res Function(_ListingTag) _then;

/// Create a copy of ListingTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listingId = null,Object? tagId = null,}) {
  return _then(_ListingTag(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,tagId: null == tagId ? _self.tagId : tagId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Order {

 String get id; String get code; String? get customerId; String get customerName; String get restaurantId; String get pickupWindowId; OrderStatus get status;@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String get total;@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String get commissionRate;@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String get commissionAmount; CancelReason? get cancelReason; String? get cancelNote; String? get cancelledBy; DateTime? get reminderSentAt; DateTime get reservedAt; DateTime? get collectedAt; DateTime? get cancelledAt; DateTime? get expiredAt;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Order;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.customerName, _this.customerName) || other.customerName == _this.customerName)&&(identical(other.restaurantId, _this.restaurantId) || other.restaurantId == _this.restaurantId)&&(identical(other.pickupWindowId, _this.pickupWindowId) || other.pickupWindowId == _this.pickupWindowId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.commissionRate, _this.commissionRate) || other.commissionRate == _this.commissionRate)&&(identical(other.commissionAmount, _this.commissionAmount) || other.commissionAmount == _this.commissionAmount)&&(identical(other.cancelReason, _this.cancelReason) || other.cancelReason == _this.cancelReason)&&(identical(other.cancelNote, _this.cancelNote) || other.cancelNote == _this.cancelNote)&&(identical(other.cancelledBy, _this.cancelledBy) || other.cancelledBy == _this.cancelledBy)&&(identical(other.reminderSentAt, _this.reminderSentAt) || other.reminderSentAt == _this.reminderSentAt)&&(identical(other.reservedAt, _this.reservedAt) || other.reservedAt == _this.reservedAt)&&(identical(other.collectedAt, _this.collectedAt) || other.collectedAt == _this.collectedAt)&&(identical(other.cancelledAt, _this.cancelledAt) || other.cancelledAt == _this.cancelledAt)&&(identical(other.expiredAt, _this.expiredAt) || other.expiredAt == _this.expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Order;
  return Object.hash(runtimeType,_this.id,_this.code,_this.customerId,_this.customerName,_this.restaurantId,_this.pickupWindowId,_this.status,_this.total,_this.commissionRate,_this.commissionAmount,_this.cancelReason,_this.cancelNote,_this.cancelledBy,_this.reminderSentAt,_this.reservedAt,_this.collectedAt,_this.cancelledAt,_this.expiredAt);
}

@override
String toString() {
  final _this = this as Order;
  return 'Order(id: ${_this.id}, code: ${_this.code}, customerId: ${_this.customerId}, customerName: ${_this.customerName}, restaurantId: ${_this.restaurantId}, pickupWindowId: ${_this.pickupWindowId}, status: ${_this.status}, total: ${_this.total}, commissionRate: ${_this.commissionRate}, commissionAmount: ${_this.commissionAmount}, cancelReason: ${_this.cancelReason}, cancelNote: ${_this.cancelNote}, cancelledBy: ${_this.cancelledBy}, reminderSentAt: ${_this.reminderSentAt}, reservedAt: ${_this.reservedAt}, collectedAt: ${_this.collectedAt}, cancelledAt: ${_this.cancelledAt}, expiredAt: ${_this.expiredAt})';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
 String id, String code, String? customerId, String customerName, String restaurantId, String pickupWindowId, OrderStatus status,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String total,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String commissionRate,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String commissionAmount, CancelReason? cancelReason, String? cancelNote, String? cancelledBy, DateTime? reminderSentAt, DateTime reservedAt, DateTime? collectedAt, DateTime? cancelledAt, DateTime? expiredAt
});




}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? customerId = freezed,Object? customerName = null,Object? restaurantId = null,Object? pickupWindowId = null,Object? status = null,Object? total = null,Object? commissionRate = null,Object? commissionAmount = null,Object? cancelReason = freezed,Object? cancelNote = freezed,Object? cancelledBy = freezed,Object? reminderSentAt = freezed,Object? reservedAt = null,Object? collectedAt = freezed,Object? cancelledAt = freezed,Object? expiredAt = freezed,}) {
  return _then(Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,pickupWindowId: null == pickupWindowId ? _self.pickupWindowId : pickupWindowId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as String,commissionAmount: null == commissionAmount ? _self.commissionAmount : commissionAmount // ignore: cast_nullable_to_non_nullable
as String,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as CancelReason?,cancelNote: freezed == cancelNote ? _self.cancelNote : cancelNote // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,reminderSentAt: freezed == reminderSentAt ? _self.reminderSentAt : reminderSentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reservedAt: null == reservedAt ? _self.reservedAt : reservedAt // ignore: cast_nullable_to_non_nullable
as DateTime,collectedAt: freezed == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Order value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Order value)  $default,){
final _that = this;
switch (_that) {
case _Order():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Order value)?  $default,){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String? customerId,  String customerName,  String restaurantId,  String pickupWindowId,  OrderStatus status, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String total, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String commissionRate, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String commissionAmount,  CancelReason? cancelReason,  String? cancelNote,  String? cancelledBy,  DateTime? reminderSentAt,  DateTime reservedAt,  DateTime? collectedAt,  DateTime? cancelledAt,  DateTime? expiredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.code,_that.customerId,_that.customerName,_that.restaurantId,_that.pickupWindowId,_that.status,_that.total,_that.commissionRate,_that.commissionAmount,_that.cancelReason,_that.cancelNote,_that.cancelledBy,_that.reminderSentAt,_that.reservedAt,_that.collectedAt,_that.cancelledAt,_that.expiredAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String? customerId,  String customerName,  String restaurantId,  String pickupWindowId,  OrderStatus status, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String total, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String commissionRate, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String commissionAmount,  CancelReason? cancelReason,  String? cancelNote,  String? cancelledBy,  DateTime? reminderSentAt,  DateTime reservedAt,  DateTime? collectedAt,  DateTime? cancelledAt,  DateTime? expiredAt)  $default,) {final _that = this;
switch (_that) {
case _Order():
return $default(_that.id,_that.code,_that.customerId,_that.customerName,_that.restaurantId,_that.pickupWindowId,_that.status,_that.total,_that.commissionRate,_that.commissionAmount,_that.cancelReason,_that.cancelNote,_that.cancelledBy,_that.reminderSentAt,_that.reservedAt,_that.collectedAt,_that.cancelledAt,_that.expiredAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String? customerId,  String customerName,  String restaurantId,  String pickupWindowId,  OrderStatus status, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String total, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String commissionRate, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String commissionAmount,  CancelReason? cancelReason,  String? cancelNote,  String? cancelledBy,  DateTime? reminderSentAt,  DateTime reservedAt,  DateTime? collectedAt,  DateTime? cancelledAt,  DateTime? expiredAt)?  $default,) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.code,_that.customerId,_that.customerName,_that.restaurantId,_that.pickupWindowId,_that.status,_that.total,_that.commissionRate,_that.commissionAmount,_that.cancelReason,_that.cancelNote,_that.cancelledBy,_that.reminderSentAt,_that.reservedAt,_that.collectedAt,_that.cancelledAt,_that.expiredAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Order implements Order {
  const _Order({required this.id, required this.code, this.customerId, required this.customerName, required this.restaurantId, required this.pickupWindowId, required this.status, @JsonKey(fromJson: numericFromJson, toJson: numericToJson) required this.total, @JsonKey(fromJson: numericFromJson, toJson: numericToJson) required this.commissionRate, @JsonKey(fromJson: numericFromJson, toJson: numericToJson) required this.commissionAmount, this.cancelReason, this.cancelNote, this.cancelledBy, this.reminderSentAt, required this.reservedAt, this.collectedAt, this.cancelledAt, this.expiredAt});
  factory _Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

@override final  String id;
@override final  String code;
@override final  String? customerId;
@override final  String customerName;
@override final  String restaurantId;
@override final  String pickupWindowId;
@override final  OrderStatus status;
@override@JsonKey(fromJson: numericFromJson, toJson: numericToJson) final  String total;
@override@JsonKey(fromJson: numericFromJson, toJson: numericToJson) final  String commissionRate;
@override@JsonKey(fromJson: numericFromJson, toJson: numericToJson) final  String commissionAmount;
@override final  CancelReason? cancelReason;
@override final  String? cancelNote;
@override final  String? cancelledBy;
@override final  DateTime? reminderSentAt;
@override final  DateTime reservedAt;
@override final  DateTime? collectedAt;
@override final  DateTime? cancelledAt;
@override final  DateTime? expiredAt;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.pickupWindowId, pickupWindowId) || other.pickupWindowId == pickupWindowId)&&(identical(other.status, status) || other.status == status)&&(identical(other.total, total) || other.total == total)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate)&&(identical(other.commissionAmount, commissionAmount) || other.commissionAmount == commissionAmount)&&(identical(other.cancelReason, cancelReason) || other.cancelReason == cancelReason)&&(identical(other.cancelNote, cancelNote) || other.cancelNote == cancelNote)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy)&&(identical(other.reminderSentAt, reminderSentAt) || other.reminderSentAt == reminderSentAt)&&(identical(other.reservedAt, reservedAt) || other.reservedAt == reservedAt)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,code,customerId,customerName,restaurantId,pickupWindowId,status,total,commissionRate,commissionAmount,cancelReason,cancelNote,cancelledBy,reminderSentAt,reservedAt,collectedAt,cancelledAt,expiredAt);
}

@override
String toString() {
    return 'Order(id: $id, code: $code, customerId: $customerId, customerName: $customerName, restaurantId: $restaurantId, pickupWindowId: $pickupWindowId, status: $status, total: $total, commissionRate: $commissionRate, commissionAmount: $commissionAmount, cancelReason: $cancelReason, cancelNote: $cancelNote, cancelledBy: $cancelledBy, reminderSentAt: $reminderSentAt, reservedAt: $reservedAt, collectedAt: $collectedAt, cancelledAt: $cancelledAt, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String? customerId, String customerName, String restaurantId, String pickupWindowId, OrderStatus status,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String total,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String commissionRate,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String commissionAmount, CancelReason? cancelReason, String? cancelNote, String? cancelledBy, DateTime? reminderSentAt, DateTime reservedAt, DateTime? collectedAt, DateTime? cancelledAt, DateTime? expiredAt
});




}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? customerId = freezed,Object? customerName = null,Object? restaurantId = null,Object? pickupWindowId = null,Object? status = null,Object? total = null,Object? commissionRate = null,Object? commissionAmount = null,Object? cancelReason = freezed,Object? cancelNote = freezed,Object? cancelledBy = freezed,Object? reminderSentAt = freezed,Object? reservedAt = null,Object? collectedAt = freezed,Object? cancelledAt = freezed,Object? expiredAt = freezed,}) {
  return _then(_Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,pickupWindowId: null == pickupWindowId ? _self.pickupWindowId : pickupWindowId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as String,commissionAmount: null == commissionAmount ? _self.commissionAmount : commissionAmount // ignore: cast_nullable_to_non_nullable
as String,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as CancelReason?,cancelNote: freezed == cancelNote ? _self.cancelNote : cancelNote // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,reminderSentAt: freezed == reminderSentAt ? _self.reminderSentAt : reminderSentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reservedAt: null == reservedAt ? _self.reservedAt : reservedAt // ignore: cast_nullable_to_non_nullable
as DateTime,collectedAt: freezed == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$OrderItem {

 String get orderId; String get listingId; String get name;@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String get unitPrice;@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String get originalPrice; int get quantity;@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String get lineTotal;
/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemCopyWith<OrderItem> get copyWith => _$OrderItemCopyWithImpl<OrderItem>(this as OrderItem, _$identity);

  /// Serializes this OrderItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrderItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItem&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.listingId, _this.listingId) || other.listingId == _this.listingId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.unitPrice, _this.unitPrice) || other.unitPrice == _this.unitPrice)&&(identical(other.originalPrice, _this.originalPrice) || other.originalPrice == _this.originalPrice)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.lineTotal, _this.lineTotal) || other.lineTotal == _this.lineTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrderItem;
  return Object.hash(runtimeType,_this.orderId,_this.listingId,_this.name,_this.unitPrice,_this.originalPrice,_this.quantity,_this.lineTotal);
}

@override
String toString() {
  final _this = this as OrderItem;
  return 'OrderItem(orderId: ${_this.orderId}, listingId: ${_this.listingId}, name: ${_this.name}, unitPrice: ${_this.unitPrice}, originalPrice: ${_this.originalPrice}, quantity: ${_this.quantity}, lineTotal: ${_this.lineTotal})';
}


}

/// @nodoc
abstract mixin class $OrderItemCopyWith<$Res>  {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) _then) = _$OrderItemCopyWithImpl;
@useResult
$Res call({
 String orderId, String listingId, String name,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String unitPrice,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String originalPrice, int quantity,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String lineTotal
});




}
/// @nodoc
class _$OrderItemCopyWithImpl<$Res>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._self, this._then);

  final OrderItem _self;
  final $Res Function(OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? listingId = null,Object? name = null,Object? unitPrice = null,Object? originalPrice = null,Object? quantity = null,Object? lineTotal = null,}) {
  return _then(OrderItem(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as String,originalPrice: null == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderItem].
extension OrderItemPatterns on OrderItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderItem value)  $default,){
final _that = this;
switch (_that) {
case _OrderItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderItem value)?  $default,){
final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orderId,  String listingId,  String name, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String unitPrice, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String originalPrice,  int quantity, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String lineTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
return $default(_that.orderId,_that.listingId,_that.name,_that.unitPrice,_that.originalPrice,_that.quantity,_that.lineTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orderId,  String listingId,  String name, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String unitPrice, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String originalPrice,  int quantity, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String lineTotal)  $default,) {final _that = this;
switch (_that) {
case _OrderItem():
return $default(_that.orderId,_that.listingId,_that.name,_that.unitPrice,_that.originalPrice,_that.quantity,_that.lineTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orderId,  String listingId,  String name, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String unitPrice, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String originalPrice,  int quantity, @JsonKey(fromJson: numericFromJson, toJson: numericToJson)  String lineTotal)?  $default,) {final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
return $default(_that.orderId,_that.listingId,_that.name,_that.unitPrice,_that.originalPrice,_that.quantity,_that.lineTotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderItem implements OrderItem {
  const _OrderItem({required this.orderId, required this.listingId, required this.name, @JsonKey(fromJson: numericFromJson, toJson: numericToJson) required this.unitPrice, @JsonKey(fromJson: numericFromJson, toJson: numericToJson) required this.originalPrice, required this.quantity, @JsonKey(fromJson: numericFromJson, toJson: numericToJson) required this.lineTotal});
  factory _OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

@override final  String orderId;
@override final  String listingId;
@override final  String name;
@override@JsonKey(fromJson: numericFromJson, toJson: numericToJson) final  String unitPrice;
@override@JsonKey(fromJson: numericFromJson, toJson: numericToJson) final  String originalPrice;
@override final  int quantity;
@override@JsonKey(fromJson: numericFromJson, toJson: numericToJson) final  String lineTotal;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemCopyWith<_OrderItem> get copyWith => __$OrderItemCopyWithImpl<_OrderItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItem&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.name, name) || other.name == name)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,orderId,listingId,name,unitPrice,originalPrice,quantity,lineTotal);
}

@override
String toString() {
    return 'OrderItem(orderId: $orderId, listingId: $listingId, name: $name, unitPrice: $unitPrice, originalPrice: $originalPrice, quantity: $quantity, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class _$OrderItemCopyWith<$Res> implements $OrderItemCopyWith<$Res> {
  factory _$OrderItemCopyWith(_OrderItem value, $Res Function(_OrderItem) _then) = __$OrderItemCopyWithImpl;
@override @useResult
$Res call({
 String orderId, String listingId, String name,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String unitPrice,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String originalPrice, int quantity,@JsonKey(fromJson: numericFromJson, toJson: numericToJson) String lineTotal
});




}
/// @nodoc
class __$OrderItemCopyWithImpl<$Res>
    implements _$OrderItemCopyWith<$Res> {
  __$OrderItemCopyWithImpl(this._self, this._then);

  final _OrderItem _self;
  final $Res Function(_OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? listingId = null,Object? name = null,Object? unitPrice = null,Object? originalPrice = null,Object? quantity = null,Object? lineTotal = null,}) {
  return _then(_OrderItem(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as String,originalPrice: null == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DeviceToken {

 String get userId; String get token; String get platform; DateTime get updatedAt;
/// Create a copy of DeviceToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceTokenCopyWith<DeviceToken> get copyWith => _$DeviceTokenCopyWithImpl<DeviceToken>(this as DeviceToken, _$identity);

  /// Serializes this DeviceToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DeviceToken;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceToken&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.token, _this.token) || other.token == _this.token)&&(identical(other.platform, _this.platform) || other.platform == _this.platform)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DeviceToken;
  return Object.hash(runtimeType,_this.userId,_this.token,_this.platform,_this.updatedAt);
}

@override
String toString() {
  final _this = this as DeviceToken;
  return 'DeviceToken(userId: ${_this.userId}, token: ${_this.token}, platform: ${_this.platform}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $DeviceTokenCopyWith<$Res>  {
  factory $DeviceTokenCopyWith(DeviceToken value, $Res Function(DeviceToken) _then) = _$DeviceTokenCopyWithImpl;
@useResult
$Res call({
 String userId, String token, String platform, DateTime updatedAt
});




}
/// @nodoc
class _$DeviceTokenCopyWithImpl<$Res>
    implements $DeviceTokenCopyWith<$Res> {
  _$DeviceTokenCopyWithImpl(this._self, this._then);

  final DeviceToken _self;
  final $Res Function(DeviceToken) _then;

/// Create a copy of DeviceToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? token = null,Object? platform = null,Object? updatedAt = null,}) {
  return _then(DeviceToken(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceToken].
extension DeviceTokenPatterns on DeviceToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceToken value)  $default,){
final _that = this;
switch (_that) {
case _DeviceToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceToken value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String token,  String platform,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceToken() when $default != null:
return $default(_that.userId,_that.token,_that.platform,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String token,  String platform,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DeviceToken():
return $default(_that.userId,_that.token,_that.platform,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String token,  String platform,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DeviceToken() when $default != null:
return $default(_that.userId,_that.token,_that.platform,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceToken implements DeviceToken {
  const _DeviceToken({required this.userId, required this.token, required this.platform, required this.updatedAt});
  factory _DeviceToken.fromJson(Map<String, dynamic> json) => _$DeviceTokenFromJson(json);

@override final  String userId;
@override final  String token;
@override final  String platform;
@override final  DateTime updatedAt;

/// Create a copy of DeviceToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceTokenCopyWith<_DeviceToken> get copyWith => __$DeviceTokenCopyWithImpl<_DeviceToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceTokenToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceToken&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.token, token) || other.token == token)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,token,platform,updatedAt);
}

@override
String toString() {
    return 'DeviceToken(userId: $userId, token: $token, platform: $platform, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DeviceTokenCopyWith<$Res> implements $DeviceTokenCopyWith<$Res> {
  factory _$DeviceTokenCopyWith(_DeviceToken value, $Res Function(_DeviceToken) _then) = __$DeviceTokenCopyWithImpl;
@override @useResult
$Res call({
 String userId, String token, String platform, DateTime updatedAt
});




}
/// @nodoc
class __$DeviceTokenCopyWithImpl<$Res>
    implements _$DeviceTokenCopyWith<$Res> {
  __$DeviceTokenCopyWithImpl(this._self, this._then);

  final _DeviceToken _self;
  final $Res Function(_DeviceToken) _then;

/// Create a copy of DeviceToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? token = null,Object? platform = null,Object? updatedAt = null,}) {
  return _then(_DeviceToken(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PublicSettings {

 String get currency; int get maxUnitsPerListing; int get maxActiveOrders; String get supportEmail; bool get pricesIncludeVat; int get searchRadiusM;
/// Create a copy of PublicSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicSettingsCopyWith<PublicSettings> get copyWith => _$PublicSettingsCopyWithImpl<PublicSettings>(this as PublicSettings, _$identity);

  /// Serializes this PublicSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PublicSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicSettings&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.maxUnitsPerListing, _this.maxUnitsPerListing) || other.maxUnitsPerListing == _this.maxUnitsPerListing)&&(identical(other.maxActiveOrders, _this.maxActiveOrders) || other.maxActiveOrders == _this.maxActiveOrders)&&(identical(other.supportEmail, _this.supportEmail) || other.supportEmail == _this.supportEmail)&&(identical(other.pricesIncludeVat, _this.pricesIncludeVat) || other.pricesIncludeVat == _this.pricesIncludeVat)&&(identical(other.searchRadiusM, _this.searchRadiusM) || other.searchRadiusM == _this.searchRadiusM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PublicSettings;
  return Object.hash(runtimeType,_this.currency,_this.maxUnitsPerListing,_this.maxActiveOrders,_this.supportEmail,_this.pricesIncludeVat,_this.searchRadiusM);
}

@override
String toString() {
  final _this = this as PublicSettings;
  return 'PublicSettings(currency: ${_this.currency}, maxUnitsPerListing: ${_this.maxUnitsPerListing}, maxActiveOrders: ${_this.maxActiveOrders}, supportEmail: ${_this.supportEmail}, pricesIncludeVat: ${_this.pricesIncludeVat}, searchRadiusM: ${_this.searchRadiusM})';
}


}

/// @nodoc
abstract mixin class $PublicSettingsCopyWith<$Res>  {
  factory $PublicSettingsCopyWith(PublicSettings value, $Res Function(PublicSettings) _then) = _$PublicSettingsCopyWithImpl;
@useResult
$Res call({
 String currency, int maxUnitsPerListing, int maxActiveOrders, String supportEmail, bool pricesIncludeVat, int searchRadiusM
});




}
/// @nodoc
class _$PublicSettingsCopyWithImpl<$Res>
    implements $PublicSettingsCopyWith<$Res> {
  _$PublicSettingsCopyWithImpl(this._self, this._then);

  final PublicSettings _self;
  final $Res Function(PublicSettings) _then;

/// Create a copy of PublicSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currency = null,Object? maxUnitsPerListing = null,Object? maxActiveOrders = null,Object? supportEmail = null,Object? pricesIncludeVat = null,Object? searchRadiusM = null,}) {
  return _then(PublicSettings(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,maxUnitsPerListing: null == maxUnitsPerListing ? _self.maxUnitsPerListing : maxUnitsPerListing // ignore: cast_nullable_to_non_nullable
as int,maxActiveOrders: null == maxActiveOrders ? _self.maxActiveOrders : maxActiveOrders // ignore: cast_nullable_to_non_nullable
as int,supportEmail: null == supportEmail ? _self.supportEmail : supportEmail // ignore: cast_nullable_to_non_nullable
as String,pricesIncludeVat: null == pricesIncludeVat ? _self.pricesIncludeVat : pricesIncludeVat // ignore: cast_nullable_to_non_nullable
as bool,searchRadiusM: null == searchRadiusM ? _self.searchRadiusM : searchRadiusM // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicSettings].
extension PublicSettingsPatterns on PublicSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicSettings value)  $default,){
final _that = this;
switch (_that) {
case _PublicSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicSettings value)?  $default,){
final _that = this;
switch (_that) {
case _PublicSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currency,  int maxUnitsPerListing,  int maxActiveOrders,  String supportEmail,  bool pricesIncludeVat,  int searchRadiusM)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicSettings() when $default != null:
return $default(_that.currency,_that.maxUnitsPerListing,_that.maxActiveOrders,_that.supportEmail,_that.pricesIncludeVat,_that.searchRadiusM);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currency,  int maxUnitsPerListing,  int maxActiveOrders,  String supportEmail,  bool pricesIncludeVat,  int searchRadiusM)  $default,) {final _that = this;
switch (_that) {
case _PublicSettings():
return $default(_that.currency,_that.maxUnitsPerListing,_that.maxActiveOrders,_that.supportEmail,_that.pricesIncludeVat,_that.searchRadiusM);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currency,  int maxUnitsPerListing,  int maxActiveOrders,  String supportEmail,  bool pricesIncludeVat,  int searchRadiusM)?  $default,) {final _that = this;
switch (_that) {
case _PublicSettings() when $default != null:
return $default(_that.currency,_that.maxUnitsPerListing,_that.maxActiveOrders,_that.supportEmail,_that.pricesIncludeVat,_that.searchRadiusM);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicSettings implements PublicSettings {
  const _PublicSettings({required this.currency, required this.maxUnitsPerListing, required this.maxActiveOrders, required this.supportEmail, required this.pricesIncludeVat, required this.searchRadiusM});
  factory _PublicSettings.fromJson(Map<String, dynamic> json) => _$PublicSettingsFromJson(json);

@override final  String currency;
@override final  int maxUnitsPerListing;
@override final  int maxActiveOrders;
@override final  String supportEmail;
@override final  bool pricesIncludeVat;
@override final  int searchRadiusM;

/// Create a copy of PublicSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicSettingsCopyWith<_PublicSettings> get copyWith => __$PublicSettingsCopyWithImpl<_PublicSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicSettings&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.maxUnitsPerListing, maxUnitsPerListing) || other.maxUnitsPerListing == maxUnitsPerListing)&&(identical(other.maxActiveOrders, maxActiveOrders) || other.maxActiveOrders == maxActiveOrders)&&(identical(other.supportEmail, supportEmail) || other.supportEmail == supportEmail)&&(identical(other.pricesIncludeVat, pricesIncludeVat) || other.pricesIncludeVat == pricesIncludeVat)&&(identical(other.searchRadiusM, searchRadiusM) || other.searchRadiusM == searchRadiusM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,currency,maxUnitsPerListing,maxActiveOrders,supportEmail,pricesIncludeVat,searchRadiusM);
}

@override
String toString() {
    return 'PublicSettings(currency: $currency, maxUnitsPerListing: $maxUnitsPerListing, maxActiveOrders: $maxActiveOrders, supportEmail: $supportEmail, pricesIncludeVat: $pricesIncludeVat, searchRadiusM: $searchRadiusM)';
}


}

/// @nodoc
abstract mixin class _$PublicSettingsCopyWith<$Res> implements $PublicSettingsCopyWith<$Res> {
  factory _$PublicSettingsCopyWith(_PublicSettings value, $Res Function(_PublicSettings) _then) = __$PublicSettingsCopyWithImpl;
@override @useResult
$Res call({
 String currency, int maxUnitsPerListing, int maxActiveOrders, String supportEmail, bool pricesIncludeVat, int searchRadiusM
});




}
/// @nodoc
class __$PublicSettingsCopyWithImpl<$Res>
    implements _$PublicSettingsCopyWith<$Res> {
  __$PublicSettingsCopyWithImpl(this._self, this._then);

  final _PublicSettings _self;
  final $Res Function(_PublicSettings) _then;

/// Create a copy of PublicSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currency = null,Object? maxUnitsPerListing = null,Object? maxActiveOrders = null,Object? supportEmail = null,Object? pricesIncludeVat = null,Object? searchRadiusM = null,}) {
  return _then(_PublicSettings(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,maxUnitsPerListing: null == maxUnitsPerListing ? _self.maxUnitsPerListing : maxUnitsPerListing // ignore: cast_nullable_to_non_nullable
as int,maxActiveOrders: null == maxActiveOrders ? _self.maxActiveOrders : maxActiveOrders // ignore: cast_nullable_to_non_nullable
as int,supportEmail: null == supportEmail ? _self.supportEmail : supportEmail // ignore: cast_nullable_to_non_nullable
as String,pricesIncludeVat: null == pricesIncludeVat ? _self.pricesIncludeVat : pricesIncludeVat // ignore: cast_nullable_to_non_nullable
as bool,searchRadiusM: null == searchRadiusM ? _self.searchRadiusM : searchRadiusM // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
