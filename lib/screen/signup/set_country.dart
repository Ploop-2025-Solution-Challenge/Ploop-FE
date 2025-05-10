import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/provider/user_prefs_provider.dart';
import 'package:ploop_fe/screen/signup/prefs_page_layout.dart';
import 'package:ploop_fe/theme.dart';
import 'set_personal_info.dart';
import 'widgets/custom_dropdown.dart';

class SetRegionPage extends ConsumerStatefulWidget {
  const SetRegionPage({
    super.key,
    required this.countries,
  });
  final List<String> countries;

  @override
  ConsumerState<SetRegionPage> createState() => _SetRegionPageState();
}

class _SetRegionPageState extends ConsumerState<SetRegionPage> {
  String country = '';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: PrefsPageLayout(
        firstPage: true,
        question: 'Please select your country',
        title1: 'Country',
        widget1: CustomDropDownMenu(
          selected: country,
          onSelected: ((val) => setState(() {
                country = val;
                debugPrint('selected $val');
              })),
          entryList: widget.countries,
        ),
        onButtonPressed: () {
          ref
              .watch(userPreferenceNotifierProvider.notifier)
              .setCountry(country);

          if (country == '') {
            if (Platform.isIOS) {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Oops!'),
                  content: const Text('Please select your country.'),
                  actions: [
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'OK',
                        style:
                            TextStyle(color: Color.fromARGB(255, 0, 122, 255)),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Oops!',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.33.h,
                      letterSpacing: 0,
                    ),
                  ),
                  content: Text(
                    'Please select your country.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.43.h,
                      letterSpacing: 0.25,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'OK',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14.sp,
                            height: 1.43.h,
                            color: GrayScale.black),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SetPersonalInfoPage()),
            );
          }

          // final currentPrefs = ref.read(userPreferenceNotifierProvider);
          // debugPrint(
          // 'Country: ${currentPrefs.country}, Region: ${currentPrefs.region}');
        },
      ),
    );
  }
}
