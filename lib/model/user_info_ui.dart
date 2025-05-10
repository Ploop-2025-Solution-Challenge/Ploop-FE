import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_ui.freezed.dart';
part 'user_info_ui.g.dart';

@freezed
abstract class UserInfoUi with _$UserInfoUi {
  factory UserInfoUi({
    required int id,
    required String? nickname,
    required String? pictureUrl, // profile picture
  }) = _UserInfoUi;

  factory UserInfoUi.fromJson(Map<String, dynamic> json) =>
      _$UserInfoUiFromJson(json);
}
