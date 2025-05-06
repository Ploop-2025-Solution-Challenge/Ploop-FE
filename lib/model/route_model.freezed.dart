// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RouteModel {
  int get routeId;
  @LatLngConverter()
  List<LatLng> get activityRoute;
  DateTime get updatedDateTime;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RouteModelCopyWith<RouteModel> get copyWith =>
      _$RouteModelCopyWithImpl<RouteModel>(this as RouteModel, _$identity);

  /// Serializes this RouteModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RouteModel &&
            (identical(other.routeId, routeId) || other.routeId == routeId) &&
            const DeepCollectionEquality()
                .equals(other.activityRoute, activityRoute) &&
            (identical(other.updatedDateTime, updatedDateTime) ||
                other.updatedDateTime == updatedDateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, routeId,
      const DeepCollectionEquality().hash(activityRoute), updatedDateTime);

  @override
  String toString() {
    return 'RouteModel(routeId: $routeId, activityRoute: $activityRoute, updatedDateTime: $updatedDateTime)';
  }
}

/// @nodoc
abstract mixin class $RouteModelCopyWith<$Res> {
  factory $RouteModelCopyWith(
          RouteModel value, $Res Function(RouteModel) _then) =
      _$RouteModelCopyWithImpl;
  @useResult
  $Res call(
      {int routeId,
      @LatLngConverter() List<LatLng> activityRoute,
      DateTime updatedDateTime});
}

/// @nodoc
class _$RouteModelCopyWithImpl<$Res> implements $RouteModelCopyWith<$Res> {
  _$RouteModelCopyWithImpl(this._self, this._then);

  final RouteModel _self;
  final $Res Function(RouteModel) _then;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeId = null,
    Object? activityRoute = null,
    Object? updatedDateTime = null,
  }) {
    return _then(_self.copyWith(
      routeId: null == routeId
          ? _self.routeId
          : routeId // ignore: cast_nullable_to_non_nullable
              as int,
      activityRoute: null == activityRoute
          ? _self.activityRoute
          : activityRoute // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      updatedDateTime: null == updatedDateTime
          ? _self.updatedDateTime
          : updatedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _RouteModel implements RouteModel {
  _RouteModel(
      {required this.routeId,
      @LatLngConverter() required final List<LatLng> activityRoute,
      required this.updatedDateTime})
      : _activityRoute = activityRoute;
  factory _RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);

  @override
  final int routeId;
  final List<LatLng> _activityRoute;
  @override
  @LatLngConverter()
  List<LatLng> get activityRoute {
    if (_activityRoute is EqualUnmodifiableListView) return _activityRoute;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activityRoute);
  }

  @override
  final DateTime updatedDateTime;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RouteModelCopyWith<_RouteModel> get copyWith =>
      __$RouteModelCopyWithImpl<_RouteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RouteModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RouteModel &&
            (identical(other.routeId, routeId) || other.routeId == routeId) &&
            const DeepCollectionEquality()
                .equals(other._activityRoute, _activityRoute) &&
            (identical(other.updatedDateTime, updatedDateTime) ||
                other.updatedDateTime == updatedDateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, routeId,
      const DeepCollectionEquality().hash(_activityRoute), updatedDateTime);

  @override
  String toString() {
    return 'RouteModel(routeId: $routeId, activityRoute: $activityRoute, updatedDateTime: $updatedDateTime)';
  }
}

/// @nodoc
abstract mixin class _$RouteModelCopyWith<$Res>
    implements $RouteModelCopyWith<$Res> {
  factory _$RouteModelCopyWith(
          _RouteModel value, $Res Function(_RouteModel) _then) =
      __$RouteModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int routeId,
      @LatLngConverter() List<LatLng> activityRoute,
      DateTime updatedDateTime});
}

/// @nodoc
class __$RouteModelCopyWithImpl<$Res> implements _$RouteModelCopyWith<$Res> {
  __$RouteModelCopyWithImpl(this._self, this._then);

  final _RouteModel _self;
  final $Res Function(_RouteModel) _then;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? routeId = null,
    Object? activityRoute = null,
    Object? updatedDateTime = null,
  }) {
    return _then(_RouteModel(
      routeId: null == routeId
          ? _self.routeId
          : routeId // ignore: cast_nullable_to_non_nullable
              as int,
      activityRoute: null == activityRoute
          ? _self._activityRoute
          : activityRoute // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      updatedDateTime: null == updatedDateTime
          ? _self.updatedDateTime
          : updatedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
