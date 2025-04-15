import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/main.dart';

import '../home/ploop_appbar.dart';
import 'signup.dart';

class SetUserGender extends StatelessWidget {
  const SetUserGender({super.key});

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
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: NextPageButton(
                  route: MainScaffold(),
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
                      Text('Select your date of birth and gender',
                          style: Theme.of(context).textTheme.headlineMedium),

                      SizedBox(height: 60.h),
                      // dropdown options
                      Column(
                        spacing: 82.h,
                        children: [
                          // option 1
                          Column(
                            spacing: 8.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Country',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              CustomDropDownMenu(entryList: [
                                'KR',
                                'UK',
                                'test3',
                                'test4',
                                'test5',
                                'test6',
                                'test7',
                                'test8',
                                'test9',
                                'test10',
                                'test11',
                              ]),
                            ],
                          ),
                          Column(
                            spacing: 8.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Region',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              CustomDropDownMenu(
                                entryList: ['Seoul', 'London'],
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
