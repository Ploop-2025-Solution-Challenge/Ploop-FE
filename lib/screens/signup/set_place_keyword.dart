import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/screens/signup/finish_setup.dart';
import 'package:ploop_fe/screens/signup/option_button_set.dart';

import '../home/ploop_appbar.dart';
import 'next_button.dart';
import 'signup.dart';

class SetPlaceKeyword extends StatelessWidget {
  SetPlaceKeyword({super.key});

  final List<String> labelList = [
    "Nature (riverside paths, forest trails, parks)",
    "Urban alleys",
    "Historic sites / Cultural streets",
    "Coastal areas",
    "Around university campuses",
    "Hidden gems"
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
                  route: FinishSetup(),
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
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 10.w, 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Please select your preferred keywords\n(up to 3)',
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
                                'Where do you prefer?',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              OptionButtonSet(
                                alignColumn: true,
                                options: [
                                  ...labelList,
                                ],
                                isMultiSelect: true,
                                maxMultiSelect: 3,
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
