import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class PlayersTabViewModel extends TabViewModelBase {
  PlayersTabViewModel(this._playerManager, NavigationService navigationService) : super(navigationService) {
    getPlayers = _onGetPlayers();
  }

  final PlayerManager _playerManager;

  final searchCriterias = ['All Players', 'By Team', 'By Position'];

  int selectedCriteriaIndex = 0;

  List<PlayerEntity> players;

  Future<List<PlayerEntity>> getPlayers;

  void onSelectedSearchCriteriaChanged(int index) {
    selectedCriteriaIndex = index;

    debugInfo('Search players by: ${searchCriterias[selectedCriteriaIndex]}');

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

  void refetchPlayers() {
    getPlayers = _onGetPlayers();
    notifyListeners();
  }

  Future<List<PlayerEntity>> _onGetPlayers() async {
    debugInfo('Getting players...');

    try {
      return players = await _playerManager.getPlayers();
    } on Exception catch (e) {
      debugError('Failed to retrieve players', e);
      rethrow;
    }
  }
}
