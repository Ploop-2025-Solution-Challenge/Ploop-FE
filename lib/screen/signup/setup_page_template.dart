import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/provider/user_prefs_provider.dart';

import '../home/ploop_appbar.dart';
import 'next_button.dart';

class InfoSetupPage extends ConsumerStatefulWidget {
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
  ConsumerState<InfoSetupPage> createState() => _InfoSetupPageState();
}

class _InfoSetupPageState extends ConsumerState<InfoSetupPage> {
  String? country;
  String? region;
  int? age;
  String? gender;
  String? nickname;
  String? difficulty;
  String? motivation;
  List<String>? preferredAreas;

  String prefsKey = '';

  void applyChange() {
    if (prefsKey == 'country') {
      ref.read(userPreferenceNotifierProvider.notifier).setCountry(country!);
    } else if (prefsKey == 'region') {
      ref.read(userPreferenceNotifierProvider.notifier).setRegion(region!);
    } else if (prefsKey == 'age') {
      ref.read(userPreferenceNotifierProvider.notifier).setRegion(region!);
    } else if (prefsKey == 'gender') {
      ref.read(userPreferenceNotifierProvider.notifier).setAge(age!);
    }
    // ...
  }

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
                  route: widget.nextRoute,
                  onPressed: applyChange,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                const PloopTitleBar(),
                !widget.firstPage
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
                      Text('${widget.question}',
                          style: Theme.of(context).textTheme.headlineMedium),

                      SizedBox(height: 60.h),
                      // dropdown options
                      Column(
                        spacing: 82.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.widget1 != null) ...[
                            Column(
                              spacing: 8.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.title1}',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                widget.widget1!,
                              ],
                            ),
                          ],
                          if (widget.widget2 != null) ...[
                            Column(
                              spacing: 8.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.title2}',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                widget.widget2!,
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
