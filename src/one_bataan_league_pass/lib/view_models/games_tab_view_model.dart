import 'package:one_bataan_league_pass/models/game_model.dart';
import 'package:one_bataan_league_pass/models/team_model.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';

class GamesTabViewModel extends ViewModelBase {
  final games = [
    GameModel(
      gameDate: DateTime.now().subtract(Duration(days: 1)),
      team1: TeamModel('1Bataan Risers'),
      team2: TeamModel('A Team'),
    ),
    GameModel(
      gameDate: DateTime.now(),
      team1: TeamModel('1Bataan Risers'),
      team2: TeamModel('B Team'),
      team1Score: 23,
      team2Score: 12,
    ),
    GameModel(
      gameDate: DateTime.now().add(Duration(days: 1)),
      team1: TeamModel('1Bataan Risers'),
      team2: TeamModel('C Team'),
    ),
    GameModel(
      gameDate: DateTime.now().add(Duration(days: 2)),
      team1: TeamModel('1Bataan Risers'),
      team2: TeamModel('D Team'),
    ),
    GameModel(
      gameDate: DateTime.now().add(Duration(days: 3)),
      team1: TeamModel('1Bataan Risers'),
      team2: TeamModel('E Team'),
    ),
  ];

  List<GameModel> _selectedGames = [];
  List<GameModel> get selectedGames => _selectedGames;
  set selectedGames(List<GameModel> value) {
    if (_selectedGames != value) {
      _selectedGames = value;
      notifyListeners();
    }
  }

  void onDateSelected(DateTime selectedDate) {
    print('Selected $selectedDate');

    selectedGames = games.where((g) {
      return g.gameDate.month == selectedDate.month &&
          g.gameDate.day == selectedDate.day &&
          g.gameDate.year == selectedDate.year;
    }).toList();
  }

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    onDateSelected(DateTime.now());
  }
}
