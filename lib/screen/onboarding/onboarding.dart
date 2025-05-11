import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ploop_fe/screen/onboarding/waiting.dart';
import 'package:ploop_fe/service/auth_service.dart';
import 'package:ploop_fe/theme.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
);

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/onboarding-bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 173.h,
              left: 34.w,
              child: Image.asset('assets/images/onboarding-deco.png',
                  fit: BoxFit.cover, width: 334.w)),

          // title text
          Positioned(
            top: 91.h,
            child: Column(
              children: [
                DefaultTextStyle(
                    style:
                        TextStyle(fontFamily: 'PartialSansKR', fontSize: 30.sp),
                    child: const Text('Ploop')),

                // space
                SizedBox(
                  height: 353.h,
                ),
                // Info text
                Text("Let's do plogging!",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.white)),
                SizedBox(
                  height: 22.h,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Any place.\nAny time.\nMake a move, Make a change.\nPlog with us.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 14.sp,
                        color: Colors.white,
                        height: 1.92,
                        letterSpacing: 0.12.sp,
                      ),
                ),

                SizedBox(
                  height: 77.h,
                ),
                // sign in button
                const LoginButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  Future<void> _handleSignIn(BuildContext context, WidgetRef ref) async {
    try {
      final result = await _googleSignIn.signIn();
      if (result != null) {
        final auth = await result.authentication;
        final idToken = auth.idToken;

        if (idToken != null) {
          debugPrint('access: ${auth.accessToken}');
          debugPrint('idtoken: $idToken');
          await AuthService.sendIdTokenToServer(idToken, ref);
        }

        // check if context is valid
        if (!context.mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (builder) => const WaitingScreen(),
          ),
        );
      }
    } catch (error) {
      debugPrint("Sign-in error: $error");

      if (!context.mounted) return;
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Failed signing in with Google.')),
      // );
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Something went wrong.'),
            content:
                const Text('Failed signing in with Google.\nPlease try again.'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 122, 255),
                  ),
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
              'Something went wrong.',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                height: 1.33.h,
                letterSpacing: 0,
              ),
            ),
            content: Text(
              'Failed signing in with Google.\nPlease try again.',
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
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // custom sign-in button
    return SizedBox(
      // alignment: Alignment.center,
      width: 292.w,
      height: 53.h,
      // margin: const EdgeInsets.fromLTRB(55, 0, 55, 53),
      // padding: const EdgeInsets.fromLTRB(64, 16, 64, 16),
      // decoration: BoxDecoration(
      // borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor: Colors.white,
        ),
        onPressed: () => {_handleSignIn(context, ref)},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10.w,
          children: [
            Image.asset('assets/icons/signin-logo.png'),
            Text(
              'Start with Google',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(letterSpacing: 0.12.sp),
            )
          ],
        ),
      ),
    );
  }
}
