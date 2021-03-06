import 'package:arch/arch.dart';
import 'package:intl/intl.dart';
import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class GamesTabViewModel extends TabViewModelBase {
  GamesTabViewModel(
    NavigationService navigationService,
    TabNavigationService tabNavigationService,
    this._gameManager,
  ) : super(navigationService: navigationService, tabNavigationService: tabNavigationService) {
    getGamesForDate = _onGetGamesForDate(_currentlySelectedDate);
  }

  final GameManager _gameManager;

  List<GameEntity> selectedGames = [];

  DateTime _currentlySelectedDate = DateTime.now();

  Future<List<GameEntity>> getGamesForDate;

  void refetchGamesForCurrentDate() {
    getGamesForDate = _onGetGamesForDate(_currentlySelectedDate);
    notifyListeners();
  }

  void onDateSelected(DateTime selectedDate) {
    _currentlySelectedDate = selectedDate;
    refetchGamesForCurrentDate();
  }

  void onWatchLive(GameEntity gameToWatch) => tabNavigationService.goToTab(ViewNames.homeTabView);

  void onWatchReplay(GameEntity gameToWatch) {
    navigationService.push(
      ViewNames.watchReplayView,
      {NavigationParameterConstants.selectedGameToWatchReplay: gameToWatch},
    );
  }

  void onViewGameRecap(GameEntity gameToViewRecap) {
    navigationService.push(
      ViewNames.gameRecapView,
      {NavigationParameterConstants.selectedGameToViewRecap: gameToViewRecap},
    );
  }

  Future<List<GameEntity>> _onGetGamesForDate(DateTime selectedDate) async {
    debugInfo('Getting games for ${DateFormat("MMM dd, yyyy").format(selectedDate)}');

    try {
      return selectedGames = await _gameManager.getGames(selectedDate);
    } on Exception catch (e) {
      debugError('Failed to retrieve games for $_currentlySelectedDate', e);
      rethrow;
    }
  }
}
