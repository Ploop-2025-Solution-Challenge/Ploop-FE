import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'camera_button_on_map.dart';
import 'map_filter_button.dart';
import 'start_plogging_button.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MapSample(),
        SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
            child: Row(
              spacing: 12.w,
              children: const [
                MapFilterButton(
                  label: 'Litter Area',
                ),
                MapFilterButton(
                  label: 'Bin',
                ),
                MapFilterButton(
                  label: 'Route Recommendation',
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: 32.h,
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: StartPloggingButton(),
          ),
        ),
        Positioned(
          bottom: 32.h,
          right: 16.h,
          child: const CameraButton(),
        )
      ],
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng? currentPos;

  // temporary: GooglePlex position

  static const CameraPosition initialPos = CameraPosition(
    target: LatLng(37.422131, -122.084801),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initialPos,
          onMapCreated: (GoogleMapController controller) {
            try {
              _goToCurrentLocation();
            } catch (e) {
              print('$e');
            }
            _controller.complete(controller);
          },
          myLocationButtonEnabled: false,
        ),
        Positioned(
          bottom: 92.h,
          right: 16.h,
          child: Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.w),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x3F000000),
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
                color: Colors.white,
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
    print(position.latitude);
    print(position.longitude);
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
