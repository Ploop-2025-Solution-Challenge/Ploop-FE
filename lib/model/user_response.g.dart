// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserResponse _$UserResponseFromJson(Map<String, dynamic> json) =>
    _UserResponse(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      nickname: json['nickname'] as String?,
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      country: json['country'] as String?,
      region: json['region'] as String?,
      role: json['role'] as String?,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(_UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'age': instance.age,
      'gender': instance.gender,
      'country': instance.country,
      'region': instance.region,
      'role': instance.role,
      'picture': instance.picture,
    };
