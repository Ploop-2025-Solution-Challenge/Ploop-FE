// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserRequest _$UserRequestFromJson(Map<String, dynamic> json) => _UserRequest(
      nickname: json['nickname'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      country: json['country'] as String,
      difficulty: json['difficulty'] as String,
      motivation: json['motivation'] as String,
      preferredArea: (json['preferredArea'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserRequestToJson(_UserRequest instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'age': instance.age,
      'gender': instance.gender,
      'country': instance.country,
      'difficulty': instance.difficulty,
      'motivation': instance.motivation,
      'preferredArea': instance.preferredArea,
    };
