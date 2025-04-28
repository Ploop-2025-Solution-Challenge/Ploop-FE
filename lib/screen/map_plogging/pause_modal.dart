import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ploop_fe/screen/map_plogging/plogging_result.dart';
import 'package:ploop_fe/screen/map_plogging/stop_plogging_button.dart';
import 'package:ploop_fe/theme.dart';

class PauseModal extends StatelessWidget {
  final VoidCallback onFinish;
  final VoidCallback onClose;
  final int amount;
  final double miles;
  final Duration time;

  const PauseModal(
      {super.key,
      required this.onFinish,
      required this.onClose,
      required this.amount,
      required this.miles,
      required this.time});

  String format(Duration time) {
    double hours = time.inSeconds / 3600;
    return hours.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                "${DateFormat('dd. MM. y - hh:mm a').format(DateTime.now())}",
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
                      Text('$miles',
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
                      Text(format(time),
                          style: Theme.of(context).textTheme.displaySmall),
                      Text(
                        'Time',
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => PloggingResult()));
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
