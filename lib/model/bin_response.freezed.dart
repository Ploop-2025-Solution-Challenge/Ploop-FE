// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bin_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BinResponse {
  int get id;
  double get latitude;
  double get longitude;

  /// Create a copy of BinResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BinResponseCopyWith<BinResponse> get copyWith =>
      _$BinResponseCopyWithImpl<BinResponse>(this as BinResponse, _$identity);

  /// Serializes this BinResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BinResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, latitude, longitude);

  @override
  String toString() {
    return 'BinResponse(id: $id, latitude: $latitude, longitude: $longitude)';
  }
}

/// @nodoc
abstract mixin class $BinResponseCopyWith<$Res> {
  factory $BinResponseCopyWith(
          BinResponse value, $Res Function(BinResponse) _then) =
      _$BinResponseCopyWithImpl;
  @useResult
  $Res call({int id, double latitude, double longitude});
}

/// @nodoc
class _$BinResponseCopyWithImpl<$Res> implements $BinResponseCopyWith<$Res> {
  _$BinResponseCopyWithImpl(this._self, this._then);

  final BinResponse _self;
  final $Res Function(BinResponse) _then;

  /// Create a copy of BinResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latitude = null,
    Object? longitude = null,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _BinResponse implements BinResponse {
  const _BinResponse(
      {required this.id, required this.latitude, required this.longitude});
  factory _BinResponse.fromJson(Map<String, dynamic> json) =>
      _$BinResponseFromJson(json);

  @override
  final int id;
  @override
  final double latitude;
  @override
  final double longitude;

  /// Create a copy of BinResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BinResponseCopyWith<_BinResponse> get copyWith =>
      __$BinResponseCopyWithImpl<_BinResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BinResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BinResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, latitude, longitude);

  @override
  String toString() {
    return 'BinResponse(id: $id, latitude: $latitude, longitude: $longitude)';
  }
}

/// @nodoc
abstract mixin class _$BinResponseCopyWith<$Res>
    implements $BinResponseCopyWith<$Res> {
  factory _$BinResponseCopyWith(
          _BinResponse value, $Res Function(_BinResponse) _then) =
      __$BinResponseCopyWithImpl;
  @override
  @useResult
  $Res call({int id, double latitude, double longitude});
}

/// @nodoc
class __$BinResponseCopyWithImpl<$Res> implements _$BinResponseCopyWith<$Res> {
  __$BinResponseCopyWithImpl(this._self, this._then);

  final _BinResponse _self;
  final $Res Function(_BinResponse) _then;

  /// Create a copy of BinResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_BinResponse(
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
    ));
  }
}

// dart format on
