import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

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
    return DateFormat('dd.MM.y - hh:mm a').format(updatedDateTime);
  }

  LatLngBounds? createLatLngBounds() {
    double south = route.first.latitude;
    double north = route.first.latitude;
    double west = route.first.longitude;
    double east = route.first.longitude;

    for (final point in route) {
      south = point.latitude < south ? point.latitude : south;
      north = point.latitude > north ? point.latitude : north;
      west = point.longitude < west ? point.longitude : west;
      east = point.longitude > east ? point.longitude : east;
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

      debugPrint('lat: $latDiff, lng: $lngDiff');

      if (maxDiff < 0.005) return 15.5;
      if (maxDiff < 0.01) return 15;
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
    createLatLngBounds();
    if (routeBound != null) {
      return LatLng(
        (routeBound!.northeast.latitude + routeBound!.southwest.latitude) / 2,
        (routeBound!.northeast.longitude + routeBound!.southwest.longitude) / 2,
      );
    } else {
      debugPrint("routeBound is null at RouteModel.getCenter()");
      throw Error(); // error
    }
  }
}
