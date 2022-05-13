// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'note_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NoteDetails _$NoteDetailsFromJson(Map<String, dynamic> json) {
  return _NoteDetails.fromJson(json);
}

/// @nodoc
class _$NoteDetailsTearOff {
  const _$NoteDetailsTearOff();

  _NoteDetails call(
      {required String title,
      required String description,
      required DateTime created,
      required String? imageUrl,
      required String? url}) {
    return _NoteDetails(
      title: title,
      description: description,
      created: created,
      imageUrl: imageUrl,
      url: url,
    );
  }

  NoteDetails fromJson(Map<String, Object?> json) {
    return NoteDetails.fromJson(json);
  }
}

/// @nodoc
const $NoteDetails = _$NoteDetailsTearOff();

/// @nodoc
mixin _$NoteDetails {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get created => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteDetailsCopyWith<NoteDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteDetailsCopyWith<$Res> {
  factory $NoteDetailsCopyWith(
          NoteDetails value, $Res Function(NoteDetails) then) =
      _$NoteDetailsCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String description,
      DateTime created,
      String? imageUrl,
      String? url});
}

/// @nodoc
class _$NoteDetailsCopyWithImpl<$Res> implements $NoteDetailsCopyWith<$Res> {
  _$NoteDetailsCopyWithImpl(this._value, this._then);

  final NoteDetails _value;
  // ignore: unused_field
  final $Res Function(NoteDetails) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? created = freezed,
    Object? imageUrl = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$NoteDetailsCopyWith<$Res>
    implements $NoteDetailsCopyWith<$Res> {
  factory _$NoteDetailsCopyWith(
          _NoteDetails value, $Res Function(_NoteDetails) then) =
      __$NoteDetailsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String description,
      DateTime created,
      String? imageUrl,
      String? url});
}

/// @nodoc
class __$NoteDetailsCopyWithImpl<$Res> extends _$NoteDetailsCopyWithImpl<$Res>
    implements _$NoteDetailsCopyWith<$Res> {
  __$NoteDetailsCopyWithImpl(
      _NoteDetails _value, $Res Function(_NoteDetails) _then)
      : super(_value, (v) => _then(v as _NoteDetails));

  @override
  _NoteDetails get _value => super._value as _NoteDetails;

  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? created = freezed,
    Object? imageUrl = freezed,
    Object? url = freezed,
  }) {
    return _then(_NoteDetails(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NoteDetails implements _NoteDetails {
  _$_NoteDetails(
      {required this.title,
      required this.description,
      required this.created,
      required this.imageUrl,
      required this.url});

  factory _$_NoteDetails.fromJson(Map<String, dynamic> json) =>
      _$$_NoteDetailsFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime created;
  @override
  final String? imageUrl;
  @override
  final String? url;

  @override
  String toString() {
    return 'NoteDetails(title: $title, description: $description, created: $created, imageUrl: $imageUrl, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NoteDetails &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.created, created) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(created),
      const DeepCollectionEquality().hash(imageUrl),
      const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  _$NoteDetailsCopyWith<_NoteDetails> get copyWith =>
      __$NoteDetailsCopyWithImpl<_NoteDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NoteDetailsToJson(this);
  }
}

abstract class _NoteDetails implements NoteDetails {
  factory _NoteDetails(
      {required String title,
      required String description,
      required DateTime created,
      required String? imageUrl,
      required String? url}) = _$_NoteDetails;

  factory _NoteDetails.fromJson(Map<String, dynamic> json) =
      _$_NoteDetails.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get created;
  @override
  String? get imageUrl;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$NoteDetailsCopyWith<_NoteDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
