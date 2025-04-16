import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/screens/signup/option_button_set.dart';
import 'package:ploop_fe/screens/signup/set_motivation.dart';

import '../home/ploop_appbar.dart';
import 'next_button.dart';
import 'signup.dart';

class SetDifficulty extends StatelessWidget {
  SetDifficulty({super.key});

  final List<String> labelList = [
    "I'm a complete beginner",
    "I've tried it a few times",
    "I do it regularly"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 874.h,
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          // page alignment
          children: [
            Positioned.fill(
              bottom: 60.h,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: NextPageButton(
                  route: SetMotivation(),
                ),
              ),
            ),
            Column(
              spacing: 12.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                PloopAppBar(
                  showUserInfo: false,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset('assets/images/navigate-back-icon.png'),
                ),
                // body
                Container(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'What is the difficulty level of the plogging activity?',
                          style: Theme.of(context).textTheme.headlineMedium),

                      SizedBox(height: 60.h),
                      // dropdown options
                      Column(
                        spacing: 82.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // option 1
                          Column(
                            spacing: 8.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Plogging Experience Level',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              OptionButtonSet(
                                alignColumn: true,
                                options: [
                                  ...labelList,
                                ],
                                isMultiSelect: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
