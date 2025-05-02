// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityRequest {
  String get userId;
  List<List<double>> get activityRoute;
  String get timeDuration;
  String get updatedDateTime;
  double get distanceMiles;
  int get trashCollectedCount;

  /// Create a copy of ActivityRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActivityRequestCopyWith<ActivityRequest> get copyWith =>
      _$ActivityRequestCopyWithImpl<ActivityRequest>(
          this as ActivityRequest, _$identity);

  /// Serializes this ActivityRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActivityRequest &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other.activityRoute, activityRoute) &&
            (identical(other.timeDuration, timeDuration) ||
                other.timeDuration == timeDuration) &&
            (identical(other.updatedDateTime, updatedDateTime) ||
                other.updatedDateTime == updatedDateTime) &&
            (identical(other.distanceMiles, distanceMiles) ||
                other.distanceMiles == distanceMiles) &&
            (identical(other.trashCollectedCount, trashCollectedCount) ||
                other.trashCollectedCount == trashCollectedCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      const DeepCollectionEquality().hash(activityRoute),
      timeDuration,
      updatedDateTime,
      distanceMiles,
      trashCollectedCount);

  @override
  String toString() {
    return 'ActivityRequest(userId: $userId, activityRoute: $activityRoute, timeDuration: $timeDuration, updatedDateTime: $updatedDateTime, distanceMiles: $distanceMiles, trashCollectedCount: $trashCollectedCount)';
  }
}

/// @nodoc
abstract mixin class $ActivityRequestCopyWith<$Res> {
  factory $ActivityRequestCopyWith(
          ActivityRequest value, $Res Function(ActivityRequest) _then) =
      _$ActivityRequestCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      List<List<double>> activityRoute,
      String timeDuration,
      String updatedDateTime,
      double distanceMiles,
      int trashCollectedCount});
}

/// @nodoc
class _$ActivityRequestCopyWithImpl<$Res>
    implements $ActivityRequestCopyWith<$Res> {
  _$ActivityRequestCopyWithImpl(this._self, this._then);

  final ActivityRequest _self;
  final $Res Function(ActivityRequest) _then;

  /// Create a copy of ActivityRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? activityRoute = null,
    Object? timeDuration = null,
    Object? updatedDateTime = null,
    Object? distanceMiles = null,
    Object? trashCollectedCount = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      activityRoute: null == activityRoute
          ? _self.activityRoute
          : activityRoute // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      timeDuration: null == timeDuration
          ? _self.timeDuration
          : timeDuration // ignore: cast_nullable_to_non_nullable
              as String,
      updatedDateTime: null == updatedDateTime
          ? _self.updatedDateTime
          : updatedDateTime // ignore: cast_nullable_to_non_nullable
              as String,
      distanceMiles: null == distanceMiles
          ? _self.distanceMiles
          : distanceMiles // ignore: cast_nullable_to_non_nullable
              as double,
      trashCollectedCount: null == trashCollectedCount
          ? _self.trashCollectedCount
          : trashCollectedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ActivityRequest implements ActivityRequest {
  const _ActivityRequest(
      {required this.userId,
      required final List<List<double>> activityRoute,
      required this.timeDuration,
      required this.updatedDateTime,
      required this.distanceMiles,
      required this.trashCollectedCount})
      : _activityRoute = activityRoute;
  factory _ActivityRequest.fromJson(Map<String, dynamic> json) =>
      _$ActivityRequestFromJson(json);

  @override
  final String userId;
  final List<List<double>> _activityRoute;
  @override
  List<List<double>> get activityRoute {
    if (_activityRoute is EqualUnmodifiableListView) return _activityRoute;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activityRoute);
  }

  @override
  final String timeDuration;
  @override
  final String updatedDateTime;
  @override
  final double distanceMiles;
  @override
  final int trashCollectedCount;

  /// Create a copy of ActivityRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActivityRequestCopyWith<_ActivityRequest> get copyWith =>
      __$ActivityRequestCopyWithImpl<_ActivityRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ActivityRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ActivityRequest &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._activityRoute, _activityRoute) &&
            (identical(other.timeDuration, timeDuration) ||
                other.timeDuration == timeDuration) &&
            (identical(other.updatedDateTime, updatedDateTime) ||
                other.updatedDateTime == updatedDateTime) &&
            (identical(other.distanceMiles, distanceMiles) ||
                other.distanceMiles == distanceMiles) &&
            (identical(other.trashCollectedCount, trashCollectedCount) ||
                other.trashCollectedCount == trashCollectedCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      const DeepCollectionEquality().hash(_activityRoute),
      timeDuration,
      updatedDateTime,
      distanceMiles,
      trashCollectedCount);

  @override
  String toString() {
    return 'ActivityRequest(userId: $userId, activityRoute: $activityRoute, timeDuration: $timeDuration, updatedDateTime: $updatedDateTime, distanceMiles: $distanceMiles, trashCollectedCount: $trashCollectedCount)';
  }
}

/// @nodoc
abstract mixin class _$ActivityRequestCopyWith<$Res>
    implements $ActivityRequestCopyWith<$Res> {
  factory _$ActivityRequestCopyWith(
          _ActivityRequest value, $Res Function(_ActivityRequest) _then) =
      __$ActivityRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      List<List<double>> activityRoute,
      String timeDuration,
      String updatedDateTime,
      double distanceMiles,
      int trashCollectedCount});
}

/// @nodoc
class __$ActivityRequestCopyWithImpl<$Res>
    implements _$ActivityRequestCopyWith<$Res> {
  __$ActivityRequestCopyWithImpl(this._self, this._then);

  final _ActivityRequest _self;
  final $Res Function(_ActivityRequest) _then;

  /// Create a copy of ActivityRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? activityRoute = null,
    Object? timeDuration = null,
    Object? updatedDateTime = null,
    Object? distanceMiles = null,
    Object? trashCollectedCount = null,
  }) {
    return _then(_ActivityRequest(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      activityRoute: null == activityRoute
          ? _self._activityRoute
          : activityRoute // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      timeDuration: null == timeDuration
          ? _self.timeDuration
          : timeDuration // ignore: cast_nullable_to_non_nullable
              as String,
      updatedDateTime: null == updatedDateTime
          ? _self.updatedDateTime
          : updatedDateTime // ignore: cast_nullable_to_non_nullable
              as String,
      distanceMiles: null == distanceMiles
          ? _self.distanceMiles
          : distanceMiles // ignore: cast_nullable_to_non_nullable
              as double,
      trashCollectedCount: null == trashCollectedCount
          ? _self.trashCollectedCount
          : trashCollectedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
