import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/ploop_appbar.dart';
import 'next_button.dart';

class InfoSetupPage extends StatelessWidget {
  const InfoSetupPage(
      {super.key,
      this.lastPage = false,
      this.firstPage = false,
      this.question,
      this.widget1,
      this.title1,
      this.widget2,
      this.title2,
      required this.nextRoute});
  final bool firstPage;
  final bool lastPage;
  final String? question;
  final String? title1;
  final Widget? widget1;
  final String? title2;
  final Widget? widget2;

  final Widget nextRoute;

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
                  route: nextRoute,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                const PloopTitleBar(),
                !firstPage
                    ? IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon:
                            Image.asset('assets/images/navigate-back-icon.png'),
                      )
                    : SizedBox(
                        height: 70.h,
                      ),
                // body
                Container(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$question',
                          style: Theme.of(context).textTheme.headlineMedium),

                      SizedBox(height: 60.h),
                      // dropdown options
                      Column(
                        spacing: 82.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget1 != null) ...[
                            Column(
                              spacing: 8.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$title1',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                widget1!,
                              ],
                            ),
                          ],
                          if (widget2 != null) ...[
                            Column(
                              spacing: 8.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$title2',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                widget2!,
                              ],
                            ),
                          ],
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
