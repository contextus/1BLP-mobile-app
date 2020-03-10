import 'package:flutter/foundation.dart';
import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class MainTabViewModel extends ViewModelBase {
  MainTabViewModel(NavigationService navigationService) : super(navigationService);

  VoidCallback _navigatedFromCallback;

  int currentTabIndex = 0;

  void addOnNavigatedFrom(VoidCallback callback) => _navigatedFromCallback = callback;

  Future<void> onViewUserProfile() {
    if (_navigatedFromCallback != null) _navigatedFromCallback();
    return navigationService.push(ViewNames.userProfileView);
  }
}
