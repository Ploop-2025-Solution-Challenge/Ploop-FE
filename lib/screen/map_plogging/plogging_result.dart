import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ploop_fe/main.dart';
import 'package:ploop_fe/model/jwt.dart';
import 'package:ploop_fe/provider/jwt_provider.dart';
import 'package:ploop_fe/model/route_model.dart';
import 'package:ploop_fe/provider/plogging_provider.dart';
import 'package:ploop_fe/provider/user_info_provider.dart';
import 'package:ploop_fe/service/plogging_service.dart';
import 'package:ploop_fe/theme.dart';

class PloggingResult extends ConsumerWidget {
  final int amount;
  final double miles;
  final double time;
  final List<LatLng> route;
  final Set<Polyline> polylines;

  const PloggingResult(
      {super.key,
      required this.amount,
      required this.miles,
      required this.time,
      required this.route,
      required this.polylines});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthToken auth = ref.read(jwtNotifierProvider);

    return Container(
      color: GrayScale.white,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 34.h,
                ),
                IconButton(
                  onPressed: () {
                    final activity = ref.read(ploggingActivityNotifierProvider);
                    debugPrint('miles: ${activity.distanceMiles}');
                    debugPrint('route: ${activity.activityRoute}');
                    debugPrint('time: ${activity.timeDuration}');
                    debugPrint(
                        'trash count:${activity.trashCollectedCount.toString()}');
                    debugPrint('id: ${activity.userId}');
                    PloggingActivityService.postPloggingDataToServer(
                        activity, auth.jwt!);

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
                      DateFormat('dd. MM. y - hh:mm a').format(DateTime.now()),
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
                            Text(miles.toStringAsFixed(2),
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
                            Text(time.toStringAsFixed(2),
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
                    SizedBox(
                      width: 305.w,
                      height: 381.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.w),
                        child: PloggingResultMap(route, polylines),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// TEST

class PloggingResultMap extends ConsumerWidget {
  final List<LatLng> activityRoute;
  final Set<Polyline> activityPolylines;
  const PloggingResultMap(this.activityRoute, this.activityPolylines,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final resultProvider = ref.watch(ploggingActivityNotifierProvider.notifier);
    final profile = ref.read(userInfoNotifierProvider);
    RouteModel model = RouteModel(
        routeId: '',
        route: activityRoute,

        // userId: 'test',
        updatedDateTime: DateTime.now());
    LatLng? center = model.getCenter();
    debugPrint('center: $center');

    late double zoomByRoute;

    if (activityRoute.isEmpty) {
      return const Center(child: Text('Error: Empty route'));
    } else {
      zoomByRoute = model.getBoundsZoom();
      debugPrint('$zoomByRoute');
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
              points: activityRoute,
              color: theme().route,
              width: 6,
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
          compassEnabled: false,
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
      // debugPrint('center: $widget.center');
      if (placemarks.isNotEmpty) {
        // debugPrint('not empty');
        final place = placemarks.first;

        setState(() {
          address = '${place.locality}, ${place.subLocality}';
        });
        // debugPrint('Address: ${placemarks.first}');
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
