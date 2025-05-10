import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/provider/user_prefs_provider.dart';
import 'package:ploop_fe/screen/signup/prefs_page_layout.dart';
import 'package:ploop_fe/screen/signup/widgets/option_button_set.dart';
import 'package:ploop_fe/theme.dart';

import 'set_motivation.dart';

class SetDifficultyPage extends ConsumerStatefulWidget {
  const SetDifficultyPage({super.key});

  @override
  ConsumerState<SetDifficultyPage> createState() => _SetDifficultyPageState();
}

enum Difficulty {
  beginner,
  intermediate,
  advanced,
}

class _SetDifficultyPageState extends ConsumerState<SetDifficultyPage> {
  final List<(String, Difficulty)> difficultyOptions = [
    ("I'm a complete beginner", Difficulty.beginner),
    ("I've tried it a few times", Difficulty.intermediate),
    ("I do it regularly", Difficulty.advanced),
  ];

  String selectedLabel = '';
  Difficulty? selectedDifficulty;

  @override
  Widget build(BuildContext context) {
    return PrefsPageLayout(
        question: 'What is the difficulty level of the plogging activity?',
        title1: 'Plogging Experience Level',
        widget1: OptionButtonSet(
          alignColumn: true,
          options: difficultyOptions.map((e) => e.$1).toList(),
          selectedOption: selectedDifficulty == null
              ? ''
              : difficultyOptions
                  .firstWhere((e) => e.$2 == selectedDifficulty)
                  .$1,
          onTap: (label) {
            setState(() {
              selectedDifficulty =
                  difficultyOptions.firstWhere((e) => e.$1 == label).$2;
            });
          },
        ),
        onButtonPressed: () {
          if (selectedDifficulty == null) {
            if (Platform.isIOS) {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Oops!'),
                  content: const Text(
                      'Please select your plogging experience level.'),
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
                    'Please select your plogging experience level.',
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
              .setDifficulty(selectedDifficulty!.name);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SetMotivationPage()),
          );

          // final currentPrefs = ref.read(userPreferenceNotifierProvider);
          // debugPrint(
          //     'Country: ${currentPrefs.country}\nRegion: ${currentPrefs.region}\nAge: ${currentPrefs.age}\nGender: ${currentPrefs.gender}\nNickname: ${currentPrefs.nickname}\nDifficulty: ${currentPrefs.difficulty}');
        });
  }
}
