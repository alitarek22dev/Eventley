import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eventely/core/app_settings.dart';
import 'package:eventely/core/app_theme.dart';
import 'package:eventely/screens/favorites_screen_tab.dart';
import 'package:eventely/screens/home_screen.dart';
import 'package:eventely/screens/home_screen_tab.dart';
import 'package:eventely/screens/profile_screen_tab.dart';
import 'package:eventely/widgets/event_card.dart';

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

  group('HomeScreen and Main Navigation tests', () {
    testWidgets('HomeScreen renders 3 BottomNavigationBar tabs and IndexedStack', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const HomeScreen()),
      );

      // Verify BottomNavigationBar and 3 tabs by text labels
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.descendant(of: find.byType(BottomNavigationBar), matching: find.text('Home')), findsOneWidget);
      expect(find.descendant(of: find.byType(BottomNavigationBar), matching: find.text('Favorites')), findsOneWidget);
      expect(find.descendant(of: find.byType(BottomNavigationBar), matching: find.text('Profile')), findsOneWidget);

      // Verify FAB on Home tab
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Initially on Home tab
      expect(find.byType(HomeScreenTab), findsOneWidget);
    });

    testWidgets('Switching tabs via BottomNavigationBar preserves state and hides/shows FAB', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const HomeScreen()),
      );

      // Switch to Favorites tab
      await tester.tap(find.descendant(of: find.byType(BottomNavigationBar), matching: find.text('Favorites')));
      await tester.pumpAndSettle();

      expect(find.byType(FavoritesScreenTab), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsNothing);

      // Switch to Profile tab
      await tester.tap(find.descendant(of: find.byType(BottomNavigationBar), matching: find.text('Profile')));
      await tester.pumpAndSettle();

      expect(find.byType(ProfileScreenTab), findsOneWidget);
      expect(find.text('ROUTE'), findsOneWidget);
      expect(find.text('Dark Mode'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsNothing);

      // Switch back to Home tab
      await tester.tap(find.descendant(of: find.byType(BottomNavigationBar), matching: find.text('Home')));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreenTab), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('Category filtering on Home tab filters events', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const HomeScreen()),
      );

      // All category initially shows sample events
      expect(find.byType(EventCard), findsNWidgets(5));

      // Tap Birthday category
      await tester.tap(find.text('Birthday'));
      await tester.pumpAndSettle();

      expect(find.byType(EventCard), findsNWidgets(1));
      expect(find.text('This is a Birthday Party'), findsOneWidget);

      // Tap All to restore
      await tester.tap(find.text('All'));
      await tester.pumpAndSettle();

      expect(find.byType(EventCard), findsNWidgets(5));
    });

    testWidgets('Toggling favorites synchronizes between Home and Favorites tabs', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const HomeScreen()),
      );

      // Initially, 1 favorite exists (event #1). Toggle favorite on event #2
      final favoriteButtons = find.descendant(of: find.byType(EventCard), matching: find.byIcon(Icons.favorite_border));
      expect(favoriteButtons, findsWidgets);
      await tester.tap(favoriteButtons.first);
      await tester.pumpAndSettle();

      // Go to Favorites tab
      await tester.tap(find.descendant(of: find.byType(BottomNavigationBar), matching: find.text('Favorites')));
      await tester.pumpAndSettle();

      expect(find.byType(EventCard), findsNWidgets(2));
    });

    testWidgets('Profile tab supports Dark Mode switch toggle', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final settings = AppSettings();

      await tester.pumpWidget(
        createTestWidget(settings: settings, child: const HomeScreen()),
      );

      // Go to Profile tab
      await tester.tap(find.descendant(of: find.byType(BottomNavigationBar), matching: find.text('Profile')));
      await tester.pumpAndSettle();

      expect(settings.isDark, isFalse);

      // Toggle dark mode switch
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(settings.isDark, isTrue);
    });
  });
}
