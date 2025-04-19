import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ploop_fe/main.dart';
import 'package:ploop_fe/screen/signup/setup_page_template.dart';

import 'custom_input_field.dart';
import 'custom_datepicker.dart';
import 'custom_dropdown.dart';
import 'option_button_set.dart';

class SetRegionPage extends ConsumerWidget {
  const SetRegionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final AsyncValue<User> user = ref.watch(userProvider);
    return InfoSetupPage(
      firstPage: true,
      nextRoute: SetUserInfoPage(),
      question: 'Please select your country and region',
      title1: 'Country',
      // TODO: remove const when connecting database
      widget1: const CustomDropDownMenu(
        entryList: [
          'KR',
          'UK',
          'test3',
          'test4',
          'test5',
          'test6',
          'test7',
          'test8',
          'test9',
          'test10',
          'test11',
        ],
        // onChanged: (value) {
        //   ref.read(preferenceProvider.notifier).setCountry(value);
        // },
      ),
      title2: 'Region',
      widget2: const CustomDropDownMenu(
        entryList: ['Seoul', 'London'],
      ),
    );
  }
}

class SetUserInfoPage extends StatelessWidget {
  SetUserInfoPage({super.key});

  final List<String> labelList = ['Female', 'Male', 'Prefer not to say'];

  @override
  Widget build(BuildContext context) {
    return InfoSetupPage(
      nextRoute: const SetNicknamePage(),
      question: 'Select your date of birth and gender',
      title1: 'Date of Birth',
      // TODO: remove const when connecting database
      widget1: const UserBirthDatePicker(),
      title2: 'Gender',
      widget2: OptionButtonSet(
        options: [
          ...labelList,
        ],
        isMultiSelect: false,
      ),
    );
  }
}

class SetNicknamePage extends StatelessWidget {
  const SetNicknamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoSetupPage(
      nextRoute: SetDifficultyPage(),
      question: 'Enter your nickname',
      title1: 'Nickname',
      widget1: const NicknameInputField(),
      // widget1: const UserBirthDatePicker(),
    );
  }
}

class SetDifficultyPage extends StatelessWidget {
  SetDifficultyPage({super.key});

  final List<String> labelList = [
    "I'm a complete beginner",
    "I've tried it a few times",
    "I do it regularly"
  ];

  @override
  Widget build(BuildContext context) {
    return InfoSetupPage(
      nextRoute: SetMotivationPage(),
      question: 'What is the difficulty level of the plogging activity?',
      title1: 'Plogging Experience Level',
      widget1: OptionButtonSet(
        alignColumn: true,
        options: [
          ...labelList,
        ],
        isMultiSelect: false,
      ),
      // widget1: const UserBirthDatePicker(),
    );
  }
}

class SetMotivationPage extends StatelessWidget {
  SetMotivationPage({super.key});

  final List<String> labelList = [
    "To contribute to the local community",
    "To relieve stress",
    "To participate in social trends or challenges",
    "For self-development",
    "To raise social awareness",
    "For health improvement"
  ];
  @override
  Widget build(BuildContext context) {
    return InfoSetupPage(
      nextRoute: SetPreferencePage(),
      question: 'Please select your preferred keywords',
      title1: 'What motivates you to go plogging?',
      widget1: OptionButtonSet(
        alignColumn: true,
        options: [
          ...labelList,
        ],
        isMultiSelect: false,
      ),
      // widget1: const UserBirthDatePicker(),
    );
  }
}

class SetPreferencePage extends StatelessWidget {
  SetPreferencePage({super.key});

  final List<String> labelList = [
    "Nature (riverside paths, forest trails, parks)",
    "Urban alleys",
    "Historic sites / Cultural streets",
    "Coastal areas",
    "Around university campuses",
    "Hidden gems"
  ];

  @override
  Widget build(BuildContext context) {
    return InfoSetupPage(
      nextRoute: const FinishSetup(),
      question: 'Please select your preferred keywords\n(up to 3)',
      title1: 'Where do you prefer?',
      widget1: OptionButtonSet(
        alignColumn: true,
        options: [
          ...labelList,
        ],
        isMultiSelect: true,
        maxMultiSelect: 3,
      ),
    );
  }
}

class FinishSetup extends StatelessWidget {
  const FinishSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoSetupPage(
      lastPage: true,
      nextRoute: MainScaffold(),
      question: "Well done!\nNow let's go plogging together!",
    );
  }
}
// class FinishSetup extends ConsumerWidget {
//   const FinishSetup({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final preference = ref.read(preferenceProvider);

//     return InfoSetupPage(
//       lastPage: true,
//       nextRoute: const MainScaffold(),
//       question: "Well done!\nNow let's go plogging together!",
//       onPressed: () async {
//         final json = preference.toJson();
//         // 서버 전송 예시
//         await sendPreferencesToServer(json);
//       },
//     );
//   }
// }
