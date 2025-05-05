import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/model/activity_filter.dart';
import 'package:ploop_fe/provider/activity_filter_provider.dart';
import 'package:ploop_fe/screen/activity/dashboard_graph.dart';
import 'package:ploop_fe/screen/activity/date_range_picker.dart';
import 'package:ploop_fe/theme.dart';

import '../home/ploop_appbar.dart';
import 'dashboard_text.dart';

class ActivityPage extends ConsumerStatefulWidget {
  const ActivityPage({super.key});

  @override
  ConsumerState<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends ConsumerState<ActivityPage> {
  Range selectedRange = Range.W;

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(activityFilterNotifierProvider);

    return Container(
      color: GrayScale.white,
      child: SafeArea(
        child: Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PloopAppBar(),
            Padding(
              padding: EdgeInsets.all(15.w),
              child: Column(
                spacing: 16.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  DateRangePicker(
                    ranges: const [Range.W, Range.M, Range.Y],
                    selected: filter.range,
                    onChanged: (newRange) {
                      ref
                          .read(activityFilterNotifierProvider.notifier)
                          .update(newRange);
                    },
                  ),
                  DashboardTextWidget(
                    dateRange: _calculateRange(selectedRange),
                  ),
                  GraphField(
                    viewMode: selectedRange,
                    dateRange: _calculateRange(selectedRange),
                    // lineLabels: [],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  (DateTime, DateTime) _calculateRange(Range range) {
    final now = DateTime.now();

    switch (range) {
      case Range.M:
        int currentMonth = (now.month % 12);
        return (now.subtract(const Duration(days: 29)), now); // month view
      // case '3M':
      //   return (now.subtract(Duration(days: 89)), now);
      case Range.Y:
        return (now.subtract(const Duration(days: 364)), now); // year view
      // case 'W':
      default:
        DateTime startOfWeek =
            now.subtract(Duration(days: now.weekday % 7)); // Sunday
        DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
        return (startOfWeek, endOfWeek); // week view
    }
  }
}
