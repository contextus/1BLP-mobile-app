import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class MainTabViewModel extends ViewModelBase {
  MainTabViewModel(
    NavigationService navigationService,
    this.homeTabViewModel,
    this.gamesTabViewModel,
    this.standingsTabViewModel,
    this.playersTabViewModel,
    this.teamsTabViewModel,
  ) : super(navigationService);

  final HomeTabViewModel homeTabViewModel;
  final GamesTabViewModel gamesTabViewModel;
  final StandingsTabViewModel standingsTabViewModel;
  final PlayersTabViewModel playersTabViewModel;
  final TeamsTabViewModel teamsTabViewModel;

  int currentTabIndex = 0;

  Future<void> onViewUserProfile() {
    return navigationService.push(ViewNames.userProfileView);
  }
}
