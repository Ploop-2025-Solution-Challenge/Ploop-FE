// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bin_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BinRequest {
  @JsonKey(includeFromJson: false, includeToJson: false)
  MultipartFile? get image;
  double get latitude;
  double get longitude;

  /// Create a copy of BinRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BinRequestCopyWith<BinRequest> get copyWith =>
      _$BinRequestCopyWithImpl<BinRequest>(this as BinRequest, _$identity);

  /// Serializes this BinRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BinRequest &&
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
    return 'BinRequest(image: $image, latitude: $latitude, longitude: $longitude)';
  }
}

/// @nodoc
abstract mixin class $BinRequestCopyWith<$Res> {
  factory $BinRequestCopyWith(
          BinRequest value, $Res Function(BinRequest) _then) =
      _$BinRequestCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      MultipartFile? image,
      double latitude,
      double longitude});
}

/// @nodoc
class _$BinRequestCopyWithImpl<$Res> implements $BinRequestCopyWith<$Res> {
  _$BinRequestCopyWithImpl(this._self, this._then);

  final BinRequest _self;
  final $Res Function(BinRequest) _then;

  /// Create a copy of BinRequest
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
class _BinRequest implements BinRequest {
  const _BinRequest(
      {@JsonKey(includeFromJson: false, includeToJson: false) this.image,
      required this.latitude,
      required this.longitude});
  factory _BinRequest.fromJson(Map<String, dynamic> json) =>
      _$BinRequestFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final MultipartFile? image;
  @override
  final double latitude;
  @override
  final double longitude;

  /// Create a copy of BinRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BinRequestCopyWith<_BinRequest> get copyWith =>
      __$BinRequestCopyWithImpl<_BinRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BinRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BinRequest &&
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
    return 'BinRequest(image: $image, latitude: $latitude, longitude: $longitude)';
  }
}

/// @nodoc
abstract mixin class _$BinRequestCopyWith<$Res>
    implements $BinRequestCopyWith<$Res> {
  factory _$BinRequestCopyWith(
          _BinRequest value, $Res Function(_BinRequest) _then) =
      __$BinRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      MultipartFile? image,
      double latitude,
      double longitude});
}

/// @nodoc
class __$BinRequestCopyWithImpl<$Res> implements _$BinRequestCopyWith<$Res> {
  __$BinRequestCopyWithImpl(this._self, this._then);

  final _BinRequest _self;
  final $Res Function(_BinRequest) _then;

  /// Create a copy of BinRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? image = freezed,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_BinRequest(
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
