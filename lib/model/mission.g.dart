// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Mission _$MissionFromJson(Map<String, dynamic> json) => _Mission(
      userMissionId: (json['userMissionId'] as num).toInt(),
      name: json['name'] as String,
      verified: json['verified'] as bool,
    );

Map<String, dynamic> _$MissionToJson(_Mission instance) => <String, dynamic>{
      'userMissionId': instance.userMissionId,
      'name': instance.name,
      'verified': instance.verified,
    };
