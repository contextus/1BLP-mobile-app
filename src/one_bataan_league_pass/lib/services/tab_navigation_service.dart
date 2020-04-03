import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:one_bataan_league_pass/views/views.dart';

abstract class TabNavigationService {
  void goToTab(String tabViewName, [Map<String, Object> parameters]);
}

class TabNavigationServiceImpl implements TabNavigationService {
  @override
  void goToTab(String tabViewName, [Map<String, Object> parameters]) =>
      _tabNavigator.navigateToTab(tabViewName, parameters);

  static MainTabViewState get _tabNavigator => MainTabViewKeys.tabNavigator.currentState;
}
