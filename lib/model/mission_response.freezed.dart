// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MissionResponse {
  String get partnerName;
  List<Mission> get partnerMissions;
  List<Mission> get myMissions;

  /// Create a copy of MissionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MissionResponseCopyWith<MissionResponse> get copyWith =>
      _$MissionResponseCopyWithImpl<MissionResponse>(
          this as MissionResponse, _$identity);

  /// Serializes this MissionResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MissionResponse &&
            (identical(other.partnerName, partnerName) ||
                other.partnerName == partnerName) &&
            const DeepCollectionEquality()
                .equals(other.partnerMissions, partnerMissions) &&
            const DeepCollectionEquality()
                .equals(other.myMissions, myMissions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      partnerName,
      const DeepCollectionEquality().hash(partnerMissions),
      const DeepCollectionEquality().hash(myMissions));

  @override
  String toString() {
    return 'MissionResponse(partnerName: $partnerName, partnerMissions: $partnerMissions, myMissions: $myMissions)';
  }
}

/// @nodoc
abstract mixin class $MissionResponseCopyWith<$Res> {
  factory $MissionResponseCopyWith(
          MissionResponse value, $Res Function(MissionResponse) _then) =
      _$MissionResponseCopyWithImpl;
  @useResult
  $Res call(
      {String partnerName,
      List<Mission> partnerMissions,
      List<Mission> myMissions});
}

/// @nodoc
class _$MissionResponseCopyWithImpl<$Res>
    implements $MissionResponseCopyWith<$Res> {
  _$MissionResponseCopyWithImpl(this._self, this._then);

  final MissionResponse _self;
  final $Res Function(MissionResponse) _then;

  /// Create a copy of MissionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partnerName = null,
    Object? partnerMissions = null,
    Object? myMissions = null,
  }) {
    return _then(_self.copyWith(
      partnerName: null == partnerName
          ? _self.partnerName
          : partnerName // ignore: cast_nullable_to_non_nullable
              as String,
      partnerMissions: null == partnerMissions
          ? _self.partnerMissions
          : partnerMissions // ignore: cast_nullable_to_non_nullable
              as List<Mission>,
      myMissions: null == myMissions
          ? _self.myMissions
          : myMissions // ignore: cast_nullable_to_non_nullable
              as List<Mission>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MissionResponse implements MissionResponse {
  const _MissionResponse(
      {required this.partnerName,
      required final List<Mission> partnerMissions,
      required final List<Mission> myMissions})
      : _partnerMissions = partnerMissions,
        _myMissions = myMissions;
  factory _MissionResponse.fromJson(Map<String, dynamic> json) =>
      _$MissionResponseFromJson(json);

  @override
  final String partnerName;
  final List<Mission> _partnerMissions;
  @override
  List<Mission> get partnerMissions {
    if (_partnerMissions is EqualUnmodifiableListView) return _partnerMissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_partnerMissions);
  }

  final List<Mission> _myMissions;
  @override
  List<Mission> get myMissions {
    if (_myMissions is EqualUnmodifiableListView) return _myMissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myMissions);
  }

  /// Create a copy of MissionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MissionResponseCopyWith<_MissionResponse> get copyWith =>
      __$MissionResponseCopyWithImpl<_MissionResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MissionResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MissionResponse &&
            (identical(other.partnerName, partnerName) ||
                other.partnerName == partnerName) &&
            const DeepCollectionEquality()
                .equals(other._partnerMissions, _partnerMissions) &&
            const DeepCollectionEquality()
                .equals(other._myMissions, _myMissions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      partnerName,
      const DeepCollectionEquality().hash(_partnerMissions),
      const DeepCollectionEquality().hash(_myMissions));

  @override
  String toString() {
    return 'MissionResponse(partnerName: $partnerName, partnerMissions: $partnerMissions, myMissions: $myMissions)';
  }
}

/// @nodoc
abstract mixin class _$MissionResponseCopyWith<$Res>
    implements $MissionResponseCopyWith<$Res> {
  factory _$MissionResponseCopyWith(
          _MissionResponse value, $Res Function(_MissionResponse) _then) =
      __$MissionResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String partnerName,
      List<Mission> partnerMissions,
      List<Mission> myMissions});
}

/// @nodoc
class __$MissionResponseCopyWithImpl<$Res>
    implements _$MissionResponseCopyWith<$Res> {
  __$MissionResponseCopyWithImpl(this._self, this._then);

  final _MissionResponse _self;
  final $Res Function(_MissionResponse) _then;

  /// Create a copy of MissionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? partnerName = null,
    Object? partnerMissions = null,
    Object? myMissions = null,
  }) {
    return _then(_MissionResponse(
      partnerName: null == partnerName
          ? _self.partnerName
          : partnerName // ignore: cast_nullable_to_non_nullable
              as String,
      partnerMissions: null == partnerMissions
          ? _self._partnerMissions
          : partnerMissions // ignore: cast_nullable_to_non_nullable
              as List<Mission>,
      myMissions: null == myMissions
          ? _self._myMissions
          : myMissions // ignore: cast_nullable_to_non_nullable
              as List<Mission>,
    ));
  }
}

// dart format on
