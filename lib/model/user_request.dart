import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_request.freezed.dart';
part 'user_request.g.dart';

@freezed
abstract class UserRequest with _$UserRequest {
  const factory UserRequest({
    required String nickname,
    required int age,
    required String gender,
    required String country,
    // required String region,
    required String difficulty,
    required String motivation,
    required List<String> preferredArea,
  }) = _UserRequest;

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);
}
