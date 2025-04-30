import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ploop_fe/model/route_model_test.dart';
import 'package:ploop_fe/screen/map_plogging/pickup_counter.dart';
import 'package:ploop_fe/screen/map_plogging/pause_modal.dart';
import 'package:ploop_fe/screen/map_plogging/route_recommend_reason_widget.dart';
import 'package:ploop_fe/screen/map_plogging/specify_photo.dart';
import 'package:ploop_fe/screen/map_plogging/stop_plogging_button.dart';
import 'package:ploop_fe/screen/world/world.dart';
import 'package:ploop_fe/service/bin_service.dart';
import 'package:ploop_fe/service/trashspot_service.dart';
import 'package:ploop_fe/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'camera_button_on_map.dart';
import 'map_filter_button.dart';
import 'start_plogging_button.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  XFile? _image;
  bool _isMapShrunk = false;
  bool _isButtonEnabled = true;
  bool _isPloggingEnabled = false;

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
  late String _elapsedTimeString;

  int _pickedAmount = 0;
  double _movedDistance = 0;

  // TEST DATA
  RouteModel recommendedRoute = RouteModel(
      routeId: 'recommend',
      route: const <LatLng>[
        LatLng(37.62813, 127.073059),
        LatLng(37.62785, 127.07295),
        LatLng(37.62760, 127.07280),
        LatLng(37.62735, 127.07265),
        LatLng(37.62710, 127.07250),
        LatLng(37.62685, 127.07235),
        LatLng(37.62660, 127.07220),
        LatLng(37.62635, 127.07205),
        LatLng(37.62610, 127.07190),
        LatLng(37.62585, 127.07175),
        LatLng(37.62560, 127.07160),
        LatLng(37.62535, 127.07145),
        LatLng(37.62510, 127.07130),
        LatLng(37.62485, 127.07115),
        LatLng(37.62460, 127.07100),
        LatLng(37.62435, 127.07085),
        LatLng(37.62410, 127.07070),
        LatLng(37.62385, 127.07055),
        LatLng(37.62360, 127.07040),
        LatLng(37.62335, 127.07025)
      ],
      userId: '',
      updatedDateTime: DateTime.now());
  Set<Polyline> recommend_polylines = {};

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      debugPrint('image is saved at: ${pickedFile.path}');

      if (_image != null) {
        await getCurrentLocation();

        if (_latitude == null || _longitude == null) {
          debugPrint('something in position is null');
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
    _elapsedTimeString = "";

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

  /// Draw Polyline of recommended route
  void _buildPolyline() {
    setState(() {
      // _showRoute = true;

      recommend_polylines.add(Polyline(
          polylineId: PolylineId('recommend'),
          points: recommendedRoute.route,
          color: theme().recommend,
          visible: _showRoute,
          width: 6));

      _zoomToRoute();

      if (!_showRoute) {
        recommend_polylines.clear();
      }
    });
  }

  Future<void> _zoomToRoute() async {
    final GoogleMapController controller = await _mapController.future;

    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
          LatLng(recommendedRoute.getCenter().latitude + 0.0015,
              recommendedRoute.getCenter().longitude),
          recommendedRoute.getBoundsZoom() - 1),
    );
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
                  'Update Successfully',
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
  }

  Future<void> getCurrentLocation() async {
    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      _latitude = pos.latitude;
      _longitude = pos.longitude;
      // debugPrint('this image is taken at ${pos.latitude}, ${pos.longitude}');
    });
  }

  // plogging
  void _startPlogging() {
    setState(() {
      _isMapShrunk = true;
      _isButtonEnabled = false;
      _isPloggingEnabled = true;
      _stopwatch.start();

      if (_stopwatch.isRunning) {
        _updateElapsedTime();
      }
    });
  }

  void _updateElapsedTime() {
    setState(() {
      _elapsedTime = _stopwatch.elapsed;
      _elapsedTimeString = _formatTime(_elapsedTime);
    });
  }

  String _formatTime(Duration time) {
    double hours = time.inSeconds / 3600;
    return hours.toStringAsFixed(2);
  }

  void _pausePlogging() {
    setState(() {
      _isPloggingEnabled = false;
      _stopwatch.stop();
      timer.cancel(); // not working?
    });
  }

  void _endPlogging() {
    setState(() {
      _isPloggingEnabled = false;
      debugPrint("$_elapsedTimeString, $_pickedAmount, $_movedDistance");
      _stopwatch.reset();
      timer.cancel();
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
          formattedTime: _elapsedTimeString,
        );
      },
    );
    debugPrint(result);
    if (result == null) {
      _resumePlogging();
    }
  }

  void _resumePlogging() {
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
            // if (_isPloggingEnabled)
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
                              Text('$_movedDistance',
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
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
                              Text(_elapsedTimeString,
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
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
                    isPloggingEnabled: _isPloggingEnabled,
                    recommendPolylines: recommend_polylines,
                    recommend: recommendedRoute,
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
                            _buildPolyline();
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
                  child: !_isPloggingEnabled
                      ? CameraButton(
                          onPressed: () async {
                            debugPrint('camera pressed');
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
                        onClosePressed: () {
                          setState(() {
                            _showRouteReason = false;
                          });
                        },
                        recommendedRoute: test1),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  final bool showLitterArea;
  final bool showBin;
  final bool showRoute;
  final bool isPloggingEnabled;
  final RouteModel recommend;
  final Function(GoogleMapController)? onMapCreated;

  final Set<Polyline> recommendPolylines;

  const MapSample({
    super.key,
    this.showLitterArea = false,
    this.showBin = false,
    this.showRoute = false,
    this.isPloggingEnabled = false,
    required this.recommendPolylines,
    this.onMapCreated,
    required this.recommend,
  });

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng? currentPos;

  List<LatLng>? binPosition;
  List<LatLng>? trashspotPosition;

  final Set<Marker> _litterMarkers = {};
  final Set<Marker> _binMarkers = {};
  late Marker _routeMarkers = Marker(markerId: MarkerId('recommend'));

  static const CameraPosition initialPos = CameraPosition(
    // target: LatLng(37.422131, -122.084801),
    target: LatLng(
      37.625664164,
      127.073833038,
    ),
    zoom: 14.4746,
  );

  // void initState() {}

  @override
  void dispose() {
    super.dispose();
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
    // TODO
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

    return Stack(
      children: [
        GoogleMap(
          markers: visibleMarkers,
          polylines: widget.recommendPolylines,
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
          onCameraMove: (CameraPosition pos) async {
            final _lastPosition = pos;
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
        ),
        Positioned(
          bottom: !widget.isPloggingEnabled ? 92.h : 32.h,
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
