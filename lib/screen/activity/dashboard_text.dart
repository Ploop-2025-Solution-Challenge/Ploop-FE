import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DashboardTextWidget extends StatelessWidget {
  // now, now + range
  final (DateTime, DateTime) dateRange;

  const DashboardTextWidget({super.key, required this.dateRange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.h,
      children: [
        // date range
        Text(
          '${DateFormat('d. MM. y').format(dateRange.$1)} - ${DateFormat('d. MM. y').format(dateRange.$2)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFFA1A1A1),
              ),
        ),
        // collected trash amount
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Text(
              '0',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              'Trash collected',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Color(0xFFA1A1A1),
                  ),
            ),
          ],
        ),
        // records
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 32.w,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                Text('0.0', style: Theme.of(context).textTheme.displaySmall),
                Text(
                  'Miles',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Color(0xFFA1A1A1),
                      ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                Text('0.0', style: Theme.of(context).textTheme.displaySmall),
                Text(
                  'Hours',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Color(0xFFA1A1A1),
                      ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                Text(
                  '2/3',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  'Challenges Completed',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Color(0xFFA1A1A1),
                      ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
