// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BinRequest _$BinRequestFromJson(Map<String, dynamic> json) => _BinRequest(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$BinRequestToJson(_BinRequest instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
