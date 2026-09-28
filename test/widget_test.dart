import 'package:flutter_test/flutter_test.dart';

import 'package:eventely/core/app_settings.dart';
import 'package:eventely/main.dart';
import 'package:eventely/screens/splash_screen.dart';

void main() {
  testWidgets('App opens on the splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(EventlyApp(settings: AppSettings()));
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
