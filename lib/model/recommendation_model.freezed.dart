// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Recommendation {
  @LatLngConverter()
  List<LatLng> get recommendationRoute;
  String get motivation;

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecommendationCopyWith<Recommendation> get copyWith =>
      _$RecommendationCopyWithImpl<Recommendation>(
          this as Recommendation, _$identity);

  /// Serializes this Recommendation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Recommendation &&
            const DeepCollectionEquality()
                .equals(other.recommendationRoute, recommendationRoute) &&
            (identical(other.motivation, motivation) ||
                other.motivation == motivation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(recommendationRoute), motivation);

  @override
  String toString() {
    return 'Recommendation(recommendationRoute: $recommendationRoute, motivation: $motivation)';
  }
}

/// @nodoc
abstract mixin class $RecommendationCopyWith<$Res> {
  factory $RecommendationCopyWith(
          Recommendation value, $Res Function(Recommendation) _then) =
      _$RecommendationCopyWithImpl;
  @useResult
  $Res call(
      {@LatLngConverter() List<LatLng> recommendationRoute, String motivation});
}

/// @nodoc
class _$RecommendationCopyWithImpl<$Res>
    implements $RecommendationCopyWith<$Res> {
  _$RecommendationCopyWithImpl(this._self, this._then);

  final Recommendation _self;
  final $Res Function(Recommendation) _then;

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recommendationRoute = null,
    Object? motivation = null,
  }) {
    return _then(_self.copyWith(
      recommendationRoute: null == recommendationRoute
          ? _self.recommendationRoute
          : recommendationRoute // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      motivation: null == motivation
          ? _self.motivation
          : motivation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Recommendation implements Recommendation {
  const _Recommendation(
      {@LatLngConverter() required final List<LatLng> recommendationRoute,
      required this.motivation})
      : _recommendationRoute = recommendationRoute;
  factory _Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);

  final List<LatLng> _recommendationRoute;
  @override
  @LatLngConverter()
  List<LatLng> get recommendationRoute {
    if (_recommendationRoute is EqualUnmodifiableListView)
      return _recommendationRoute;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendationRoute);
  }

  @override
  final String motivation;

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecommendationCopyWith<_Recommendation> get copyWith =>
      __$RecommendationCopyWithImpl<_Recommendation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecommendationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Recommendation &&
            const DeepCollectionEquality()
                .equals(other._recommendationRoute, _recommendationRoute) &&
            (identical(other.motivation, motivation) ||
                other.motivation == motivation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_recommendationRoute), motivation);

  @override
  String toString() {
    return 'Recommendation(recommendationRoute: $recommendationRoute, motivation: $motivation)';
  }
}

/// @nodoc
abstract mixin class _$RecommendationCopyWith<$Res>
    implements $RecommendationCopyWith<$Res> {
  factory _$RecommendationCopyWith(
          _Recommendation value, $Res Function(_Recommendation) _then) =
      __$RecommendationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@LatLngConverter() List<LatLng> recommendationRoute, String motivation});
}

/// @nodoc
class __$RecommendationCopyWithImpl<$Res>
    implements _$RecommendationCopyWith<$Res> {
  __$RecommendationCopyWithImpl(this._self, this._then);

  final _Recommendation _self;
  final $Res Function(_Recommendation) _then;

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? recommendationRoute = null,
    Object? motivation = null,
  }) {
    return _then(_Recommendation(
      recommendationRoute: null == recommendationRoute
          ? _self._recommendationRoute
          : recommendationRoute // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      motivation: null == motivation
          ? _self.motivation
          : motivation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
