import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class MainTabViewModel extends TabViewModelBase {
  MainTabViewModel(NavigationService navigationService) : super(navigationService);

  int currentTabIndex = 0;

  Future<void> onViewUserProfile() => navigationService.push(ViewNames.userProfileView);
}
