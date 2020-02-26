// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:one_bataan_league_pass/service_locator.dart';
import 'package:one_bataan_league_pass/view_models/app_view_model.dart';

import 'package:one_bataan_league_pass/views/views.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/services_mocks.dart';

void main() {
  MockAnalyticsService mockAnalytics;
  MockNavigationService mockNavigation;
  AppView widget;

  setUpAll(() {
    ServiceLocator.registerDependencies();
  });

  setUp(() {
    mockAnalytics = MockAnalyticsService();
    mockNavigation = MockNavigationService();
    widget = AppView(AppViewModel(mockAnalytics, mockNavigation));
  });

  group(AppView, () {
    testWidgets('Verify splash widget is shown', (tester) async {
      // Act
      await tester.pumpWidget(widget);
      // Assert
      expect(find.byKey(AppViewKeys.splashWidget), findsOneWidget);
    });
  });
}
