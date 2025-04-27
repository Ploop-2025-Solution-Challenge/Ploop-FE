import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ploop_fe/model/route_model_test.dart';
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

  // temp
  RouteModel findRouteInfo(String routeId) {
    debugPrint('input routeId is $routeId');
    return routeData.firstWhere((routeModel) => routeModel.routeId == routeId);
  }

  void _handleMarkerTap(String routeId) {
    // tap active marker; reset to default
    if (selectedMarkerId == routeId) {
      setState(() {
        debugPrint('tapped inactive marker $routeId');
        selectedMarkerId = routeId;
        enablePreview = false;
        selectedRoute = null;
        isRouteDrawing = false;
      });
    }
    // tap inactive marker;
    else {
      setState(() {
        debugPrint(
            'selectedMarkerId: $selectedMarkerId, tapped inactive marker $routeId');
        selectedMarkerId = routeId;
        enablePreview = true;
        selectedRoute = findRouteInfo(routeId);
      });
    }
  }

  void _togglePreview() {
    setState(() {
      enablePreview = !enablePreview;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WorldMap(
          data: routeData,
          selectedMarkerId: '',
          onMarkerTap: _handleMarkerTap,
          isRouteDrawing: false,
          enablePreview: false,
        ),
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
              selectedRouteModel: selectedRoute!,
              onClosePressed: _togglePreview,
            ),
          ),
      ],
    );
  }
}
