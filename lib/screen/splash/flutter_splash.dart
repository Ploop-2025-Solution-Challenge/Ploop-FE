import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ploop_fe/main.dart';
import 'package:ploop_fe/screen/onboarding/onboarding.dart';
import 'package:ploop_fe/service/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    final account = await GoogleSignIn().signInSilently();
    if (account != null) {
      final auth = await account.authentication;
      final idToken = auth.idToken;
      if (idToken != null) {
        await AuthService.sendIdTokenToServer(idToken);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScaffold()),
      );
    } else {
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
          'assets/ploop-logo.png',
        ),
      ),
    );
  }
}
