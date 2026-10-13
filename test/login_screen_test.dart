import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eventely/core/app_settings.dart';
import 'package:eventely/core/app_theme.dart';
import 'package:eventely/screens/home_screen.dart';
import 'package:eventely/screens/login_screen.dart';

Widget createTestWidget({required AppSettings settings, required Widget child}) {
  return SettingsScope(
    settings: settings,
    child: ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return MaterialApp(
          locale: settings.locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: settings.themeMode,
          home: child,
        );
      },
    ),
  );
}

void main() {
  testWidgets('LoginScreen renders correctly in Light Mode', (tester) async {
    final settings = AppSettings();
    settings.themeMode = ThemeMode.light;

    await tester.pumpWidget(
      createTestWidget(settings: settings, child: const LoginScreen()),
    );

    expect(find.text('Login to your account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Login With Google'), findsOneWidget);
  });

  testWidgets('LoginScreen renders correctly in Dark Mode', (tester) async {
    final settings = AppSettings();
    settings.themeMode = ThemeMode.dark;

    await tester.pumpWidget(
      createTestWidget(settings: settings, child: const LoginScreen()),
    );

    expect(find.text('Login to your account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('LoginScreen form validation triggers on empty submit', (tester) async {
    final settings = AppSettings();

    await tester.pumpWidget(
      createTestWidget(settings: settings, child: const LoginScreen()),
    );

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('LoginScreen navigates to HomeScreen on valid credentials', (tester) async {
    final settings = AppSettings();

    await tester.pumpWidget(
      createTestWidget(settings: settings, child: const LoginScreen()),
    );

    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'user@example.com');
    await tester.enterText(textFields.at(1), 'password123');

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
