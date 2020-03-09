import 'package:one_bataan_league_pass_business/src/entities/game_entity.dart';
import 'package:one_bataan_league_pass_business/src/entities/team_entity.dart';
import 'package:one_bataan_league_pass_common/utils.dart';

class GameManager {
  Future<GameEntity> getLiveGame() async {
    await Future.delayed(Duration(seconds: 1));

    return GameEntity(
      gameSeries: 'Playoffs Quarter Finals',
      gameDate: DateTime.now(),
      gameLocation: 'Mariveles, Bataan',
      gameVideoUrl: 'https://sample.com',
      isLive: true,
      team1: TeamEntity(
        teamName: '1Bataan Risers',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      ),
      team1Score: 35,
      team2: TeamEntity(
        teamName: 'A Team',
        teamImageUrl:
            'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
      ),
      team2Score: 22,
    );
  }

  Future<List<GameEntity>> getGames(DateTime selectedDate) async {
    final mockGames = [
      GameEntity(
        gameDate: DateTime.now().subtract(Duration(days: 1)),
        gameLocation: 'Mariveles, Bataan',
        gameSeries: 'Playoffs Quarter Finals',
        team1: TeamEntity(
          teamName: '1Bataan Risers',
          teamImageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
        ),
        team2: TeamEntity(
          teamName: 'A Team',
          teamImageUrl:
              'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
        ),
        team1Score: 80,
        team2Score: 54,
      ),
      GameEntity(
        gameDate: DateTime.now(),
        gameLocation: 'Mariveles, Bataan',
        gameSeries: 'Playoffs Quarter Finals',
        team1: TeamEntity(
          teamName: '1Bataan Risers',
          teamImageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
        ),
        team2: TeamEntity(
          teamName: 'B Team',
          teamImageUrl:
              'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
        ),
        team1Score: 23,
        team2Score: 12,
        isLive: true,
      ),
      GameEntity(
        gameDate: DateTime.now().add(Duration(days: 1)),
        gameLocation: 'Mariveles, Bataan',
        gameSeries: 'Playoffs Quarter Finals',
        team1: TeamEntity(
          teamName: '1Bataan Risers',
          teamImageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
        ),
        team2: TeamEntity(
          teamName: 'C Team',
          teamImageUrl:
              'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
        ),
      ),
      GameEntity(
        gameDate: DateTime.now().add(Duration(days: 2)),
        gameLocation: 'Mariveles, Bataan',
        gameSeries: 'Playoffs Quarter Finals',
        team1: TeamEntity(
          teamName: '1Bataan Risers',
          teamImageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
        ),
        team2: TeamEntity(
          teamName: 'D Team',
          teamImageUrl:
              'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
        ),
      ),
      GameEntity(
        gameDate: DateTime.now().add(Duration(days: 3)),
        gameLocation: 'Mariveles, Bataan',
        gameSeries: 'Playoffs Quarter Finals',
        team1: TeamEntity(
          teamName: '1Bataan Risers',
          teamImageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
        ),
        team2: TeamEntity(
          teamName: 'E Team',
          teamImageUrl:
              'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
        ),
      )
    ];

    await Future.delayed(Duration(seconds: 1));

    return mockGames.where((g) => g.gameDate.isOnTheSameDay(selectedDate)).toList();
  }
}
