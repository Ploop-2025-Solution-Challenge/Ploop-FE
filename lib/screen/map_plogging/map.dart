import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ploop_fe/screen/map_plogging/pickup_counter.dart';
import 'package:ploop_fe/screen/map_plogging/pause_modal.dart';
import 'package:ploop_fe/screen/map_plogging/specify_photo.dart';
import 'package:ploop_fe/screen/map_plogging/stop_plogging_button.dart';
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

  // elapsed plogging time duration
  final Stopwatch _stopwatch = Stopwatch();
  late Timer timer;
  late Duration _elapsedTime;
  late String _elapsedTimeString;

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

    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        if (_stopwatch.isRunning) {
          _updateElapsedTime();
        }
      });
    });
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
      debugPrint('this image is taken at ${pos.latitude}, ${pos.longitude}');
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
    return '${time.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(time.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
  }

  void _pausePlogging() {
    setState(() {
      _isPloggingEnabled = false;
      _stopwatch.stop();
      timer.cancel(); // not working?
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
                              Text('0.0',
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
                                'Time',
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
                          const PickupCounter(),
                        ],
                      ),
                      StopPloggingButton(
                        onPressed: () {
                          _pausePlogging();
                          showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return PauseModal(
                                      onClose: _startPlogging,
                                      onFinish: () {},
                                    );
                                  })
                              // TODO: when closed resume timer and locate following
                              // .whenComplete(
                              //     _isPloggingEnabled ? _startPlogging : () {})
                              ;
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
                          onPressed: _toggleRouteMarker,
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
                          onPressed: () {
                            debugPrint('camera pressed');
                            getImage(ImageSource.camera);
                            if (_image != null) {}
                          },
                        )
                      : const SizedBox(),
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

  const MapSample({
    super.key,
    this.showLitterArea = false,
    this.showBin = false,
    this.showRoute = false,
    this.isPloggingEnabled = false,
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
  final Set<Marker> _routeMarkers = {};

  static const CameraPosition initialPos = CameraPosition(
    // target: LatLng(37.422131, -122.084801),
    target: LatLng(
      37.625664164,
      127.073833038,
    ),
    zoom: 14.4746,
  );

  void initState() {}

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
            _litterMarkers.clear();
            trashspotPosList
                .map(
                  (e) => Marker(
                    icon: AssetMapBitmap('assets/markers/icon_Litter.png',
                        width: 26.w, height: 30.h),
                    markerId: MarkerId('${e.id}'),
                    position: (LatLng(e.latitude, e.longitude)),
                    visible: true,
                  ),
                )
                .toList();
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
            _binMarkers.clear();
            binPosList
                .map(
                  (e) => Marker(
                    icon: AssetMapBitmap('assets/markers/icon_Bin.png',
                        width: 26.w, height: 30.h),
                    markerId: MarkerId('${e.id}'),
                    position: (LatLng(e.latitude, e.longitude)),
                    visible: true,
                  ),
                )
                .toList();
          },
        );
      } else {
        debugPrint('binPosList is empty');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> visibleMarkers = {};

    if (widget.showLitterArea) {
      visibleMarkers.addAll(_litterMarkers);
    }

    if (widget.showBin) {
      visibleMarkers.addAll(_binMarkers);
      visibleMarkers.add(
        Marker(
          markerId: const MarkerId('test'),
          position: const LatLng(37.609215142664446, 127.06060163676739),
          icon: AssetMapBitmap('assets/markers/icon_Bin.png',
              width: 36.w, height: 41.h),
        ),
      );
    }

    if (widget.showRoute) {
      visibleMarkers.addAll(_routeMarkers);
    }

    Set<Marker> _markers = {};

    return Stack(
      children: [
        GoogleMap(
          markers: visibleMarkers,
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
