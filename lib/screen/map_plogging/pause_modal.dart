import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ploop_fe/screen/map_plogging/plogging_result.dart';
import 'package:ploop_fe/screen/map_plogging/stop_plogging_button.dart';
import 'package:ploop_fe/theme.dart';

class PauseModal extends ConsumerWidget {
  final VoidCallback onFinish;
  final VoidCallback onClose;
  final int amount;
  final double miles;
  final double formattedTime;
  final List<LatLng> route;
  final Set<Polyline> polylines;

  const PauseModal({
    super.key,
    required this.onFinish,
    required this.onClose,
    required this.amount,
    required this.miles,
    required this.formattedTime,
    required this.route,
    required this.polylines,
  });

  String format(Duration time) {
    double hours = time.inSeconds / 3600;
    return hours.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: ShapeDecoration(
        color: GrayScale.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.w),
            topRight: Radius.circular(10.w),
          ),
        ),
      ),
      height: 436.h,
      width: 417.w,
      child: Column(
        spacing: 16.h,
        children: [
          Container(
            width: double.infinity,
            height: 39.h,
            padding: EdgeInsets.only(top: 5.h),
            alignment: Alignment.center,
            child: Container(
              width: 36.w,
              height: 5.h,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.5.w),
                ),
                color: GrayScale.gray_200,
              ),
            ),
          ),

          // content
          Column(
            spacing: 40.h,
            children: [
              // crossAxisAlignment: CrossAxisAlignment.center,
              Text(
                DateFormat('dd. MM. y - hh:mm a').format(DateTime.now()),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600, color: GrayScale.gray_300),
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
                    style: Theme.of(context).textTheme.headlineLarge,
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
                          style: Theme.of(context).textTheme.displaySmall),
                      Text(
                        'Miles',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: GrayScale.gray_300,
                            ),
                      ),
                    ],
                  ),
                  // stopwatch

                  Column(
                    spacing: 2.h,
                    children: [
                      Text(formattedTime.toStringAsFixed(2),
                          style: Theme.of(context).textTheme.displaySmall),
                      Text(
                        'Hours',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: GrayScale.gray_300,
                            ),
                      ),
                    ],
                  ),
                ],
              ),

              StopPloggingButton(
                onPressed: () {
                  onFinish();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => PloggingResult(
                        amount: amount,
                        miles: miles,
                        time: formattedTime,
                        route: route,
                        polylines: polylines,
                      ),
                    ),
                  );
                },
                mode: 'end',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
