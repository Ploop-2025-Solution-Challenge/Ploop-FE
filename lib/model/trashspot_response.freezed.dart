// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trashspot_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrashspotResponse {
  int get id;
  double get latitude;
  double get longitude;
  String get imageUrl;
  String get createdAt;

  /// Create a copy of TrashspotResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TrashspotResponseCopyWith<TrashspotResponse> get copyWith =>
      _$TrashspotResponseCopyWithImpl<TrashspotResponse>(
          this as TrashspotResponse, _$identity);

  /// Serializes this TrashspotResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TrashspotResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, latitude, longitude, imageUrl, createdAt);

  @override
  String toString() {
    return 'TrashspotResponse(id: $id, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $TrashspotResponseCopyWith<$Res> {
  factory $TrashspotResponseCopyWith(
          TrashspotResponse value, $Res Function(TrashspotResponse) _then) =
      _$TrashspotResponseCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      double latitude,
      double longitude,
      String imageUrl,
      String createdAt});
}

/// @nodoc
class _$TrashspotResponseCopyWithImpl<$Res>
    implements $TrashspotResponseCopyWith<$Res> {
  _$TrashspotResponseCopyWithImpl(this._self, this._then);

  final TrashspotResponse _self;
  final $Res Function(TrashspotResponse) _then;

  /// Create a copy of TrashspotResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? imageUrl = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TrashspotResponse implements TrashspotResponse {
  const _TrashspotResponse(
      {required this.id,
      required this.latitude,
      required this.longitude,
      required this.imageUrl,
      required this.createdAt});
  factory _TrashspotResponse.fromJson(Map<String, dynamic> json) =>
      _$TrashspotResponseFromJson(json);

  @override
  final int id;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String imageUrl;
  @override
  final String createdAt;

  /// Create a copy of TrashspotResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TrashspotResponseCopyWith<_TrashspotResponse> get copyWith =>
      __$TrashspotResponseCopyWithImpl<_TrashspotResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TrashspotResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TrashspotResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, latitude, longitude, imageUrl, createdAt);

  @override
  String toString() {
    return 'TrashspotResponse(id: $id, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$TrashspotResponseCopyWith<$Res>
    implements $TrashspotResponseCopyWith<$Res> {
  factory _$TrashspotResponseCopyWith(
          _TrashspotResponse value, $Res Function(_TrashspotResponse) _then) =
      __$TrashspotResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      double latitude,
      double longitude,
      String imageUrl,
      String createdAt});
}

/// @nodoc
class __$TrashspotResponseCopyWithImpl<$Res>
    implements _$TrashspotResponseCopyWith<$Res> {
  __$TrashspotResponseCopyWithImpl(this._self, this._then);

  final _TrashspotResponse _self;
  final $Res Function(_TrashspotResponse) _then;

  /// Create a copy of TrashspotResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? imageUrl = null,
    Object? createdAt = null,
  }) {
    return _then(_TrashspotResponse(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
