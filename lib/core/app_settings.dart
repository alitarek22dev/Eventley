import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  static const String languageKey = 'language';
  static const String themeKey = 'theme';
  static const String onboardingCompletedKey = 'onboardingCompleted';

  Locale locale = const Locale('en');
  ThemeMode themeMode = ThemeMode.light;
  bool onboardingCompleted = false;

  bool get isArabic => locale.languageCode == 'ar';
  bool get isDark => themeMode == ThemeMode.dark;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(languageKey) ?? 'en';
    locale = Locale(languageCode);
    final theme = prefs.getString(themeKey) ?? 'light';
    themeMode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    onboardingCompleted = prefs.getBool(onboardingCompletedKey) ?? false;
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    locale = Locale(languageCode);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, languageCode);
  }

  Future<void> setDark(bool dark) async {
    themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeKey, dark ? 'dark' : 'light');
  }

  Future<void> completeOnboarding() async {
    onboardingCompleted = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingCompletedKey, true);
  }
}

class SettingsScope extends InheritedNotifier<AppSettings> {
  const SettingsScope({
    super.key,
    required AppSettings settings,
    required super.child,
  }) : super(notifier: settings);

  static AppSettings of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SettingsScope>();
    assert(scope != null, 'SettingsScope not found in context');
    return scope!.notifier!;
  }
}
