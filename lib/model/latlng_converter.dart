import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

class LatLngConverter implements JsonConverter<LatLng, List<dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(List<dynamic> json) {
    if (json.length >= 2) {
      return LatLng(
        (json[0] as num).toDouble(), // lat
        (json[1] as num).toDouble(), // lng
      );
    }
    return const LatLng(0, 0);
  }

  @override
  List<dynamic> toJson(LatLng object) => [
        object.latitude,
        object.longitude,
      ];
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
