import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ploop_fe/main.dart';
import 'package:ploop_fe/screen/onboarding/onboarding.dart';
import 'package:ploop_fe/service/auth_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    // final account = await GoogleSignIn().signIn(); // TEST
    final account = await GoogleSignIn().signInSilently(); // PROD
    if (account != null) {
      final auth = await account.authentication;

      final idToken = auth.idToken;

      if (idToken != null) {
        final authToken = await AuthService.sendIdTokenToServer(idToken, ref);

        // new user
        if (authToken == null && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const OnboardingPage()),
          );
          return;
        }
      }

      // silent sign in successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScaffold()),
      );
    }
    // failed to sign in silently
    else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/logo/ploop-logo-3x.png',
          width: 140.w,
        ),
      ),
    );
  }
}
