import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class PlayersTabViewModel extends TabViewModelBase {
  PlayersTabViewModel(this._playerManager) {
    getPlayers = _onGetPlayers();
  }

  final PlayerManager _playerManager;

  final choices = ['All Players', 'By Team', 'By Position'];

  int selectedChoiceIndex = 0;

  List<PlayerEntity> players;

  Future<List<PlayerEntity>> getPlayers;

  void onSelectedChoiceIndexChanged(int index) {
    selectedChoiceIndex = index;

    debugInfo('Filter players by: ${choices[selectedChoiceIndex]}');

    // TODO: Fix sort
    switch (selectedChoiceIndex) {
      case 0:
        players.sort((a, b) => a.playerName.compareTo(b.playerName));
        break;

      case 1:
        players.sort((a, b) => a.playerTeam.teamName.compareTo(b.playerTeam.teamName));
        break;

      case 2:
        players.sort((a, b) => a.formattedPositions.compareTo(b.formattedPositions));
        break;
    }

    notifyListeners();
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
