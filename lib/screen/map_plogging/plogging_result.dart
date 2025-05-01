import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ploop_fe/main.dart';
import 'package:ploop_fe/model/route_model_test.dart';
import 'package:ploop_fe/screen/home/ploop_appbar.dart';
import 'package:ploop_fe/theme.dart';

class PloggingResult extends StatelessWidget {
  final int amount;
  final double miles;
  final String time;
  const PloggingResult(
      {super.key,
      required this.amount,
      required this.miles,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GrayScale.white,
      child: SafeArea(
        child: Container(
          // color: Colors.green,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 34.h,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const MainScaffold()));
                    },
                    icon: Image.asset('assets/icons/navigate-back-icon.png'),
                  )
                ],
              ),
              Positioned.fill(
                top: 55.h,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    spacing: 40.h,
                    children: [
                      Text(
                        DateFormat('dd. MM. y - hh:mm a')
                            .format(DateTime.now()),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: GrayScale.gray_300),
                      ),
                      Column(
                        spacing: 8.h,
                        children: [
                          Text(
                            '$amount',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            'Trash collected',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: GrayScale.gray_300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 41.w,
                        children: [
                          Column(
                            spacing: 2.h,
                            children: [
                              Text('$miles',
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
                              Text(time,
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
                      // image
                      Container(
                        width: 305.w,
                        height: 381.h,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.w),
                            child: PloggingResultMap()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/** TEST */
RouteModel resultTest = RouteModel(route: const [
  LatLng(37.631000, 127.078000),
  LatLng(37.631300, 127.077700),
  LatLng(37.631600, 127.077400),
  LatLng(37.631900, 127.077100),
  LatLng(37.632200, 127.076800),
  LatLng(37.632500, 127.076500),
  LatLng(37.632800, 127.076200),
], userId: "2", updatedDateTime: DateTime(2025, 4, 29, 1, 7), routeId: "2");

class PloggingResultMap extends ConsumerWidget {
  PloggingResultMap({super.key});

  final RouteModel result = resultTest;
  final route = resultTest.route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LatLng? center = result.getCenter();

    late double zoomByRoute;
    Future<List<Placemark>> getAddress() async {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(center.latitude, center.longitude);
      return placemarks;
    }

    if (route.isEmpty) {
      return const Center(child: Text('Error: Empty route'));
    } else {
      zoomByRoute = resultTest.getBoundsZoom();
    }

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: center,
            zoom: zoomByRoute,
          ),
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: route,
              color: theme().route,
              width: 5,
            ),
          },
          zoomControlsEnabled: false,
          zoomGesturesEnabled: false,
          scrollGesturesEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
        ),
        Positioned(
          top: 22.h,
          left: 22.5.w,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.5.w, vertical: 8.h),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.w),
                ),
                color: GrayScale.black,
              ),
              child: AddressBox(center: center)),
        ),
      ],
    );
  }
}

class AddressBox extends StatefulWidget {
  final LatLng center;
  const AddressBox({super.key, required this.center});

  @override
  State<StatefulWidget> createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {
  String? address;

  Future<void> getAddress(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      debugPrint('center: $widget.center');
      if (placemarks.isNotEmpty) {
        debugPrint('not empty');
        final place = placemarks.first;

        setState(() {
          address =
              '${placemarks.first.locality}, ${placemarks.first.subLocality}';
        });
        debugPrint('Address: ${placemarks.first}');
      }
    } catch (e) {
      debugPrint('error: $e');
      setState(() {
        address = 'Address not found';
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getAddress(widget.center.latitude, widget.center.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.5.w, vertical: 8.h),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.w),
        ),
        color: GrayScale.black,
      ),
      child: Text(
        address ?? 'Location Unknown',
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: GrayScale.white, height: 1),
      ),
    );
  }
}
