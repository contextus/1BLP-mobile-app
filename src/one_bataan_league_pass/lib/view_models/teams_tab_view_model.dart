import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class TeamsTabViewModel extends TabViewModelBase {
  TeamsTabViewModel(this._teamManager, NavigationService navigationService) : super(navigationService) {
    getTeams = _onGetTeams();
  }

  final TeamManager _teamManager;

  List<TeamEntity> teams;

  Future<List<TeamEntity>> getTeams;

  void refetchTeams() {
    getTeams = _onGetTeams();
    notifyListeners();
  }

  void onViewTeamProfile(TeamEntity selectedTeam) {
    navigationService.push(
      ViewNames.teamProfileView,
      {NavigationParameterConstants.selectedTeamProfileToView: selectedTeam},
    );
  }

  Future<List<TeamEntity>> _onGetTeams() async {
    debugInfo('Getting teams...');

    try {
      return teams = await _teamManager.getTeams();
    } on Exception catch (e) {
      debugError('Failed to retrieve teams', e);
      rethrow;
    }
  }
}
