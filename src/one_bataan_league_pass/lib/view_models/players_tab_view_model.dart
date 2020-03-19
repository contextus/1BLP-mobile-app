import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class PlayersTabViewModel extends TabViewModelBase {
  PlayersTabViewModel(this._playerManager, this._teamManager, NavigationService navigationService)
      : super(navigationService) {
    getPlayers = _onGetPlayers();
  }

  final PlayerManager _playerManager;
  final TeamManager _teamManager;

  final searchCriterias = ['All Players', 'By Team', 'By Position'];

  int selectedCriteriaIndex = 0;

  List<PlayerEntity> players;

  List<TeamEntity> teams;

  Future<List<PlayerEntity>> getPlayers;

  Future<List<TeamEntity>> getTeams;

  void onSelectedSearchCriteriaChanged(int index) {
    selectedCriteriaIndex = index;

    debugInfo('Search players by: ${searchCriterias[selectedCriteriaIndex]}');

    switch (index) {
      case 0:
        getPlayers = _onGetPlayers();
        break;

      case 1:
        getTeams = _onGetTeams();
        break;

      case 2:
        getPlayers = _onGetPlayers();
        break;
    }

    notifyListeners();
  }

  void onSearchKeywordChanged(String keyword) {
    notifyListeners();
  }

  void onViewPlayerProfile(PlayerEntity selectedPlayer) {
    navigationService.push(
      ViewNames.playerProfileView,
      {NavigationParameterConstants.selectedPlayerProfileToView: selectedPlayer},
    );
  }

  void onViewTeamProfile(TeamEntity selectedTeam) {
    navigationService.push(
      ViewNames.teamProfileView,
      {NavigationParameterConstants.selectedTeamProfileToView: selectedTeam},
    );
  }

  void refetchPlayers() => onSelectedSearchCriteriaChanged(selectedCriteriaIndex);

  Future<List<PlayerEntity>> _onGetPlayers() async {
    debugInfo('Getting players...');

    try {
      return players = await _playerManager.getPlayers();
    } on Exception catch (e) {
      debugError('Failed to retrieve players', e);
      rethrow;
    }
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
