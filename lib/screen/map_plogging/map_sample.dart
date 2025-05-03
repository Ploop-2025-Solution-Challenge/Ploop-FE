import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ploop_fe/model/route_model_test.dart';
import 'package:ploop_fe/service/bin_service.dart';
import 'package:ploop_fe/service/trashspot_service.dart';
import 'package:ploop_fe/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapSample extends StatefulWidget {
  final bool showLitterArea;
  final bool showBin;
  final bool showRoute;
  final bool isPloggingStarted;
  final RouteModel recommend;
  final Function(GoogleMapController)? onMapCreated;
  final Position? currentPosition;

  final Set<Polyline> recommendPolylines;
  final Set<Polyline> ploggingPolylines;

  const MapSample({
    super.key,
    this.showLitterArea = false,
    this.showBin = false,
    this.showRoute = false,
    this.isPloggingStarted = false,
    required this.recommendPolylines,
    this.onMapCreated,
    required this.recommend,
    this.currentPosition,
    required this.ploggingPolylines,
  });

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Position? currentPos;

  List<LatLng>? binPosition;
  List<LatLng>? trashspotPosition;

  final Set<Marker> _litterMarkers = {};
  final Set<Marker> _binMarkers = {};
  late Marker _routeMarkers = const Marker(markerId: MarkerId('recommend'));

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
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt');

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
                          width: 36.w, height: 41.h),
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
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt');

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
                          width: 36.w, height: 41.h),
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

  void _fetchRecommend(bounds) async {
    // TODO: connect server api
    // final prefs = await SharedPreferences.getInstance();
    // final jwt = prefs.getString('jwt');

    // if (jwt != null) {
    //   // final routePosList = await route;

    //   // should be neither empty or null
    //   if (binPosList != null) {
    //     if (binPosList.isEmpty) {
    //       debugPrint('no bin in range');
    //       return;
    //     }
    debugPrint(
        '${LatLng(widget.recommend.route[0].latitude, widget.recommend.route[0].longitude)}');
    setState(
      () {
        _routeMarkers = Marker(
          icon: AssetMapBitmap('assets/markers/icon_recommendation.png',
              width: 36.w, height: 41.h),
          markerId: const MarkerId('recommend'),
          position: (LatLng(widget.recommend.route[0].latitude,
              widget.recommend.route[0].longitude)),
          visible: true,
        );
      },
    );
    // } else {
    //   debugPrint('binPosList is empty');
    //   }
    // }
  }

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
      visibleMarkers.addAll({_routeMarkers});
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
          initialCameraPosition: initialPos,
          onMapCreated: (controller) {
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

            debugPrint("lat of SW: ${bounds.southwest.latitude.toString()}");
            debugPrint("long of SW: ${bounds.southwest.longitude.toString()}");
            debugPrint("lat of NE: ${bounds.northeast.latitude.toString()}");
            debugPrint("long of NE: ${bounds.northeast.longitude.toString()}");

            _fetchAreaPosition(bounds);
            _fetchBinPosition(bounds);
            _fetchRecommend(bounds);
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
              icon: const Icon(
                Icons.my_location,
                color: Colors.white,
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
