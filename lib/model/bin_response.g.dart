// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BinResponse _$BinResponseFromJson(Map<String, dynamic> json) => _BinResponse(
      id: (json['id'] as num).toInt(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$BinResponseToJson(_BinResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
    };
