import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ploop_fe/provider/user_prefs_provider.dart';
import 'package:ploop_fe/screen/home/home.dart';
import 'package:ploop_fe/screen/signup/prefs_page_layout.dart';
import 'package:ploop_fe/service/user_service.dart';

class FinishSetup extends ConsumerWidget {
  const FinishSetup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preference = ref.read(userPreferenceNotifierProvider);

    return PrefsPageLayout(
        lastPage: true,
        question: "Well done!\nNow let's go plogging together!",
        onButtonPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
          );
          debugPrint(preference.toString());
          await UserService.patchUserProfileToServer(preference);
        });
  }
}
