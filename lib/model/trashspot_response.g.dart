// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trashspot_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrashspotResponse _$TrashspotResponseFromJson(Map<String, dynamic> json) =>
    _TrashspotResponse(
      id: (json['id'] as num).toInt(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$TrashspotResponseToJson(_TrashspotResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
    };
