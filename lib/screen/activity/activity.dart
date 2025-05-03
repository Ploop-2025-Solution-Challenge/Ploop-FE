import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  String selectedRange = 'W';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GrayScale.white,
      child: SafeArea(
        child: Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PloopAppBar(),
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                spacing: 16.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  DateRangePicker(
                    ranges: const ['W', 'M', 'Y'],
                    selected: selectedRange,
                    onChanged: (value) {
                      setState(() {
                        selectedRange = value;
                      });
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

  (DateTime, DateTime) _calculateRange(String range) {
    final now = DateTime.now();

    switch (range) {
      case 'M':
        int currentMonth = (now.month % 12);
        return (now.subtract(const Duration(days: 29)), now); // month view
      // case '3M':
      //   return (now.subtract(Duration(days: 89)), now);
      case 'Y':
        return (now.subtract(const Duration(days: 364)), now); // year view
      case 'W':
      default:
        DateTime startOfWeek =
            now.subtract(Duration(days: now.weekday % 7)); // Sunday
        DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
        return (startOfWeek, endOfWeek); // week view
    }
  }
}
