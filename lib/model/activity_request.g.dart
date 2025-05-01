// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityRequest _$ActivityRequestFromJson(Map<String, dynamic> json) =>
    _ActivityRequest(
      userId: json['userId'] as String,
      activityRoute: (json['activityRoute'] as List<dynamic>)
          .map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  ($jsonValue[r'$1'] as num).toDouble(),
                  ($jsonValue[r'$2'] as num).toDouble(),
                ),
              ))
          .toList(),
      timeDuration: json['timeDuration'] as String,
      updatedDateTime: json['updatedDateTime'] as String,
      distanceMiles: (json['distanceMiles'] as num).toDouble(),
      trashCollectedCount: (json['trashCollectedCount'] as num).toInt(),
    );

Map<String, dynamic> _$ActivityRequestToJson(_ActivityRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'activityRoute': instance.activityRoute
          .map((e) => <String, dynamic>{
                r'$1': e.$1,
                r'$2': e.$2,
              })
          .toList(),
      'timeDuration': instance.timeDuration,
      'updatedDateTime': instance.updatedDateTime,
      'distanceMiles': instance.distanceMiles,
      'trashCollectedCount': instance.trashCollectedCount,
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
