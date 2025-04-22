import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ploop_fe/model/bin_request.dart';
import 'package:ploop_fe/screen/map_plogging/pickup_counter.dart';
import 'package:ploop_fe/screen/map_plogging/specify_photo.dart';
import 'package:ploop_fe/screen/map_plogging/stop_plogging_button.dart';
import 'package:ploop_fe/service/bin_service.dart';
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

  late FToast fToast;

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
                  'assets/images/Update-success-3x.png',
                  width: 21.w,
                )
              : Image.asset(
                  'assets/images/Update-failed-3x.png',
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

  void _startPlogging() {
    setState(() {
      _isMapShrunk = true;
      _isButtonEnabled = false;
      _isPloggingEnabled = true;
    });
  }

  void _pausePlogging() {
    setState(() {
      _isPloggingEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox.expand(
        child: Stack(
          children: [
            if (_isPloggingEnabled)
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
                            Column(
                              spacing: 2.h,
                              children: [
                                Text('0.0',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
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
                        StopPloggingButton(onPressed: () {}),
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
                  child: const MapSample(),
                ),
                SafeArea(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
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
                  child: CameraButton(
                    onPressed: () {
                      debugPrint('camera pressed');
                      getImage(ImageSource.camera);
                      if (_image != null) {}
                    },
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
              debugPrint('$e');
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
