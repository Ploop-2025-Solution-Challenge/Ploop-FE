import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'latlng_converter.dart';
import 'package:intl/intl.dart';

part 'route_model.freezed.dart';
part 'route_model.g.dart';

@freezed
abstract class RouteModel with _$RouteModel {
  factory RouteModel({
    required int routeId,
    @LatLngConverter() required List<LatLng> activityRoute,
    required DateTime updatedDateTime,
  }) = _RouteModel;

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);
}

extension RouteModelExtension on RouteModel {
  // format
  String fUpdateDateTime() {
    // format: "dd.mm.yyyy - hh:mm AM/PM"
    return DateFormat('dd.MM.y - hh:mm a').format(updatedDateTime);
  }

  LatLngBounds? createLatLngBounds() {
    double south = activityRoute.first.latitude;
    double north = activityRoute.first.latitude;
    double west = activityRoute.first.longitude;
    double east = activityRoute.first.longitude;

    for (final point in activityRoute) {
      south = point.latitude < south ? point.latitude : south;
      north = point.latitude > north ? point.latitude : north;
      west = point.longitude < west ? point.longitude : west;
      east = point.longitude > east ? point.longitude : east;
    }

    final routeBound = LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );

    return routeBound;
  }

  // make proper zoom to show route in a view
  double getBoundsZoom() {
    final routeBound = createLatLngBounds();
    if (routeBound != null) {
      final latDiff =
          (routeBound.northeast.latitude - routeBound.southwest.latitude).abs();
      final lngDiff =
          (routeBound.northeast.longitude - routeBound.southwest.longitude)
              .abs();

      final maxDiff = latDiff > lngDiff ? latDiff : lngDiff;

      debugPrint('maxDiff: $maxDiff');

      if (maxDiff < 0.005) return 16;
      if (maxDiff < 0.01) return 15;
      if (maxDiff < 0.025) return 14.5;
      if (maxDiff < 0.05) return 13;
      if (maxDiff < 0.075) return 12.5;
      if (maxDiff < 0.1) return 12;
      if (maxDiff < 0.15) return 11.5;
      // if (maxDiff < 0.2) return 11.5;
      if (maxDiff < 0.5) return 10.5;
      if (maxDiff < 1) return 8;
      if (maxDiff < 2) return 7;
      return 6;
    } else {
      debugPrint("routeBound is null at RouteModel.getBoundsZoom()");
      throw Error();
    }
  }

  LatLng getCenter() {
    final routeBound = createLatLngBounds();
    if (routeBound != null) {
      return LatLng(
        (routeBound.northeast.latitude + routeBound.southwest.latitude) / 2,
        (routeBound.northeast.longitude + routeBound.southwest.longitude) / 2,
      );
    } else {
      debugPrint("routeBound is null at RouteModel.getCenter()");
      throw Error(); // error
    }
  }
}
