import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/screens/home/challenge.dart';
import 'ploop_appbar.dart';
import 'today_record_card.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          // Page Content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              PloopAppBar(),
              // SizedBox(
              //   height: 22.h,
              // ),

              // Page body
              Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  spacing: 12.h,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  // Weekly Challenge
                  children: [
                    Text(
                      'Weekly Challenge',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    ChallengeProgressCard(),
                    // spacing ++
                    SizedBox(
                      height: 0.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 8.w,
                        children: [
                          // TODO: get current mission from server
                          ChallengeCard(
                            title: 'Pick up 7 cigarette butts',
                            isVerified: false,
                          ),
                          ChallengeCard(
                              title: 'Collect 5 paper waste items',
                              isVerified: false),
                          ChallengeCard(
                              title: 'Grab 2 discarded straws',
                              isVerified: false),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    // Today's Record
                    Text(
                      "Today's Record",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    TodayRecordCard(),
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
