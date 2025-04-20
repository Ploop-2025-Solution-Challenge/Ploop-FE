// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserRequest {
  String get nickname;
  int get age;
  String get gender;
  String get country;
  String get region;
  String get difficulty;
  String get motivation;
  List<String> get preferredArea;

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserRequestCopyWith<UserRequest> get copyWith =>
      _$UserRequestCopyWithImpl<UserRequest>(this as UserRequest, _$identity);

  /// Serializes this UserRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserRequest &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.motivation, motivation) ||
                other.motivation == motivation) &&
            const DeepCollectionEquality()
                .equals(other.preferredArea, preferredArea));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nickname,
      age,
      gender,
      country,
      region,
      difficulty,
      motivation,
      const DeepCollectionEquality().hash(preferredArea));

  @override
  String toString() {
    return 'UserRequest(nickname: $nickname, age: $age, gender: $gender, country: $country, region: $region, difficulty: $difficulty, motivation: $motivation, preferredArea: $preferredArea)';
  }
}

/// @nodoc
abstract mixin class $UserRequestCopyWith<$Res> {
  factory $UserRequestCopyWith(
          UserRequest value, $Res Function(UserRequest) _then) =
      _$UserRequestCopyWithImpl;
  @useResult
  $Res call(
      {String nickname,
      int age,
      String gender,
      String country,
      String region,
      String difficulty,
      String motivation,
      List<String> preferredArea});
}

/// @nodoc
class _$UserRequestCopyWithImpl<$Res> implements $UserRequestCopyWith<$Res> {
  _$UserRequestCopyWithImpl(this._self, this._then);

  final UserRequest _self;
  final $Res Function(UserRequest) _then;

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? age = null,
    Object? gender = null,
    Object? country = null,
    Object? region = null,
    Object? difficulty = null,
    Object? motivation = null,
    Object? preferredArea = null,
  }) {
    return _then(_self.copyWith(
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _self.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _self.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      motivation: null == motivation
          ? _self.motivation
          : motivation // ignore: cast_nullable_to_non_nullable
              as String,
      preferredArea: null == preferredArea
          ? _self.preferredArea
          : preferredArea // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UserRequest implements UserRequest {
  const _UserRequest(
      {required this.nickname,
      required this.age,
      required this.gender,
      required this.country,
      required this.region,
      required this.difficulty,
      required this.motivation,
      required final List<String> preferredArea})
      : _preferredArea = preferredArea;
  factory _UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);

  @override
  final String nickname;
  @override
  final int age;
  @override
  final String gender;
  @override
  final String country;
  @override
  final String region;
  @override
  final String difficulty;
  @override
  final String motivation;
  final List<String> _preferredArea;
  @override
  List<String> get preferredArea {
    if (_preferredArea is EqualUnmodifiableListView) return _preferredArea;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredArea);
  }

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserRequestCopyWith<_UserRequest> get copyWith =>
      __$UserRequestCopyWithImpl<_UserRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserRequest &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.motivation, motivation) ||
                other.motivation == motivation) &&
            const DeepCollectionEquality()
                .equals(other._preferredArea, _preferredArea));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nickname,
      age,
      gender,
      country,
      region,
      difficulty,
      motivation,
      const DeepCollectionEquality().hash(_preferredArea));

  @override
  String toString() {
    return 'UserRequest(nickname: $nickname, age: $age, gender: $gender, country: $country, region: $region, difficulty: $difficulty, motivation: $motivation, preferredArea: $preferredArea)';
  }
}

/// @nodoc
abstract mixin class _$UserRequestCopyWith<$Res>
    implements $UserRequestCopyWith<$Res> {
  factory _$UserRequestCopyWith(
          _UserRequest value, $Res Function(_UserRequest) _then) =
      __$UserRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String nickname,
      int age,
      String gender,
      String country,
      String region,
      String difficulty,
      String motivation,
      List<String> preferredArea});
}

/// @nodoc
class __$UserRequestCopyWithImpl<$Res> implements _$UserRequestCopyWith<$Res> {
  __$UserRequestCopyWithImpl(this._self, this._then);

  final _UserRequest _self;
  final $Res Function(_UserRequest) _then;

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nickname = null,
    Object? age = null,
    Object? gender = null,
    Object? country = null,
    Object? region = null,
    Object? difficulty = null,
    Object? motivation = null,
    Object? preferredArea = null,
  }) {
    return _then(_UserRequest(
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _self.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _self.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      motivation: null == motivation
          ? _self.motivation
          : motivation // ignore: cast_nullable_to_non_nullable
              as String,
      preferredArea: null == preferredArea
          ? _self._preferredArea
          : preferredArea // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
