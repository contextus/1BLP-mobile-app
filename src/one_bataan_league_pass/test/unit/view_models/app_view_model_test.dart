import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/services_mocks.dart';

void main() {
  group(AppViewModel, () {
    AppViewModel unit;
    final mockAnalytics = MockAnalyticsService();
    final mockNavigation = MockNavigationService();

    setUp(() {
      unit = AppViewModel(mockAnalytics, mockNavigation);
    });

    test('Verify initialization', () async {
      // Act
      await unit.init();

      // Assert
      verify(mockAnalytics.start()).called(1);
      verify(mockNavigation.pushToNewRoot(ViewNames.homeTabView)).called(1);
    });
  });
}
