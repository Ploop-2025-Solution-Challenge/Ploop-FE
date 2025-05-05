import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

class LatLngConverter implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson(LatLng object) => {
        'latitude': object.latitude,
        'longitude': object.longitude,
      };
}

class LatLngListConverter
    implements JsonConverter<List<LatLng>, List<dynamic>> {
  const LatLngListConverter();

  @override
  List<LatLng> fromJson(List<dynamic> json) =>
      json.map((e) => const LatLngConverter().fromJson(e)).toList();

  @override
  List<dynamic> toJson(List<LatLng> object) =>
      object.map((e) => const LatLngConverter().toJson(e)).toList();
}
