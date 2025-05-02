// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MissionResponse _$MissionResponseFromJson(Map<String, dynamic> json) =>
    _MissionResponse(
      partnerName: json['partnerName'] as String,
      partnerMissions: (json['partnerMissions'] as List<dynamic>)
          .map((e) => Mission.fromJson(e as Map<String, dynamic>))
          .toList(),
      myMissions: (json['myMissions'] as List<dynamic>)
          .map((e) => Mission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MissionResponseToJson(_MissionResponse instance) =>
    <String, dynamic>{
      'partnerName': instance.partnerName,
      'partnerMissions': instance.partnerMissions,
      'myMissions': instance.myMissions,
    };
