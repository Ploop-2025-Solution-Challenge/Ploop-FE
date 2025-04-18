import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/screen/activity/date_range_picker.dart';
import 'package:ploop_fe/screen/signup/option_button_set.dart';

import '../home/ploop_appbar.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              PloopAppBar(),
              Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  spacing: 12.h,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  // Weekly Challenge
                  children: [
                    Text(
                      'Activity',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    DateRangePicker(
                      ranges: ['W', 'M', '3M', 'Y'],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
