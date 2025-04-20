import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ploop_fe/screen/signup/set_region.dart';
import 'package:ploop_fe/service/auth_service.dart';

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
    /* ERROR */
    return Stack(alignment: Alignment.center, children: [
      Image.asset(
        'assets/images/onboarding-bg.jpg',
        width: 402.w,
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
          child: Column(children: [
            DefaultTextStyle(
                style: TextStyle(fontFamily: 'PartialSansKR', fontSize: 30.sp),
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
                    letterSpacing: -0.08,
                  ),
            ),

            SizedBox(
              height: 77.h,
            ),
            // sign in button
            const LoginButton(),
          ]))
    ]);
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      final result = await _googleSignIn.signIn();
      if (result != null) {
        final auth = await result.authentication;
        final idToken = auth.idToken;

        if (idToken != null) {
          debugPrint(auth.accessToken);
          debugPrint('\n');
          debugPrint(idToken);
          await AuthService.sendIdTokenToServer(idToken);
        }

        // check if context is valid
        if (!context.mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SetRegionPage()),
        );
      }
    } catch (error) {
      debugPrint("Sign-in error: $error");

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed signing in with Google.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: () => {_handleSignIn(context)},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10.w,
          children: [
            Image.asset('assets/images/signin-logo.png'),
            Text(
              'Start with Google',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
