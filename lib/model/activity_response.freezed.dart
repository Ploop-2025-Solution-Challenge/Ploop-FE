// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GraphData {
  String get label;
  int get trashCount;

  /// Create a copy of GraphData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GraphDataCopyWith<GraphData> get copyWith =>
      _$GraphDataCopyWithImpl<GraphData>(this as GraphData, _$identity);

  /// Serializes this GraphData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GraphData &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.trashCount, trashCount) ||
                other.trashCount == trashCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, trashCount);

  @override
  String toString() {
    return 'GraphData(label: $label, trashCount: $trashCount)';
  }
}

/// @nodoc
abstract mixin class $GraphDataCopyWith<$Res> {
  factory $GraphDataCopyWith(GraphData value, $Res Function(GraphData) _then) =
      _$GraphDataCopyWithImpl;
  @useResult
  $Res call({String label, int trashCount});
}

/// @nodoc
class _$GraphDataCopyWithImpl<$Res> implements $GraphDataCopyWith<$Res> {
  _$GraphDataCopyWithImpl(this._self, this._then);

  final GraphData _self;
  final $Res Function(GraphData) _then;

  /// Create a copy of GraphData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? trashCount = null,
  }) {
    return _then(_self.copyWith(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      trashCount: null == trashCount
          ? _self.trashCount
          : trashCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GraphData implements GraphData {
  const _GraphData({required this.label, required this.trashCount});
  factory _GraphData.fromJson(Map<String, dynamic> json) =>
      _$GraphDataFromJson(json);

  @override
  final String label;
  @override
  final int trashCount;

  /// Create a copy of GraphData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GraphDataCopyWith<_GraphData> get copyWith =>
      __$GraphDataCopyWithImpl<_GraphData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GraphDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GraphData &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.trashCount, trashCount) ||
                other.trashCount == trashCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, trashCount);

  @override
  String toString() {
    return 'GraphData(label: $label, trashCount: $trashCount)';
  }
}

/// @nodoc
abstract mixin class _$GraphDataCopyWith<$Res>
    implements $GraphDataCopyWith<$Res> {
  factory _$GraphDataCopyWith(
          _GraphData value, $Res Function(_GraphData) _then) =
      __$GraphDataCopyWithImpl;
  @override
  @useResult
  $Res call({String label, int trashCount});
}

/// @nodoc
class __$GraphDataCopyWithImpl<$Res> implements _$GraphDataCopyWith<$Res> {
  __$GraphDataCopyWithImpl(this._self, this._then);

  final _GraphData _self;
  final $Res Function(_GraphData) _then;

  /// Create a copy of GraphData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = null,
    Object? trashCount = null,
  }) {
    return _then(_GraphData(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      trashCount: null == trashCount
          ? _self.trashCount
          : trashCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$ActivityResponse {
  int get totalTrash;
  double get totalMiles;
  double get totalHours;
  int get challengeCompleted;
  int get challengeGoal;
  List<GraphData> get graphData;

  /// Create a copy of ActivityResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActivityResponseCopyWith<ActivityResponse> get copyWith =>
      _$ActivityResponseCopyWithImpl<ActivityResponse>(
          this as ActivityResponse, _$identity);

  /// Serializes this ActivityResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActivityResponse &&
            (identical(other.totalTrash, totalTrash) ||
                other.totalTrash == totalTrash) &&
            (identical(other.totalMiles, totalMiles) ||
                other.totalMiles == totalMiles) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours) &&
            (identical(other.challengeCompleted, challengeCompleted) ||
                other.challengeCompleted == challengeCompleted) &&
            (identical(other.challengeGoal, challengeGoal) ||
                other.challengeGoal == challengeGoal) &&
            const DeepCollectionEquality().equals(other.graphData, graphData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalTrash,
      totalMiles,
      totalHours,
      challengeCompleted,
      challengeGoal,
      const DeepCollectionEquality().hash(graphData));

  @override
  String toString() {
    return 'ActivityResponse(totalTrash: $totalTrash, totalMiles: $totalMiles, totalHours: $totalHours, challengeCompleted: $challengeCompleted, challengeGoal: $challengeGoal, graphData: $graphData)';
  }
}

/// @nodoc
abstract mixin class $ActivityResponseCopyWith<$Res> {
  factory $ActivityResponseCopyWith(
          ActivityResponse value, $Res Function(ActivityResponse) _then) =
      _$ActivityResponseCopyWithImpl;
  @useResult
  $Res call(
      {int totalTrash,
      double totalMiles,
      double totalHours,
      int challengeCompleted,
      int challengeGoal,
      List<GraphData> graphData});
}

/// @nodoc
class _$ActivityResponseCopyWithImpl<$Res>
    implements $ActivityResponseCopyWith<$Res> {
  _$ActivityResponseCopyWithImpl(this._self, this._then);

  final ActivityResponse _self;
  final $Res Function(ActivityResponse) _then;

  /// Create a copy of ActivityResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTrash = null,
    Object? totalMiles = null,
    Object? totalHours = null,
    Object? challengeCompleted = null,
    Object? challengeGoal = null,
    Object? graphData = null,
  }) {
    return _then(_self.copyWith(
      totalTrash: null == totalTrash
          ? _self.totalTrash
          : totalTrash // ignore: cast_nullable_to_non_nullable
              as int,
      totalMiles: null == totalMiles
          ? _self.totalMiles
          : totalMiles // ignore: cast_nullable_to_non_nullable
              as double,
      totalHours: null == totalHours
          ? _self.totalHours
          : totalHours // ignore: cast_nullable_to_non_nullable
              as double,
      challengeCompleted: null == challengeCompleted
          ? _self.challengeCompleted
          : challengeCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      challengeGoal: null == challengeGoal
          ? _self.challengeGoal
          : challengeGoal // ignore: cast_nullable_to_non_nullable
              as int,
      graphData: null == graphData
          ? _self.graphData
          : graphData // ignore: cast_nullable_to_non_nullable
              as List<GraphData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ActivityResponse implements ActivityResponse {
  const _ActivityResponse(
      {required this.totalTrash,
      required this.totalMiles,
      required this.totalHours,
      required this.challengeCompleted,
      required this.challengeGoal,
      required final List<GraphData> graphData})
      : _graphData = graphData;
  factory _ActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityResponseFromJson(json);

  @override
  final int totalTrash;
  @override
  final double totalMiles;
  @override
  final double totalHours;
  @override
  final int challengeCompleted;
  @override
  final int challengeGoal;
  final List<GraphData> _graphData;
  @override
  List<GraphData> get graphData {
    if (_graphData is EqualUnmodifiableListView) return _graphData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_graphData);
  }

  /// Create a copy of ActivityResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActivityResponseCopyWith<_ActivityResponse> get copyWith =>
      __$ActivityResponseCopyWithImpl<_ActivityResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ActivityResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ActivityResponse &&
            (identical(other.totalTrash, totalTrash) ||
                other.totalTrash == totalTrash) &&
            (identical(other.totalMiles, totalMiles) ||
                other.totalMiles == totalMiles) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours) &&
            (identical(other.challengeCompleted, challengeCompleted) ||
                other.challengeCompleted == challengeCompleted) &&
            (identical(other.challengeGoal, challengeGoal) ||
                other.challengeGoal == challengeGoal) &&
            const DeepCollectionEquality()
                .equals(other._graphData, _graphData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalTrash,
      totalMiles,
      totalHours,
      challengeCompleted,
      challengeGoal,
      const DeepCollectionEquality().hash(_graphData));

  @override
  String toString() {
    return 'ActivityResponse(totalTrash: $totalTrash, totalMiles: $totalMiles, totalHours: $totalHours, challengeCompleted: $challengeCompleted, challengeGoal: $challengeGoal, graphData: $graphData)';
  }
}

/// @nodoc
abstract mixin class _$ActivityResponseCopyWith<$Res>
    implements $ActivityResponseCopyWith<$Res> {
  factory _$ActivityResponseCopyWith(
          _ActivityResponse value, $Res Function(_ActivityResponse) _then) =
      __$ActivityResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int totalTrash,
      double totalMiles,
      double totalHours,
      int challengeCompleted,
      int challengeGoal,
      List<GraphData> graphData});
}

