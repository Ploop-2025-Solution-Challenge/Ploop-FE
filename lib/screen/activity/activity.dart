import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/screen/activity/dashboard_graph.dart';
import 'package:ploop_fe/screen/activity/date_range_picker.dart';

import '../home/ploop_appbar.dart';
import 'dashboard_text.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            const PloopAppBar(),
            Container(
              padding: EdgeInsets.all(16.w),
              child: Column(
                spacing: 16.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const DateRangePicker(
                    ranges: ['W', 'M', '3M', 'Y'],
                  ),
                  // text info
                  DashboardTextWidget(
                    dateRange: (
                      DateTime.now(),
                      DateTime.now().add(
                        const Duration(days: 6),
                      ),
                    ),
                  ),
                  GraphField(
                    dateRange: (
                      DateTime.now(),
                      DateTime.now().add(
                        const Duration(days: 6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
