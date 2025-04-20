import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

@freezed
abstract class UserResponse with _$UserResponse {
  factory UserResponse({
    required int id,
    required String email,
    required String? nickname,
    required int? age,
    required String? gender,
    required String? country,
    required String? region,
    required String? role,
    required String? picture, // profile picture
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
