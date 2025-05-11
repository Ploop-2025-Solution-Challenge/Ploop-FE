import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ploop_fe/provider/jwt_provider.dart';
import 'package:ploop_fe/service/bin_service.dart';
import 'package:ploop_fe/service/trashspot_service.dart';
import 'package:ploop_fe/theme.dart';

class MapSample extends ConsumerStatefulWidget {
  final bool showLitterArea;
  final bool showBin;
  final bool showRoute;
  final bool isPloggingStarted;
  final List<LatLng> recommend;
  final Function(GoogleMapController)? onMapCreated;
  final Position? currentPosition;

  final Set<Polyline> recommendPolylines;
  final Set<Polyline> ploggingPolylines;
  final Marker routeMarker;

  const MapSample({
    super.key,
    this.showLitterArea = false,
    this.showBin = false,
    this.showRoute = false,
    this.isPloggingStarted = false,
    required this.recommendPolylines,
    required this.routeMarker,
    this.onMapCreated,
    required this.recommend,
    this.currentPosition,
    required this.ploggingPolylines,
  });

  @override
  ConsumerState<MapSample> createState() => MapSampleState();
}

class MapSampleState extends ConsumerState<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Position? currentPos;

  List<LatLng>? binPosition;
  List<LatLng>? trashspotPosition;

  final Set<Marker> _litterMarkers = {};
  final Set<Marker> _binMarkers = {};
  // late Marker _routeMarkers = const Marker(markerId: MarkerId('recommend'));

  static const CameraPosition initialPos = CameraPosition(
    // target: LatLng(37.422131, -122.084801),
    target: LatLng(
      37.625664164,
      127.073833038,
    ),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => _checkPermission(context));

    setInitialPos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> setInitialPos() async {
    currentPos = await _determinePosition();
  }

  void _fetchAreaPosition(bounds) async {
    // final prefs = await SharedPreferences.getInstance();
    // final jwt = prefs.getString('jwt');

    final jwt = ref.read(jwtNotifierProvider).jwt;

    if (jwt != null) {
      final trashspotPosList =
          await TrashspotService.getSpotPosition(jwt, bounds);

      // should be neither empty or null
      if (trashspotPosList != null) {
        if (trashspotPosList.isEmpty) {
          debugPrint('no trash area in range');
          return;
        }
        setState(
          () {
            _litterMarkers
              ..clear()
              ..addAll(trashspotPosList
                  .map(
                    (e) => Marker(
                      icon: AssetMapBitmap('assets/markers/icon_Litter.png',
                          width: 36, height: 41),
                      markerId: MarkerId('${e.id}'),
                      position: (LatLng(e.latitude, e.longitude)),
                      visible: true,
                    ),
                  )
                  .toList());
          },
        );
      } else {
        debugPrint('trashspotPosList is null');
      }
    }
  }

  void _fetchBinPosition(bounds) async {
    final jwt = ref.read(jwtNotifierProvider).jwt;

    if (jwt != null) {
      final binPosList = await BinService.getBinPosition(jwt, bounds);

      // should be neither empty or null
      if (binPosList != null) {
        if (binPosList.isEmpty) {
          debugPrint('no bin in range');
          return;
        }
        setState(
          () {
            _binMarkers
              ..clear()
              ..addAll(binPosList
                  .map(
                    (e) => Marker(
                      icon: AssetMapBitmap('assets/markers/icon_Bin.png',
                          width: 36, height: 41),
                      markerId: MarkerId('${e.id}'),
                      position: (LatLng(e.latitude, e.longitude)),
                      visible: true,
                    ),
                  )
                  .toList());
          },
        );
      } else {
        debugPrint('binPosList is empty');
      }
    }
  }

  // void _fetchRecommend(bounds) async {
  //   final recommendation =
  //       await ref.watch(routeRecommendationProvider(bounds).future);

  //   if (recommendation != null) {
  //     final route = recommendation.recommendationRoute;
  //     debugPrint('${LatLng(route[0].latitude, route[0].longitude)}');
  //     setState(
  //       () {
  //         _routeMarkers = Marker(
  //           icon: AssetMapBitmap('assets/markers/icon_recommendation.png',
  //               width: 36.w, height: 41.h),
  //           markerId: const MarkerId('recommend'),
  //           position: (LatLng(route[0].latitude, route[0].longitude)),
  //           visible: true,
  //         );
  //       },
  //     );
  //   } else {
  //     debugPrint('null recommendation. not enough trashspot');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Set<Marker> visibleMarkers = {};

    if (widget.showLitterArea) {
      visibleMarkers.addAll(_litterMarkers);
    }

    if (widget.showBin) {
      visibleMarkers.addAll(_binMarkers);
    }

    if (widget.showRoute) {
      visibleMarkers.addAll({widget.routeMarker});
    }

    Set<Polyline> allPolylines = {};
    if (widget.showRoute) {
      allPolylines.addAll(widget.recommendPolylines);
    }
    allPolylines.addAll(widget.ploggingPolylines);

    return Stack(
      children: [
        GoogleMap(
          markers: visibleMarkers,
          polylines: allPolylines,
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          trafficEnabled: false,
          mapToolbarEnabled: false,
          initialCameraPosition: initialPos,
          onMapCreated: (controller) async {
            try {
              _goToCurrentLocation();
            } catch (e) {
              debugPrint('$e');
            }
            _controller.complete(controller);
            if (widget.onMapCreated != null) {
              widget.onMapCreated!(controller);
            }
          },
          onCameraIdle: () async {
            GoogleMapController googleMapController = await _controller.future;
            LatLngBounds bounds = await googleMapController.getVisibleRegion();
            _fetchAreaPosition(bounds);
            _fetchBinPosition(bounds);
            // _fetchRecommend(bounds);
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          compassEnabled: false,
        ),
        Positioned(
          bottom: !widget.isPloggingStarted ? 92.h : 32.h,
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
              icon: Image.asset(
                'assets/icons/my-location-icon.png',
                width: 20.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // move map camera by _determinePosition()
  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;

    // await _checkPermission(context);

    Position position = await _determinePosition();

    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ),
    );
    debugPrint("current latitude: ${position.latitude.toString()}");
    debugPrint("current longitude: ${position.longitude.toString()}");
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

Future<void> _checkPermission(BuildContext context) async {
  final locationStatus = await Permission.locationWhenInUse.status;

  if (!locationStatus.isGranted && context.mounted) {
    final result = await Permission.locationWhenInUse.request();
    if (!result.isGranted) {
      return Future.error('Location permission is required.');
    }
  }

  final geolocatorPermission = await Geolocator.checkPermission();
  if (geolocatorPermission == LocationPermission.whileInUse &&
      context.mounted) {
    Platform.isIOS
        ? await showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text("Background Location Access Needed"),
                content: const Text(
                    "To track your plogging route in the background, please set location access to 'Always Allow'."),
                actions: [
                  CupertinoDialogAction(
                    child: Text("Cancel",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              letterSpacing: -0.3.sp,
                              fontSize: 17.sp,
                              color: const Color.fromARGB(255, 0, 122, 255),
                            )),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    // isDefaultAction: true,
                    child: Text(
                      "Go to settings",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 17.sp,
                                letterSpacing: -0.3.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 0, 122, 255),
                              ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await openAppSettings();
                    },
                  ),
                ],
              );
            },
          )
        : await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Background Location Access Needed",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.33.h,
                    letterSpacing: 0,
                  ),
                ),
                content: Text(
                  "To track your plogging route in the background, please set location access to 'Always Allow'.",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.43.h,
                    letterSpacing: 0.25,
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.sp,
                          height: 1.43.h,
                          color: GrayScale.black),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: Text(
                      "Go to settings",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.sp,
                          height: 1.43.h,
                          color: GrayScale.black),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await openAppSettings();
                    },
                  ),
                ],
              );
            });
  }
}
