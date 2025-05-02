// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_ui.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserInfoUi _$UserInfoUiFromJson(Map<String, dynamic> json) => _UserInfoUi(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String?,
      pictureUrl: json['pictureUrl'] as String?,
    );

Map<String, dynamic> _$UserInfoUiToJson(_UserInfoUi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'pictureUrl': instance.pictureUrl,
    };
