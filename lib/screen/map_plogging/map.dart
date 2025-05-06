import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ploop_fe/model/route_model.dart';
import 'package:ploop_fe/provider/plogging_provider.dart';
import 'package:ploop_fe/provider/recommendation_provider.dart';
import 'package:ploop_fe/provider/user_info_provider.dart';
import 'package:ploop_fe/screen/map_plogging/map_sample.dart';
import 'package:ploop_fe/screen/map_plogging/pickup_counter.dart';
import 'package:ploop_fe/screen/map_plogging/pause_modal.dart';
import 'package:ploop_fe/screen/map_plogging/route_recommend_reason_widget.dart';
import 'package:ploop_fe/screen/map_plogging/specify_photo.dart';
import 'package:ploop_fe/screen/map_plogging/stop_plogging_button.dart';
import 'package:ploop_fe/theme.dart';
import 'camera_button_on_map.dart';
import 'map_filter_button.dart';
import 'start_plogging_button.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  XFile? _image;
  bool _isMapShrunk = false;
  bool _isButtonEnabled = true;
  bool _isPloggingStarted = false;
  bool _isPloggingActive = false;

  final ImagePicker picker = ImagePicker();
  double? _latitude;
  double? _longitude;

  // toast
  late FToast fToast;

  // filter state
  bool _showLitterArea = false;
  bool _showBin = false;
  bool _showRoute = false;
  bool _showRouteReason = false;

  // elapsed plogging time duration
  final Stopwatch _stopwatch = Stopwatch();
  late Timer timer;
  late Duration _elapsedTime;
  late double _elapsedTimeFormat;
  List<LatLng> route = [];

  int _pickedAmount = 0;
  double _movedDistance = 0;

  Set<Polyline> recommend_polylines = {};

  late StreamSubscription<Position> positionSubscription;
  Stream<Position>? positionStream;
  Position? currentPos;
  Position? previousPos;
  bool _tracking = false;
  List<LatLng> _ploggingRoute = [];
  Set<Polyline> _ploggingPolylines = {};
  Marker _routeMarkers = const Marker(markerId: MarkerId('recommend'));
  int distanceFilterValue = 2;
  String motivation = "";

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);

      if (_image != null) {
        await getCurrentLocation();

        if (_latitude == null || _longitude == null) {
          return;
        }

        if (mounted) {
          final postResult = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => SpecifyPhoto(
                  imagePath: pickedFile.path,
                  latitude: _latitude!,
                  longitude: _longitude!),
            ),
          );

          _showToast(postResult);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _elapsedTime = Duration.zero;
    _elapsedTimeFormat = 0.0;

    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_stopwatch.isRunning) {
          _updateElapsedTime();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // _

  /// Draw Polyline of recommended route
  Future<void> _fetchRecommend() async {
    final GoogleMapController controller = await _mapController.future;
    LatLngBounds bounds = await controller.getVisibleRegion();
    debugPrint('$bounds');
    if (_showRoute) {
      final recommended =
          await ref.watch(routeRecommendationProvider(bounds).future);

      if (recommended != null) {
        setState(() {
          route = recommended.recommendationRoute;
          motivation = recommended.motivation;

          _routeMarkers = Marker(
            icon: AssetMapBitmap('assets/markers/icon_recommendation.png',
                width: 36.w, height: 41.h),
            markerId: const MarkerId('recommend'),
            position: (LatLng(route[0].latitude, route[0].longitude)),
            visible: true,
          );

          recommend_polylines.add(Polyline(
              polylineId: PolylineId('recommend'),
              points: route,
              color: theme().recommend,
              visible: _showRoute,
              width: 6));

          _zoomToRoute();
        });

        if (!_showRoute) {
          recommend_polylines.clear();
        }
      }
    }
  }

  Future<void> _zoomToRoute() async {
    final GoogleMapController controller = await _mapController.future;
    final RouteModel model = RouteModel(
        activityRoute: route, routeId: 0, updatedDateTime: DateTime.now());

    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
          LatLng(
              model.getCenter().latitude + 0.0015, model.getCenter().longitude),
          model.getBoundsZoom()),
    );
  }

  Future<void> startLocationUpdate() async {
    await checkPermissionWhenStart();
    _ploggingRoute.clear();
    _ploggingPolylines.clear();
    _tracking = true;

    positionStream = Geolocator.getPositionStream(
      locationSettings: Platform.isIOS
          ? AppleSettings(
              accuracy: LocationAccuracy.best,
              activityType: ActivityType.fitness,
              distanceFilter: distanceFilterValue,
              pauseLocationUpdatesAutomatically: true,
              showBackgroundLocationIndicator: true,
              allowBackgroundLocationUpdates: true,
            )
          : AndroidSettings(
              accuracy: LocationAccuracy.best,
              distanceFilter: distanceFilterValue,
              forceLocationManager: false,
              intervalDuration: const Duration(seconds: 5),
            ),
    );
    positionSubscription = positionStream!.listen((Position position) {
      currentPos = position;
      LatLng latLng = LatLng(position.latitude, position.longitude);
      _ploggingRoute.add(latLng);

      if (previousPos != null && currentPos != null) {
        double distanceInMeters = Geolocator.distanceBetween(
          previousPos!.latitude,
          previousPos!.longitude,
          currentPos!.latitude,
          currentPos!.longitude,
        );
        _movedDistance += distanceInMeters / 1609.344;
      }
      previousPos = currentPos;

      _ploggingPolylines = {
        Polyline(
          polylineId: const PolylineId("route"),
          points: _ploggingRoute,
          color: theme().route,
          width: 6,
        )
      };
    });
  }

  Future<void> stopLocationUpdate() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best),
      );
      LatLng latLng = LatLng(position.latitude, position.longitude);
      _ploggingRoute.add(latLng);

      if (previousPos != null) {
        double distance = Geolocator.distanceBetween(
          previousPos!.latitude,
          previousPos!.longitude,
          position.latitude,
          position.longitude,
        );
        _movedDistance += distance / 1609.344;
      }

      currentPos = position;
    } catch (e) {
      debugPrint("Error getting final position: $e");
    }

    _tracking = false;
    positionSubscription.cancel();
  }

  void _showToast(String result) {
    Widget toast = Container(
      width: 370.w,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: GrayScale.black,
      ),
      child: Row(
        spacing: 16.w,
        children: [
          result == 'success'
              ? Image.asset(
                  'assets/icons/Update-success-3x.png',
                  width: 21.w,
                )
              : Image.asset(
                  'assets/icons/Update-failed-3x.png',
                  width: 21.w,
                ),
          result == 'success'
              ? Text(
                  'Updated Successfully',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: GrayScale.gray_200),
                )
              : Text(
                  'Update Failed. Please try again.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: GrayScale.gray_200),
                ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child, gravity) =>
          Positioned(top: 154.h, left: 16.w, child: child),
    );
    // refresh
    setState(() {});
  }

  Future<void> checkPermissionWhenStart() async {
    var status = await Permission.locationAlways.status;
    if (!status.isGranted && mounted) {
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
                                fontSize: 17.sp,
                                letterSpacing: -0.3.sp,
                                color: const Color.fromARGB(255, 0, 122, 255),
                              )),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text(
                        "Go to settings",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
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
                  title: const Text("Background Location Access Needed"),
                  content: const Text(
                      "To track your plogging route in the background, please set location access to 'Always Allow'."),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text("Go to settings"),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await openAppSettings();
                      },
                    ),
                  ],
                );
              },
            );
    }
  }

  Future<void> getCurrentLocation() async {
    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      _latitude = pos.latitude;
      _longitude = pos.longitude;
    });
  }

  // plogging
  void _startPlogging() {
    setState(() {
      _isMapShrunk = true;
      _isButtonEnabled = false;
      _isPloggingStarted = true;
      _isPloggingActive = true;
      _stopwatch.start();
      getCurrentLocation();
      startLocationUpdate();

      if (_stopwatch.isRunning) {
        _updateElapsedTime();
      }
    });
  }

  void _updateElapsedTime() {
    setState(() {
      _elapsedTime = _stopwatch.elapsed;
      _elapsedTimeFormat = _formatTime(_elapsedTime);
    });
  }

  double _formatTime(Duration time) {
    double hours = time.inSeconds / 3600;
    return hours;
  }

  void _pausePlogging() {
    setState(() {
      _isPloggingActive = false;
      _stopwatch.stop();
      // timer.cancel();
    });
  }

  void _endPlogging() {
    setState(() {
      _isPloggingActive = false;

      final ploggingNotifier =
          ref.read(ploggingActivityNotifierProvider.notifier);
      final userInfo = ref.read(userInfoNotifierProvider);

      // Set all required data
      ploggingNotifier.setRoute(_ploggingRoute);
      ploggingNotifier.setTimeDuration(_elapsedTimeFormat);
      ploggingNotifier.setUpdatedTime();
      ploggingNotifier.setCollectedCount(_pickedAmount);
      ploggingNotifier.setDistance(_movedDistance);
      // UserResponse userInfo = ref.watch(userInfoNotifier);
      ploggingNotifier.setUserId(userInfo.id);

      _stopwatch.reset();
      timer.cancel();
      stopLocationUpdate();
    });
  }

  void _showPauseModal(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return PauseModal(
          onFinish: _endPlogging,
          onClose: _resumePlogging,
          amount: _pickedAmount,
          miles: _movedDistance,
          formattedTime: _elapsedTimeFormat,
          route: _ploggingRoute,
          polylines: _ploggingPolylines,
        );
      },
    );
    if (result == null) {
      _isPloggingActive = true;
      _resumePlogging();
    }
  }

  void _resumePlogging() {
    // _isPloggingActive = true;
    _stopwatch.start();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = _stopwatch.elapsed;
      });
    });
  }

  void _toggleBinMarker() {
    setState(() {
      _showBin = !_showBin;
    });
  }

  void _toggleAreaMarker() {
    setState(() {
      _showLitterArea = !_showLitterArea;
    });
  }

  void _toggleRouteMarker() {
    setState(() {
      _showRoute = !_showRoute;
      if (_showRoute) {
        _showRouteReason = true;
      }
    });
  }

  void _increment() {
    setState(() {
      _pickedAmount++;
    });
  }

  void _decrement() {
    setState(() {
      if (_pickedAmount > 0) _pickedAmount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox.expand(
        child: Stack(
          children: [
            if (_isPloggingStarted)
              Positioned(
                bottom: 19.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      spacing: 24.h,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 41.w,
                          children: [
                            Column(
                              spacing: 2.h,
                              children: [
                                Text(_movedDistance.toStringAsFixed(2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                Text(
                                  'Miles',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: GrayScale.gray_300,
                                      ),
                                ),
                              ],
                            ),
                            // stopwatch

                            Column(
                              spacing: 2.h,
                              children: [
                                Text(_elapsedTimeFormat.toStringAsFixed(2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                Text(
                                  'Hours',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: GrayScale.gray_300,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 12.h,
                          children: [
                            Text(
                              'Picked Up',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            PickupCounter(
                              amount: _pickedAmount,
                              onIncrement: _increment,
                              onDecrement: _decrement,
                            ),
                          ],
                        ),
                        StopPloggingButton(
                          onPressed: () {
                            _pausePlogging();
                            _showPauseModal(context);
                          },
                          mode: 'stop',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  height: _isMapShrunk ? 502.h : double.maxFinite,
                  child: MapSample(
                    showLitterArea: _showLitterArea,
                    showBin: _showBin,
                    showRoute: _showRoute,
                    isPloggingStarted: _isPloggingStarted,
                    ploggingPolylines: _ploggingPolylines,
                    recommendPolylines: recommend_polylines,
                    routeMarker: _routeMarkers,
                    recommend: route,
                    currentPosition: currentPos,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController.complete(controller);
                    },
                  ),
                ),
                SafeArea(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
                    child: Row(
                      spacing: 12.w,
                      children: [
                        MapFilterButton(
                          label: 'Litter Area',
                          isActive: _showLitterArea,
                          onPressed: _toggleAreaMarker,
                        ),
                        MapFilterButton(
                          label: 'Bin',
                          isActive: _showBin,
                          onPressed: _toggleBinMarker,
                        ),
                        MapFilterButton(
                          label: 'Route Recommendation',
                          isActive: _showRoute,
                          onPressed: () {
                            _toggleRouteMarker();
                            _fetchRecommend();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 32.h,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _isButtonEnabled
                        ? StartPloggingButton(onPressed: _startPlogging)
                        : const SizedBox(
                            height: 0,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 32.h,
                  right: 16.h,
                  child: !_isPloggingStarted
                      ? CameraButton(
                          onPressed: () async {
                            await getImage(ImageSource.camera);
                          },
                        )
                      : const SizedBox(),
                ),
                if (_showRouteReason && _showRoute)
                  Positioned(
                    top: 175.h,
                    right: 23.w,
                    child: RouteRecommendReasonWidget(
                      key: ValueKey(motivation),
                      onClosePressed: () {
                        setState(() {
                          _showRouteReason = false;
                        });
                      },
                      recommendedRoute: route,
                      motivation: motivation == "" ? "Loading..." : motivation,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
