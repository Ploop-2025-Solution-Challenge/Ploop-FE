// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jwt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthToken {
  String? get jwt;

  /// Create a copy of AuthToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthTokenCopyWith<AuthToken> get copyWith =>
      _$AuthTokenCopyWithImpl<AuthToken>(this as AuthToken, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthToken &&
            (identical(other.jwt, jwt) || other.jwt == jwt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, jwt);

  @override
  String toString() {
    return 'AuthToken(jwt: $jwt)';
  }
}

/// @nodoc
abstract mixin class $AuthTokenCopyWith<$Res> {
  factory $AuthTokenCopyWith(AuthToken value, $Res Function(AuthToken) _then) =
      _$AuthTokenCopyWithImpl;
  @useResult
  $Res call({String? jwt});
}

/// @nodoc
class _$AuthTokenCopyWithImpl<$Res> implements $AuthTokenCopyWith<$Res> {
  _$AuthTokenCopyWithImpl(this._self, this._then);

  final AuthToken _self;
  final $Res Function(AuthToken) _then;

  /// Create a copy of AuthToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jwt = freezed,
  }) {
    return _then(_self.copyWith(
      jwt: freezed == jwt
          ? _self.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _AuthToken implements AuthToken {
  _AuthToken({required this.jwt});

  @override
  final String? jwt;

  /// Create a copy of AuthToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthTokenCopyWith<_AuthToken> get copyWith =>
      __$AuthTokenCopyWithImpl<_AuthToken>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthToken &&
            (identical(other.jwt, jwt) || other.jwt == jwt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, jwt);

  @override
  String toString() {
    return 'AuthToken(jwt: $jwt)';
  }
}

/// @nodoc
abstract mixin class _$AuthTokenCopyWith<$Res>
    implements $AuthTokenCopyWith<$Res> {
  factory _$AuthTokenCopyWith(
          _AuthToken value, $Res Function(_AuthToken) _then) =
      __$AuthTokenCopyWithImpl;
  @override
  @useResult
  $Res call({String? jwt});
}

/// @nodoc
class __$AuthTokenCopyWithImpl<$Res> implements _$AuthTokenCopyWith<$Res> {
  __$AuthTokenCopyWithImpl(this._self, this._then);

  final _AuthToken _self;
  final $Res Function(_AuthToken) _then;

  /// Create a copy of AuthToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? jwt = freezed,
  }) {
    return _then(_AuthToken(
      jwt: freezed == jwt
          ? _self.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
