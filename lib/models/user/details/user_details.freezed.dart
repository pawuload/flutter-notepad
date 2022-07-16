// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) {
  return _UserDetails.fromJson(json);
}

/// @nodoc
class _$UserDetailsTearOff {
  const _$UserDetailsTearOff();

  _UserDetails call({required String email, required bool isPremium}) {
    return _UserDetails(
      email: email,
      isPremium: isPremium,
    );
  }

  UserDetails fromJson(Map<String, Object?> json) {
    return UserDetails.fromJson(json);
  }
}

/// @nodoc
const $UserDetails = _$UserDetailsTearOff();

/// @nodoc
mixin _$UserDetails {
  String get email => throw _privateConstructorUsedError;

  bool get isPremium => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserDetailsCopyWith<UserDetails> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDetailsCopyWith<$Res> {
  factory $UserDetailsCopyWith(UserDetails value, $Res Function(UserDetails) then) = _$UserDetailsCopyWithImpl<$Res>;

  $Res call({String email, bool isPremium});
}

/// @nodoc
class _$UserDetailsCopyWithImpl<$Res> implements $UserDetailsCopyWith<$Res> {
  _$UserDetailsCopyWithImpl(this._value, this._then);

  final UserDetails _value;

  // ignore: unused_field
  final $Res Function(UserDetails) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? isPremium = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isPremium: isPremium == freezed
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$UserDetailsCopyWith<$Res> implements $UserDetailsCopyWith<$Res> {
  factory _$UserDetailsCopyWith(_UserDetails value, $Res Function(_UserDetails) then) = __$UserDetailsCopyWithImpl<$Res>;

  @override
  $Res call({String email, bool isPremium});
}

/// @nodoc
class __$UserDetailsCopyWithImpl<$Res> extends _$UserDetailsCopyWithImpl<$Res> implements _$UserDetailsCopyWith<$Res> {
  __$UserDetailsCopyWithImpl(_UserDetails _value, $Res Function(_UserDetails) _then) : super(_value, (v) => _then(v as _UserDetails));

  @override
  _UserDetails get _value => super._value as _UserDetails;

  @override
  $Res call({
    Object? email = freezed,
    Object? isPremium = freezed,
  }) {
    return _then(_UserDetails(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isPremium: isPremium == freezed
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserDetails implements _UserDetails {
  _$_UserDetails({required this.email, required this.isPremium});

  factory _$_UserDetails.fromJson(Map<String, dynamic> json) => _$$_UserDetailsFromJson(json);

  @override
  final String email;
  @override
  final bool isPremium;

  @override
  String toString() {
    return 'UserDetails(email: $email, isPremium: $isPremium)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserDetails &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.isPremium, isPremium));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(email), const DeepCollectionEquality().hash(isPremium));

  @JsonKey(ignore: true)
  @override
  _$UserDetailsCopyWith<_UserDetails> get copyWith => __$UserDetailsCopyWithImpl<_UserDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserDetailsToJson(this);
  }
}

abstract class _UserDetails implements UserDetails {
  factory _UserDetails({required String email, required bool isPremium}) = _$_UserDetails;

  factory _UserDetails.fromJson(Map<String, dynamic> json) = _$_UserDetails.fromJson;

  @override
  String get email;

  @override
  bool get isPremium;

  @override
  @JsonKey(ignore: true)
  _$UserDetailsCopyWith<_UserDetails> get copyWith => throw _privateConstructorUsedError;
}
