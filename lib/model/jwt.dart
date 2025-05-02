import 'package:freezed_annotation/freezed_annotation.dart';

part 'jwt.freezed.dart';

@freezed
abstract class AuthToken with _$AuthToken {
  factory AuthToken({
    required String? jwt,
  }) = _AuthToken;
}
