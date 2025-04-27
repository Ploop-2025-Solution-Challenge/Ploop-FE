import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ploop_fe/model/route_model_test.dart';
import 'package:ploop_fe/theme.dart';

class WorldMap extends StatefulWidget {
  final List<RouteModel> data;
  final String? selectedMarkerId;
  final bool isRouteDrawing;
  final bool enablePreview;
  final Function(String) onMarkerTap;
  const WorldMap(
      {super.key,
      required this.selectedMarkerId,
      required this.onMarkerTap,
      required this.data,
      required this.isRouteDrawing,
      required this.enablePreview});

  @override
  State<WorldMap> createState() => WorldMapState();
}

class WorldMapState extends State<WorldMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng? currentPos;

  /* TEMPORARY MODEL */
  List<RouteModel> data = [];

  // temporary: GooglePlex position
  static const CameraPosition initialPos = CameraPosition(
    target: LatLng(37.422131, -122.084801),
    zoom: 6,
  );

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  Set<Marker> _buildMarker() {
    if (data.isEmpty) {
      debugPrint("route data is empty");
    }
    return data.map((routeModel) {
      bool isMarkerSelected =
          widget.selectedMarkerId == routeModel.routeId.toString();
      return Marker(
        position: routeModel.route[0],
        markerId: MarkerId(routeModel.routeId.toString()),
        icon: isMarkerSelected
            ? AssetMapBitmap('assets/markers/icon_user_route_selected.png',
                width: 36.w)
            : AssetMapBitmap('assets/markers/icon_user_route_default.png',
                width: 36.w),
        onTap: () => {
          debugPrint("pressed ${routeModel.routeId}"),
          widget.onMarkerTap(routeModel.routeId)
        },
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: _buildMarker(),
          mapType: MapType.normal,
          initialCameraPosition: initialPos,
          onMapCreated: (GoogleMapController controller) {
            try {
              _goToCurrentLocation();
            } catch (e) {
              debugPrint('$e');
            }
            _controller.complete(controller);
          },
          myLocationButtonEnabled: false,
        ),
        Positioned(
          bottom: 32.h,
          right: 16.h,
          child: Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.w),
              boxShadow: [
                BoxShadow(
                  color: GrayScale.shadowColor,
                  blurRadius: 4.w,
                  offset: Offset(0, 4.h),
                  spreadRadius: 0,
                )
              ],
              color: Colors.black,
            ),
            child: IconButton(
              onPressed: (() {
                _goToCurrentLocation();
              }),
              icon: const Icon(
                Icons.my_location,
                color: GrayScale.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  // move map camera by _determinePosition()
  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;

    Position position = await _determinePosition();

    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ),
    );
    debugPrint(position.latitude.toString());
    debugPrint(position.longitude.toString());
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
