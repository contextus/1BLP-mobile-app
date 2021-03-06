import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class HomeTabViewModel extends TabViewModelBase {
  HomeTabViewModel(this._gameManager, this._sharingService) {
    getLiveGame = _onGetLiveGame();
  }

  final GameManager _gameManager;

  final SharingService _sharingService;

  GameEntity game;

  Future<GameEntity> getLiveGame;

  Future<void> shareLiveGame(GameEntity gameToShare) =>
      _sharingService.share('Watch this game ${gameToShare.gameVideoUrl}');

  void refetchLiveGame() {
    getLiveGame = _onGetLiveGame();
    notifyListeners();
  }

  Future<GameEntity> _onGetLiveGame() async {
    debugInfo('Getting live game...');

    try {
      return game = await _gameManager.getLiveGame();
    } on Exception catch (e) {
      debugError('Failed to get current live game', e);
      rethrow;
    }
  }
}
