import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';
import '../core/app_settings.dart';
import '../core/app_strings.dart';
import '../widgets/onboarding_controls.dart';
import 'login_screen.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finish() async {
    await SettingsScope.of(context).completeOnboarding();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final settings = SettingsScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _controller,
          children: [
            _IntroPage(
              strings: strings,
              settings: settings,
              onStart: () => _goTo(1),
            ),
            _ContentPage(
              image: AppAssets.onboarding2,
              title: strings.findEventsTitle,
              body: strings.findEventsBody,
              pageIndex: 0,
              showBack: false,
              buttonLabel: strings.next,
              onBack: () => _goTo(0),
              onNext: () => _goTo(2),
            ),
            _ContentPage(
              image: AppAssets.onboarding3,
              title: strings.planningTitle,
              body: strings.planningBody,
              pageIndex: 1,
              showBack: true,
              buttonLabel: strings.next,
              onBack: () => _goTo(1),
              onNext: () => _goTo(3),
            ),
            _ContentPage(
              image: AppAssets.onboarding4,
              title: strings.connectTitle,
              body: strings.connectBody,
              pageIndex: 2,
              showBack: true,
              buttonLabel: strings.getStarted,
              onBack: () => _goTo(2),
              onNext: _finish,
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  const _IntroPage({
    required this.strings,
    required this.settings,
    required this.onStart,
  });

  final AppStrings strings;
  final AppSettings settings;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Image.asset(AppAssets.logo, height: 50),
          const SizedBox(height: 24),
          Expanded(
            child: Image.asset(AppAssets.onboarding1, fit: BoxFit.contain),
          ),
          const SizedBox(height: 16),
          Text(
            strings.personalizeTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            strings.personalizeBody,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                strings.language,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              LanguageToggle(
                isArabic: settings.isArabic,
                onChanged: (isArabic) {
                  settings.setLanguage(isArabic ? 'ar' : 'en');
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Spacer(),
              ThemeToggle(
                isDark: settings.isDark,
                onChanged: settings.setDark,
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppPrimaryButton(label: strings.letsStart, onPressed: onStart),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _ContentPage extends StatelessWidget {
  const _ContentPage({
    required this.image,
    required this.title,
    required this.body,
    required this.pageIndex,
    required this.showBack,
    required this.buttonLabel,
    required this.onBack,
    required this.onNext,
  });

  final String image;
  final String title;
  final String body;
  final int pageIndex;
  final bool showBack;
  final String buttonLabel;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Center(child: Image.asset(AppAssets.logo, height: 50)),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.32,
                    child: Image.asset(image, fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (showBack)
                CircleNavButton(
                  icon: Icons.arrow_back,
                  onTap: onBack,
                )
              else
                const SizedBox(width: 40, height: 40),
              Expanded(child: PageDots(count: 3, index: pageIndex)),
              const SizedBox(width: 40, height: 40),
            ],
          ),
          const SizedBox(height: 16),
          AppPrimaryButton(label: buttonLabel, onPressed: onNext),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
