// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trashspot_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrashspotRequest {
  @JsonKey(includeFromJson: false, includeToJson: false)
  MultipartFile? get image;
  double get latitude;
  double get longitude;

  /// Create a copy of TrashspotRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TrashspotRequestCopyWith<TrashspotRequest> get copyWith =>
      _$TrashspotRequestCopyWithImpl<TrashspotRequest>(
          this as TrashspotRequest, _$identity);

  /// Serializes this TrashspotRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TrashspotRequest &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, image, latitude, longitude);

  @override
  String toString() {
    return 'TrashspotRequest(image: $image, latitude: $latitude, longitude: $longitude)';
  }
}

/// @nodoc
abstract mixin class $TrashspotRequestCopyWith<$Res> {
  factory $TrashspotRequestCopyWith(
          TrashspotRequest value, $Res Function(TrashspotRequest) _then) =
      _$TrashspotRequestCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      MultipartFile? image,
      double latitude,
      double longitude});
}

/// @nodoc
class _$TrashspotRequestCopyWithImpl<$Res>
    implements $TrashspotRequestCopyWith<$Res> {
  _$TrashspotRequestCopyWithImpl(this._self, this._then);

  final TrashspotRequest _self;
  final $Res Function(TrashspotRequest) _then;

  /// Create a copy of TrashspotRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_self.copyWith(
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as MultipartFile?,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TrashspotRequest implements TrashspotRequest {
  const _TrashspotRequest(
      {@JsonKey(includeFromJson: false, includeToJson: false) this.image,
      required this.latitude,
      required this.longitude});
  factory _TrashspotRequest.fromJson(Map<String, dynamic> json) =>
      _$TrashspotRequestFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final MultipartFile? image;
  @override
  final double latitude;
  @override
  final double longitude;

  /// Create a copy of TrashspotRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TrashspotRequestCopyWith<_TrashspotRequest> get copyWith =>
      __$TrashspotRequestCopyWithImpl<_TrashspotRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TrashspotRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TrashspotRequest &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, image, latitude, longitude);

  @override
  String toString() {
    return 'TrashspotRequest(image: $image, latitude: $latitude, longitude: $longitude)';
  }
}

/// @nodoc
abstract mixin class _$TrashspotRequestCopyWith<$Res>
    implements $TrashspotRequestCopyWith<$Res> {
  factory _$TrashspotRequestCopyWith(
          _TrashspotRequest value, $Res Function(_TrashspotRequest) _then) =
      __$TrashspotRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      MultipartFile? image,
      double latitude,
      double longitude});
}

/// @nodoc
class __$TrashspotRequestCopyWithImpl<$Res>
    implements _$TrashspotRequestCopyWith<$Res> {
  __$TrashspotRequestCopyWithImpl(this._self, this._then);

  final _TrashspotRequest _self;
  final $Res Function(_TrashspotRequest) _then;

  /// Create a copy of TrashspotRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? image = freezed,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_TrashspotRequest(
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as MultipartFile?,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
