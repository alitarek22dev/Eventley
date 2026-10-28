import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eventely/core/app_settings.dart';
import 'package:eventely/core/app_theme.dart';
import 'package:eventely/screens/home_screen.dart';
import 'package:eventely/screens/login_screen.dart';
import 'package:eventely/services/auth_service.dart';

class FakeAuthService extends AuthService {
  final bool shouldSucceed;
  final String? errorCode;

  FakeAuthService({this.shouldSucceed = true, this.errorCode});

  @override
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (shouldSucceed) {
      return null;
    }
    throw FirebaseAuthException(
      code: errorCode ?? 'user-not-found',
      message: 'Authentication failed',
    );
  }

  @override
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    if (shouldSucceed) {
      return null;
    }
    throw FirebaseAuthException(
      code: errorCode ?? 'email-already-in-use',
      message: 'Sign up failed',
    );
  }

  @override
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    if (shouldSucceed) {
      return;
    }
    throw FirebaseAuthException(
      code: errorCode ?? 'user-not-found',
      message: 'Password reset failed',
    );
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    if (shouldSucceed) {
      return null;
    }
    throw FirebaseAuthException(
      code: errorCode ?? 'sign_in_canceled',
      message: 'Google Sign-In failed',
    );
  }

  @override
  Future<void> signOut() async {
    if (shouldSucceed) {
      return;
    }
    throw FirebaseAuthException(
      code: errorCode ?? 'sign-out-failed',
      message: 'Sign out failed',
    );
  }
}

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
      createTestWidget(
        settings: settings,
        child: LoginScreen(authService: FakeAuthService()),
      ),
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
      createTestWidget(
        settings: settings,
        child: LoginScreen(authService: FakeAuthService()),
      ),
    );

    expect(find.text('Login to your account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('LoginScreen form validation triggers on empty submit', (tester) async {
    final settings = AppSettings();

    await tester.pumpWidget(
      createTestWidget(
        settings: settings,
        child: LoginScreen(authService: FakeAuthService()),
      ),
    );

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('LoginScreen navigates to HomeScreen on successful credentials', (tester) async {
    final settings = AppSettings();

    await tester.pumpWidget(
      createTestWidget(
        settings: settings,
        child: LoginScreen(authService: FakeAuthService(shouldSucceed: true)),
      ),
    );

    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'user@example.com');
    await tester.enterText(textFields.at(1), 'password123');

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('LoginScreen displays localized error SnackBar on authentication error', (tester) async {
    final settings = AppSettings();

    await tester.pumpWidget(
      createTestWidget(
        settings: settings,
        child: LoginScreen(
          authService: FakeAuthService(shouldSucceed: false, errorCode: 'user-not-found'),
        ),
      ),
    );

    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'unknown@example.com');
    await tester.enterText(textFields.at(1), 'password123');

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('No account found with this email'), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('LoginScreen triggers Google Sign-In and navigates on success', (tester) async {
    final settings = AppSettings();

    await tester.pumpWidget(
      createTestWidget(
        settings: settings,
        child: LoginScreen(authService: FakeAuthService(shouldSucceed: true)),
      ),
    );

    final googleButtonFinder = find.text('Login With Google');
    await tester.ensureVisible(googleButtonFinder);
    await tester.tap(googleButtonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
