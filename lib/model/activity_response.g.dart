// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GraphData _$GraphDataFromJson(Map<String, dynamic> json) => _GraphData(
      label: json['label'] as String,
      trashCount: (json['trashCount'] as num).toInt(),
    );

Map<String, dynamic> _$GraphDataToJson(_GraphData instance) =>
    <String, dynamic>{
      'label': instance.label,
      'trashCount': instance.trashCount,
    };

_ActivityResponse _$ActivityResponseFromJson(Map<String, dynamic> json) =>
    _ActivityResponse(
      totalTrash: (json['totalTrash'] as num).toInt(),
      totalMiles: (json['totalMiles'] as num).toDouble(),
      totalHours: (json['totalHours'] as num).toDouble(),
      challengeCompleted: (json['challengeCompleted'] as num).toInt(),
      challengeGoal: (json['challengeGoal'] as num).toInt(),
      graphData: (json['graphData'] as List<dynamic>)
          .map((e) => GraphData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActivityResponseToJson(_ActivityResponse instance) =>
    <String, dynamic>{
      'totalTrash': instance.totalTrash,
      'totalMiles': instance.totalMiles,
      'totalHours': instance.totalHours,
      'challengeCompleted': instance.challengeCompleted,
      'challengeGoal': instance.challengeGoal,
      'graphData': instance.graphData,
    };
