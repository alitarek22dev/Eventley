import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eventely/core/app_settings.dart';
import 'package:eventely/core/app_theme.dart';
import 'package:eventely/screens/home_screen.dart';
import 'package:eventely/screens/login_screen.dart';
import 'package:eventely/screens/reset_password_screen.dart';
import 'package:eventely/screens/sign_up_screen.dart';

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
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Navigation from LoginScreen', () {
    testWidgets('LoginScreen navigates to SignUpScreen on Signup tap', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const LoginScreen()),
      );

      final signupFinder = find.text('Signup');
      expect(signupFinder, findsOneWidget);

      await tester.ensureVisible(signupFinder);
      await tester.tap(signupFinder);
      await tester.pumpAndSettle();

      expect(find.byType(SignUpScreen), findsOneWidget);
      expect(find.text('Create your account'), findsOneWidget);
    });

    testWidgets('LoginScreen navigates to ResetPasswordScreen on Forgot Password tap', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const LoginScreen()),
      );

      final forgotFinder = find.text('Forgot Password?');
      expect(forgotFinder, findsOneWidget);

      await tester.tap(forgotFinder);
      await tester.pumpAndSettle();

      expect(find.byType(ResetPasswordScreen), findsOneWidget);
      expect(find.text('Forget Password'), findsOneWidget);
    });
  });

  group('SignUpScreen tests', () {
    testWidgets('SignUpScreen renders in Light and Dark Mode', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();
      settings.themeMode = ThemeMode.light;

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const SignUpScreen()),
      );

      expect(find.text('Create your account'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.text('Sign up'), findsOneWidget);
      expect(find.text('Sign up with Google'), findsOneWidget);

      // Dark Mode
      settings.themeMode = ThemeMode.dark;
      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const SignUpScreen()),
      );
      expect(find.text('Create your account'), findsOneWidget);
    });

    testWidgets('SignUpScreen validates empty fields and mismatched passwords', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const SignUpScreen()),
      );

      final signupButton = find.text('Sign up');
      await tester.ensureVisible(signupButton);
      await tester.tap(signupButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter your name'), findsOneWidget);
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
      expect(find.text('Please confirm your password'), findsOneWidget);

      // Enter mismatched passwords
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'John Doe');
      await tester.enterText(fields.at(1), 'john@example.com');
      await tester.enterText(fields.at(2), 'password123');
      await tester.enterText(fields.at(3), 'differentPassword');

      await tester.ensureVisible(signupButton);
      await tester.tap(signupButton);
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('SignUpScreen succeeds and navigates to HomeScreen on valid input', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const SignUpScreen()),
      );

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'John Doe');
      await tester.enterText(fields.at(1), 'john@example.com');
      await tester.enterText(fields.at(2), 'password123');
      await tester.enterText(fields.at(3), 'password123');

      final signupButton = find.text('Sign up');
      await tester.ensureVisible(signupButton);
      await tester.tap(signupButton);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('SignUpScreen pops back to LoginScreen on Login link tap', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(
          settings: settings,
          child: const LoginScreen(),
        ),
      );

      // Go to SignUpScreen
      final signupLink = find.text('Signup');
      await tester.ensureVisible(signupLink);
      await tester.tap(signupLink);
      await tester.pumpAndSettle();
      expect(find.byType(SignUpScreen), findsOneWidget);

      // Tap Login to go back
      final loginLink = find.text('Login');
      await tester.ensureVisible(loginLink);
      await tester.tap(loginLink);
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });

  group('ResetPasswordScreen tests', () {
    testWidgets('ResetPasswordScreen renders in Light and Dark Mode', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();
      settings.themeMode = ThemeMode.light;

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const ResetPasswordScreen()),
      );

      expect(find.text('Forget Password'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Reset password'), findsOneWidget);

      // Dark Mode
      settings.themeMode = ThemeMode.dark;
      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const ResetPasswordScreen()),
      );
      expect(find.text('Forget Password'), findsOneWidget);
    });

    testWidgets('ResetPasswordScreen validates email input', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const ResetPasswordScreen()),
      );

      final resetButton = find.text('Reset password');
      await tester.ensureVisible(resetButton);
      await tester.tap(resetButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter your email'), findsOneWidget);

      // Enter invalid email
      await tester.enterText(find.byType(TextFormField), 'not-an-email');
      await tester.tap(resetButton);
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email'), findsOneWidget);

      // Enter valid email
      await tester.enterText(find.byType(TextFormField), 'valid@example.com');
      await tester.tap(resetButton);
      await tester.pumpAndSettle();

      expect(find.text('Password reset link sent to your email'), findsOneWidget);
    });

    testWidgets('ResetPasswordScreen back button pops screen', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const LoginScreen()),
      );

      final forgotFinder = find.text('Forgot Password?');
      await tester.ensureVisible(forgotFinder);
      await tester.tap(forgotFinder);
      await tester.pumpAndSettle();
      expect(find.byType(ResetPasswordScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
