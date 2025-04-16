import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/main.dart';

import '../home/ploop_appbar.dart';
import 'next_button.dart';
import 'signup.dart';

class FinishSetup extends StatelessWidget {
  const FinishSetup({super.key});

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
                  label: 'Continue',
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
                      Text("Well done!\nNow let's go plogging together!",
                          style: Theme.of(context).textTheme.headlineMedium),
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
