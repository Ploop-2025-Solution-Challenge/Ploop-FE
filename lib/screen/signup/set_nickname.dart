import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/provider/user_prefs_provider.dart';
import 'package:ploop_fe/screen/signup/prefs_page_layout.dart';
import 'package:ploop_fe/screen/signup/widgets/custom_input_field.dart';
import 'package:ploop_fe/theme.dart';

import 'set_difficulty.dart';

class SetNicknamePage extends ConsumerStatefulWidget {
  const SetNicknamePage({super.key});

  @override
  ConsumerState<SetNicknamePage> createState() => _SetNicknamePageState();
}

class _SetNicknamePageState extends ConsumerState<SetNicknamePage> {
  String nickname = '';

  @override
  Widget build(BuildContext context) {
    return PrefsPageLayout(
      question: 'Enter your nickname',
      title1: 'Nickname',
      widget1: NicknameInputField(
          nickname: nickname,
          onChanged: (val) {
            setState(() {
              nickname = val;
            });
          }),
      onButtonPressed: () {
        ref.read(userPreferenceNotifierProvider.notifier).setNickname(nickname);

        if (nickname == '') {
          if (Platform.isIOS) {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Oops!'),
                content: const Text(
                    'Please enter your nickname under 20 characters.'),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Color.fromARGB(255, 0, 122, 255)),
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
                  'Please enter your nickname under 20 characters.',
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
            MaterialPageRoute(builder: (context) => const SetDifficultyPage()),
          );

          // final currentPrefs = ref.read(userPreferenceNotifierProvider);
          // debugPrint(
          //     'Country: ${currentPrefs.country}\nRegion: ${currentPrefs.region}\nAge: ${currentPrefs.age}\nGender: ${currentPrefs.gender}\nNickname: ${currentPrefs.nickname}\n');
        }
      },
    );
  }
}
