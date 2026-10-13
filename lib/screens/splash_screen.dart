import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_settings.dart';
import 'login_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 3), _openNext);
  }

  void _openNext() {
    if (!mounted) return;
    final completed = SettingsScope.of(context).onboardingCompleted;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>
            completed ? const LoginScreen() : const OnboardingScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppAssets.logo),
      ),
    );
  }
}
