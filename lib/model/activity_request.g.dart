// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityRequest _$ActivityRequestFromJson(Map<String, dynamic> json) =>
    _ActivityRequest(
      userId: json['userId'] as String,
      activityRoute: (json['activityRoute'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
          .toList(),
      timeDuration: json['timeDuration'] as String,
      updatedDateTime: json['updatedDateTime'] as String,
      distanceMiles: (json['distanceMiles'] as num).toDouble(),
      trashCollectedCount: (json['trashCollectedCount'] as num).toInt(),
    );

Map<String, dynamic> _$ActivityRequestToJson(_ActivityRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'activityRoute': instance.activityRoute,
      'timeDuration': instance.timeDuration,
      'updatedDateTime': instance.updatedDateTime,
      'distanceMiles': instance.distanceMiles,
      'trashCollectedCount': instance.trashCollectedCount,
    };
