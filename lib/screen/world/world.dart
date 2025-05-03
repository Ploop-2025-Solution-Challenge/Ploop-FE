import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ploop_fe/model/route_model.dart';
import 'package:ploop_fe/screen/world/route_preview_widget.dart';
import 'package:ploop_fe/screen/world/world_map.dart';
import 'package:ploop_fe/theme.dart';

/* TEST */
RouteModel test1 = RouteModel(route: const [
  LatLng(37.422131, -122.084801),
  LatLng(37.422400, -122.084600),
  LatLng(37.422650, -122.084300),
  LatLng(37.422800, -122.084000),
  LatLng(37.422900, -122.083700),
  LatLng(37.423000, -122.083400),
], userId: "1", updatedDateTime: DateTime(2025, 4, 7, 8, 16), routeId: "1");
RouteModel test2 = RouteModel(route: const [
  LatLng(37.424500, -122.081500),
  LatLng(37.424700, -122.081200),
  LatLng(37.424900, -122.080900),
  LatLng(37.425100, -122.080600),
  LatLng(37.425300, -122.080300),
  LatLng(37.425500, -122.080000),
], userId: "2", updatedDateTime: DateTime(2025, 4, 25, 22, 10), routeId: "2");
/* */

class WorldPage extends StatefulWidget {
  const WorldPage({super.key});

  @override
  State<WorldPage> createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  List<RouteModel> routeData = [test1, test2];

  bool enablePreview = false;
  RouteModel? selectedRoute;
  String? selectedMarkerId;
  bool isRouteDrawing = false;
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Set<Polyline> polylines = {};

  // temp
  RouteModel findRouteInfo(String routeId) {
    debugPrint('input routeId is $routeId');
    return routeData.firstWhere((routeModel) => routeModel.routeId == routeId);
  }

  void _handleMarkerTap(String routeId) {
    isRouteDrawing = false;
    // tapping for the first time
    if (selectedMarkerId != routeId) {
      setState(() {
        polylines.clear();
        // debugPrint('tapped inactive marker $routeId');
        selectedMarkerId = routeId;
        enablePreview = true;
        selectedRoute = findRouteInfo(routeId);
        // isRouteDrawing = false;
      });
    }
    // re-tap active marker
    else {
      setState(() {
        // debugPrint(
        //     'selectedMarkerId: $selectedMarkerId, tapped inactive marker $routeId');
        selectedMarkerId = null;
        enablePreview = false;
        selectedRoute = null;
        isRouteDrawing = false;
        polylines.clear();
      });
    }
  }

  // when close button on preview window is pressed
  void _togglePreview() {
    setState(() {
      enablePreview = !enablePreview;

      if (!enablePreview) {
        // closing
        selectedMarkerId = null;
        selectedRoute = null;
      }
    });
    // debugPrint(
    //     "selected Marker id: $selectedMarkerId\nseleted route: $selectedRoute, enable Preview: $enablePreview");
  }

  void _buildPolyline() {
    setState(() {
      isRouteDrawing = true;
      if (selectedRoute != null) {
        polylines.add(Polyline(
            polylineId: PolylineId(selectedMarkerId.toString()),
            points: selectedRoute!.route,
            color: theme().state,
            visible: isRouteDrawing,
            width: 6));

        _zoomToRoute();
      } else {
        isRouteDrawing = false;
        polylines.clear();
      }
    });
  }

  // when Route button on preview window is pressed
  // called only while routeModel is selected
  void _drawRouteOnMap() {
    if (enablePreview) {
      setState(() {
        enablePreview = false;
        isRouteDrawing = true;
      });
    }
  }

  Future<void> _zoomToRoute() async {
    debugPrint('called zoomToRoute');
    if (selectedRoute != null) {
      debugPrint('route is not null');
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(
            selectedRoute!.getCenter(), selectedRoute!.getBoundsZoom()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Container(
            color: GrayScale.gray_100,
            height: 150.h,
          ),
        ),
        WorldMap(
            data: routeData,
            selectedMarkerId: selectedMarkerId,
            onMarkerTap: _handleMarkerTap,
            isRouteDrawing: isRouteDrawing,
            enablePreview: enablePreview,
            selectedRoute: selectedRoute,
            polylines: polylines,
            onMapCreated: (controller) {
              _mapController.complete(controller);
            }),
        SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
          ),
        ),
        if (enablePreview && selectedRoute != null)
          Positioned(
            top: 400.h,
            left: 28.w,
            child: RoutePreviewWidget(
                key: ValueKey(selectedRoute!.routeId), // refresh preview map
                selectedRouteModel: selectedRoute!,
                onClosePressed: _togglePreview,
                onRoutePressed: () {
                  debugPrint('route pressed');
                  _buildPolyline();
                  _drawRouteOnMap();
                }),
          ),
      ],
    );
  }
}
