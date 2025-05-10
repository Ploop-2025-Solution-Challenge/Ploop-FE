import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ploop_fe/provider/country_list_provider.dart';
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
    return PrefsPageLayout(
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
        ref.watch(userPreferenceNotifierProvider.notifier).setCountry(country);

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
                content: const Text('Please select your country.'),
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
    );
  }
}
