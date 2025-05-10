import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ploop_fe/provider/user_prefs_provider.dart';
import 'package:ploop_fe/screen/signup/prefs_page_layout.dart';
import 'package:ploop_fe/theme.dart';

import 'set_nickname.dart';
import 'widgets/custom_datepicker.dart';
import 'widgets/option_button_set.dart';

class SetPersonalInfoPage extends ConsumerStatefulWidget {
  const SetPersonalInfoPage({super.key});

  @override
  ConsumerState<SetPersonalInfoPage> createState() =>
      _SetPersonalInfoPageState();
}

class _SetPersonalInfoPageState extends ConsumerState<SetPersonalInfoPage> {
  // prevent conflict with maximum selectable date
  DateTime? birthDate;
  String gender = '';
  int age = -1;

  final DateTime _today = DateTime.now();

  final List<String> labelList = ['Female', 'Male', 'Prefer not to say'];
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return PrefsPageLayout(
      question: 'Select your date of birth and gender',
      title1: 'Date of Birth',
      widget1: UserBirthDatePicker(
        date: birthDate,
        onDateChanged: (DateTime value) {
          setState(() {
            birthDate = value;
            // debugPrint('selected birthdate: $birthDate');

            // calculate age
            age = DateTime.now().year - birthDate!.year;
            if (_today.month < birthDate!.month ||
                (_today.month == birthDate!.month &&
                    _today.day < birthDate!.day)) {
              age--;
            }

            // debugPrint('calculated age: $age');
          });
        },
      ),
      title2: 'Gender',
      widget2: OptionButtonSet(
        options: [...labelList],
        isMultiSelect: false,
        // maxMultiSelect: 1,
        selectedOption: gender,
        onTap: (label) {
          setState(() {
            gender = label;
          });
        },
      ),
      onButtonPressed: () {
        ref.read(userPreferenceNotifierProvider.notifier).setAge(age);
        ref.read(userPreferenceNotifierProvider.notifier).setGender(gender);

        if (age == -1 || gender == '') {
          if (Platform.isIOS) {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Oops!'),
                content: Text(
                    'Please select your ${age == -1 ? 'birthday' : 'gender'}.'),
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
                content: Text(
                  'Please select your ${age == -1 ? 'birthday' : 'gender'}.',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(letterSpacing: 0.45),
                ),
                actions: [
                  TextButton(
                    style:
                        TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: GrayScale.black),
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SetNicknamePage()),
          );

          // final currentPrefs = ref.read(userPreferenceNotifierProvider);
          // debugPrint(
          //     'Country: ${currentPrefs.country}\nRegion: ${currentPrefs.region}\nAge: ${currentPrefs.age}\nGender: ${currentPrefs.gender}');
        }
      },
    );
  }
}
