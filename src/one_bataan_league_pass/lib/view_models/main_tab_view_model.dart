import 'package:arch/arch.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class MainTabViewModel extends ViewModelBase {
  MainTabViewModel(NavigationService navigationService) : super(navigationService: navigationService);

  int currentTabIndex = 0;

  Future<void> onViewUserProfile() => navigationService.push(ViewNames.userProfileView);
}
