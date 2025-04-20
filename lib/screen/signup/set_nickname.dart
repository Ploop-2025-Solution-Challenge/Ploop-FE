import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ploop_fe/provider/user_prefs_provider.dart';
import 'package:ploop_fe/screen/signup/prefs_page_layout.dart';
import 'package:ploop_fe/screen/signup/widgets/custom_input_field.dart';

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
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Oops!'),
              content:
                  const Text('Please enter your nickname under 20 characters.'),
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
