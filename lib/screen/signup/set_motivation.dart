import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/provider/user_prefs_provider.dart';
import 'package:ploop_fe/screen/signup/prefs_page_layout.dart';
import 'package:ploop_fe/screen/signup/widgets/option_button_set.dart';
import 'package:ploop_fe/theme.dart';

import 'set_area.dart';

class SetMotivationPage extends ConsumerStatefulWidget {
  const SetMotivationPage({super.key});

  @override
  ConsumerState<SetMotivationPage> createState() => _SetMotivationPageState();
}

class _SetMotivationPageState extends ConsumerState<SetMotivationPage> {
  final List<String> labelList = [
    "To contribute to the local community",
    "To relieve stress",
    "To participate in social trends or challenges",
    "For self-development",
    "To raise social awareness",
    "For health improvement"
  ];

  String? selectedMotivation;

  @override
  Widget build(BuildContext context) {
    return PrefsPageLayout(
        question: 'Please select your preferred keywords',
        title1: 'What motivates you to go plogging?',
        widget1: OptionButtonSet(
          alignColumn: true,
          options: [...labelList],
          selectedOption: selectedMotivation,
          onTap: (label) {
            setState(() {
              selectedMotivation = label;
            });
          },
        ),
        onButtonPressed: () {
          if (selectedMotivation == null) {
            if (Platform.isIOS) {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Oops!'),
                  content:
                      const Text('Please select your motivation of plogging.'),
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
                    'Please select your motivation of plogging.',
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
            return;
          }

          ref
              .read(userPreferenceNotifierProvider.notifier)
              .setMotivation(selectedMotivation!); // 깔끔하게 name만 추출

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SetAreaPage()),
          );

          //   final currentPrefs = ref.read(userPreferenceNotifierProvider);
          //   debugPrint(
          //       'Country: ${currentPrefs.country}\nRegion: ${currentPrefs.region}\nAge: ${currentPrefs.age}\nGender: ${currentPrefs.gender}\nNickname: ${currentPrefs.nickname}\nMotivation: ${currentPrefs.motivation}');
        });
  }
}
