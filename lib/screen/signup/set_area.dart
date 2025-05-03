import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ploop_fe/provider/user_prefs_provider.dart';
import 'package:ploop_fe/screen/signup/prefs_page_layout.dart';
import 'package:ploop_fe/screen/signup/finish_prefs_setup.dart';
import 'package:ploop_fe/screen/signup/widgets/option_button_set.dart';

class SetAreaPage extends ConsumerStatefulWidget {
  const SetAreaPage({super.key});

  @override
  ConsumerState<SetAreaPage> createState() => _SetAreaPageState();
}

class _SetAreaPageState extends ConsumerState<SetAreaPage> {
  final List<String> labelList = [
    "Nature (riverside paths, forest trails, parks)",
    "Urban alleys",
    "Historic sites / Cultural streets",
    "Coastal areas",
    "Around university campuses",
    "Hidden gems"
  ];

  Set<String> preferredArea = {};

  @override
  Widget build(BuildContext context) {
    return PrefsPageLayout(
      question: 'Please select your preferred keywords\n(up to 3)',
      title1: 'Where do you prefer?',
      widget1: OptionButtonSet(
        alignColumn: true,
        options: [...labelList],
        isMultiSelect: true,
        maxMultiSelect: 3,
        selectedOptions: preferredArea,
        onTap: (label) {
          setState(() {
            if (preferredArea.contains(label)) {
              preferredArea.remove(label);
              // } else if (selectedOptions.length < 3) {
              // selectedOptions.add(label);
            } else {
              preferredArea.add(label);
            }
          });
        },
      ),
      onButtonPressed: () {
        if (preferredArea.isEmpty) {
          if (Platform.isIOS) {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Oops!'),
                content: const Text('Please select at least 1 keyword.'),
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
                title: const Text('Oops!'),
                content: const Text('Please select at least 1 keyword.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Color.fromARGB(255, 0, 122, 255)),
                    ),
                  ),
                ],
              ),
            );
          }
          return;
        } else if (preferredArea.length > 3) {
          if (Platform.isIOS) {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Oops!'),
                content: const Text('Please select up to 3 keywords.'),
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
                title: const Text('Oops!'),
                content: const Text('Please select up to 3 keywords.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Color.fromARGB(255, 0, 122, 255)),
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
            .setPreferredAreas(preferredArea.toList());

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FinishSetup()),
        );
        //   final currentPrefs = ref.read(userPreferenceNotifierProvider);
        //   debugPrint(
        //       'Country: ${currentPrefs.country}\nRegion: ${currentPrefs.region}\nAge: ${currentPrefs.age}\nGender: ${currentPrefs.gender}\nNickname: ${currentPrefs.nickname}\nDifficulty: ${currentPrefs.difficulty}\nMotivation: ${currentPrefs.motivation}\nPreferredArea: ${currentPrefs.preferredArea}');
      },
    );
  }
}