/// @nodoc
class __$ActivityResponseCopyWithImpl<$Res>
    implements _$ActivityResponseCopyWith<$Res> {
  __$ActivityResponseCopyWithImpl(this._self, this._then);

  final _ActivityResponse _self;
  final $Res Function(_ActivityResponse) _then;

  /// Create a copy of ActivityResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalTrash = null,
    Object? totalMiles = null,
    Object? totalHours = null,
    Object? challengeCompleted = null,
    Object? challengeGoal = null,
    Object? graphData = null,
  }) {
    return _then(_ActivityResponse(
      totalTrash: null == totalTrash
          ? _self.totalTrash
          : totalTrash // ignore: cast_nullable_to_non_nullable
              as int,
      totalMiles: null == totalMiles
          ? _self.totalMiles
          : totalMiles // ignore: cast_nullable_to_non_nullable
              as double,
      totalHours: null == totalHours
          ? _self.totalHours
          : totalHours // ignore: cast_nullable_to_non_nullable
              as double,
      challengeCompleted: null == challengeCompleted
          ? _self.challengeCompleted
          : challengeCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      challengeGoal: null == challengeGoal
          ? _self.challengeGoal
          : challengeGoal // ignore: cast_nullable_to_non_nullable
              as int,
      graphData: null == graphData
          ? _self._graphData
          : graphData // ignore: cast_nullable_to_non_nullable
              as List<GraphData>,
    ));
  }
}

// dart format on
