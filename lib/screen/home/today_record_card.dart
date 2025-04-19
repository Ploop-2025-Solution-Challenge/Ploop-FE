// GET record by Datetime to duration?
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodayRecordCard extends StatelessWidget {
  const TodayRecordCard({super.key});

  final int todayGarbageCount = 0;
  final double todayMilesCount = 0.28;
  final Duration todayRecordTime =
      const Duration(hours: 0, minutes: 21, seconds: 32);

  String _printDuration(Duration duration) {
    if (duration == Duration.zero) {
      return '0:00';
    }

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());

    if (duration.inHours < 1) {
      return "$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370.w,
      height: 80.h,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          color: const Color(0xFF7EF18D)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Collected garbage',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  '$todayGarbageCount',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          const LineDividerWidget(),
          Expanded(
            child: Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Miles',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  '$todayMilesCount',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          const LineDividerWidget(),
          Expanded(
            child: Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Time',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  _printDuration(todayRecordTime),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LineDividerWidget extends StatelessWidget {
  const LineDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          // color: Colors.blue,
          width: 8.w,
          height: 50.h,
        ),
        Container(
          height: 50,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 0.5.w,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
          ),
        ),
        SizedBox(
          // color: Colors.blue,
          width: 12.w,
          height: 50.h,
        ),
      ],
    );
  }
}
