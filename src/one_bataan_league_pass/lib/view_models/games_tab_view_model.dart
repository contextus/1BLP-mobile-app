import 'package:one_bataan_league_pass/models/game_model.dart';
import 'package:one_bataan_league_pass/models/team_model.dart';
import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class GamesTabViewModel extends TabViewModelBase {
  GamesTabViewModel(NavigationService navigationService) : super(navigationService);

  final games = [
    GameModel(
      gameDate: DateTime.now().subtract(Duration(days: 1)),
      gameLocation: 'Mariveles, Bataan',
      gameSeries: 'Playoffs Quarter Finals',
      team1: TeamModel(
        teamName: '1Bataan Risers',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      ),
      team2: TeamModel(
        teamName: 'A Team',
        teamImageUrl:
            'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
      ),
      team1Score: 80,
      team2Score: 54,
    ),
    GameModel(
      gameDate: DateTime.now(),
      gameLocation: 'Mariveles, Bataan',
      gameSeries: 'Playoffs Quarter Finals',
      team1: TeamModel(
        teamName: '1Bataan Risers',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      ),
      team2: TeamModel(
        teamName: 'B Team',
        teamImageUrl:
            'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
      ),
      team1Score: 23,
      team2Score: 12,
      isLive: true,
    ),
    GameModel(
      gameDate: DateTime.now().add(Duration(days: 1)),
      gameLocation: 'Mariveles, Bataan',
      gameSeries: 'Playoffs Quarter Finals',
      team1: TeamModel(
        teamName: '1Bataan Risers',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      ),
      team2: TeamModel(
        teamName: 'C Team',
        teamImageUrl:
            'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
      ),
    ),
    GameModel(
      gameDate: DateTime.now().add(Duration(days: 2)),
      gameLocation: 'Mariveles, Bataan',
      gameSeries: 'Playoffs Quarter Finals',
      team1: TeamModel(
        teamName: '1Bataan Risers',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      ),
      team2: TeamModel(
        teamName: 'D Team',
        teamImageUrl:
            'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
      ),
    ),
    GameModel(
      gameDate: DateTime.now().add(Duration(days: 3)),
      gameLocation: 'Mariveles, Bataan',
      gameSeries: 'Playoffs Quarter Finals',
      team1: TeamModel(
        teamName: '1Bataan Risers',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      ),
      team2: TeamModel(
        teamName: 'E Team',
        teamImageUrl:
            'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
      ),
    ),
  ];

  List<GameModel> selectedGames = [];

  DateTime currentlySelectedDate = DateTime.now();

  void onDateSelected(DateTime selectedDate) {
    selectedGames = games.where((g) {
      return g.gameDate.month == selectedDate.month &&
          g.gameDate.day == selectedDate.day &&
          g.gameDate.year == selectedDate.year;
    }).toList();
    currentlySelectedDate = selectedDate;

    notifyListeners();
  }

  void onWatchLive() => navigationService.goToTab(ViewNames.homeTabView);

  @override
  void onTabSelected([Map<String, Object> parameters]) {
    onDateSelected(currentlySelectedDate);
  }
}
