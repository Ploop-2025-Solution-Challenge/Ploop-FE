// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trashspot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrashspotRequest _$TrashspotRequestFromJson(Map<String, dynamic> json) =>
    _TrashspotRequest(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$TrashspotRequestToJson(_TrashspotRequest instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
