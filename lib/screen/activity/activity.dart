import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/screen/activity/dashboard_graph.dart';
import 'package:ploop_fe/screen/activity/date_range_picker.dart';
import 'package:ploop_fe/theme.dart';

import '../home/ploop_appbar.dart';
import 'dashboard_text.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
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
                    ranges: ['W', 'M', '3M', 'Y'],
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
        return (now.subtract(Duration(days: 29)), now);
      case '3M':
        return (now.subtract(Duration(days: 89)), now);
      case 'Y':
        return (now.subtract(Duration(days: 364)), now);
      case 'W':
      default:
        return (now.subtract(Duration(days: 6)), now);
    }
  }
}
