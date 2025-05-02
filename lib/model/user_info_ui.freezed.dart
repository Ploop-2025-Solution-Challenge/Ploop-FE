// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_ui.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserInfoUi {
  int get id;
  String? get nickname;
  String? get pictureUrl;

  /// Create a copy of UserInfoUi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserInfoUiCopyWith<UserInfoUi> get copyWith =>
      _$UserInfoUiCopyWithImpl<UserInfoUi>(this as UserInfoUi, _$identity);

  /// Serializes this UserInfoUi to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserInfoUi &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.pictureUrl, pictureUrl) ||
                other.pictureUrl == pictureUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nickname, pictureUrl);

  @override
  String toString() {
    return 'UserInfoUi(id: $id, nickname: $nickname, pictureUrl: $pictureUrl)';
  }
}

/// @nodoc
abstract mixin class $UserInfoUiCopyWith<$Res> {
  factory $UserInfoUiCopyWith(
          UserInfoUi value, $Res Function(UserInfoUi) _then) =
      _$UserInfoUiCopyWithImpl;
  @useResult
  $Res call({int id, String? nickname, String? pictureUrl});
}

/// @nodoc
class _$UserInfoUiCopyWithImpl<$Res> implements $UserInfoUiCopyWith<$Res> {
  _$UserInfoUiCopyWithImpl(this._self, this._then);

  final UserInfoUi _self;
  final $Res Function(UserInfoUi) _then;

  /// Create a copy of UserInfoUi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = freezed,
    Object? pictureUrl = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: freezed == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureUrl: freezed == pictureUrl
          ? _self.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UserInfoUi implements UserInfoUi {
  _UserInfoUi(
      {required this.id, required this.nickname, required this.pictureUrl});
  factory _UserInfoUi.fromJson(Map<String, dynamic> json) =>
      _$UserInfoUiFromJson(json);

  @override
  final int id;
  @override
  final String? nickname;
  @override
  final String? pictureUrl;

  /// Create a copy of UserInfoUi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserInfoUiCopyWith<_UserInfoUi> get copyWith =>
      __$UserInfoUiCopyWithImpl<_UserInfoUi>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserInfoUiToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserInfoUi &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.pictureUrl, pictureUrl) ||
                other.pictureUrl == pictureUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nickname, pictureUrl);

  @override
  String toString() {
    return 'UserInfoUi(id: $id, nickname: $nickname, pictureUrl: $pictureUrl)';
  }
}

/// @nodoc
abstract mixin class _$UserInfoUiCopyWith<$Res>
    implements $UserInfoUiCopyWith<$Res> {
  factory _$UserInfoUiCopyWith(
          _UserInfoUi value, $Res Function(_UserInfoUi) _then) =
      __$UserInfoUiCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String? nickname, String? pictureUrl});
}

/// @nodoc
class __$UserInfoUiCopyWithImpl<$Res> implements _$UserInfoUiCopyWith<$Res> {
  __$UserInfoUiCopyWithImpl(this._self, this._then);

  final _UserInfoUi _self;
  final $Res Function(_UserInfoUi) _then;

  /// Create a copy of UserInfoUi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? nickname = freezed,
    Object? pictureUrl = freezed,
  }) {
    return _then(_UserInfoUi(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: freezed == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureUrl: freezed == pictureUrl
          ? _self.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
