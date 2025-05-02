import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

// temporary model
class RouteModel {
  RouteModel(
      {required this.routeId,
      required this.route,
      required this.userId,
      required this.updatedDateTime});

  final String routeId;
  final String userId;
  final List<LatLng> route;
  LatLngBounds? routeBound;
  final DateTime updatedDateTime;

  // format
  String fUpdateDateTime() {
    // format: "dd.mm.yyyy - hh:mm AM/PM"
    // DateFormat('dd.MM.y - hh:mm a').format(DateTime(2025, 4, 7, 08, 16));
    return DateFormat('dd.MM.y - hh:mm a').format(updatedDateTime);
  }

  LatLngBounds? createLatLngBounds() {
    double south = route.first.latitude;
    double north = route.first.latitude;
    double west = route.first.longitude;
    double east = route.first.longitude;

    for (var point in route) {
      if (point.latitude < south) south = point.latitude;
      if (point.latitude > north) north = point.latitude;
      if (point.longitude < west) west = point.longitude;
      if (point.longitude > east) east = point.longitude;
    }

    routeBound = LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );

    return routeBound!;
  }

  // make proper zoom to show route in a view
  double getBoundsZoom() {
    createLatLngBounds();
    if (routeBound != null) {
      final latDiff =
          (routeBound!.northeast.latitude - routeBound!.southwest.latitude)
              .abs();
      final lngDiff =
          (routeBound!.northeast.longitude - routeBound!.southwest.longitude)
              .abs();

      final maxDiff = latDiff > lngDiff ? latDiff : lngDiff;

      if (maxDiff < 0.01) return 17;
      if (maxDiff < 0.05) return 15;
      if (maxDiff < 0.1) return 14;
      if (maxDiff < 0.5) return 12;
      return 10;
    } else {
      debugPrint("routeBound is null at getBoundsZoom()");
      throw Error();
    }
  }

  LatLng getCenter() {
    createLatLngBounds();
    if (routeBound != null) {
      return LatLng(
        (routeBound!.northeast.latitude + routeBound!.southwest.latitude) / 2,
        (routeBound!.northeast.longitude + routeBound!.southwest.longitude) / 2,
      );
    } else {
      debugPrint("routeBound is null at getCenter()");
      throw Error(); // error
    }
  }
}
