// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RouteModel _$RouteModelFromJson(Map<String, dynamic> json) => _RouteModel(
      routeId: (json['routeId'] as num).toInt(),
      route: (json['activityRouteJson'] as List<dynamic>)
          .map((e) => const LatLngConverter().fromJson(e as List))
          .toList(),
      updatedDateTime: DateTime.parse(json['updatedDateTime'] as String),
    );

Map<String, dynamic> _$RouteModelToJson(_RouteModel instance) =>
    <String, dynamic>{
      'routeId': instance.routeId,
      'activityRouteJson':
          instance.route.map(const LatLngConverter().toJson).toList(),
      'updatedDateTime': instance.updatedDateTime.toIso8601String(),
    };
