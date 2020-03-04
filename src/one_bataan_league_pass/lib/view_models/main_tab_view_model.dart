import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class MainTabViewModel extends ViewModelBase {
  MainTabViewModel(NavigationService navigationService) : super(navigationService);

  int _currentIndex = 0;
  int get currentPageIndex => _currentIndex;
  set currentPageIndex(int value) {
    if (_currentIndex != value) {
      _currentIndex = value;
      notifyListeners('currentPageIndex');
    }
  }

  Future<void> onViewUserProfile() => navigationService.push(ViewNames.userProfileView);
}
