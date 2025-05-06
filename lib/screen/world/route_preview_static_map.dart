import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ploop_fe/model/route_model.dart';
import 'package:ploop_fe/theme.dart';

class RoutePreviewStaticMap extends StatelessWidget {
  final RouteModel routeModel;

  const RoutePreviewStaticMap({
    super.key,
    required this.routeModel,
  });

  @override
  Widget build(BuildContext context) {
    final route = routeModel.activityRoute;
    LatLng? center = routeModel.getCenter();
    late double zoomByRoute;
    if (route.isEmpty) {
      return const Center(child: Text('Error: Empty route'));
    } else {
      zoomByRoute = routeModel.getBoundsZoom() - 0.75;
      // debugPrint('adjusted zoom: $zoomByRoute');
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: zoomByRoute,
      ),
      polylines: {
        Polyline(
          polylineId: const PolylineId('route'),
          points: route,
          color: theme().state,
          width: 5,
        ),
      },
      zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
      scrollGesturesEnabled: false,
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
    );
  }
}
