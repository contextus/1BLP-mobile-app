import 'package:one_bataan_league_pass_business/src/entities/team_entity.dart';

class TeamManager {
  Future<List<TeamEntity>> getTeams() async {
    await Future.delayed(Duration(seconds: 1));

    return [
      TeamEntity(
        teamName: '1Bataan Risers',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
        totalWins: 24,
        totalLose: 8,
        place: '1st',
      ),
      TeamEntity(
        teamName: 'A Team',
        teamNameAcronym: 'AT',
        teamImageUrl:
            'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
        totalWins: 16,
        totalLose: 12,
        place: '3rd',
      ),
      TeamEntity(
        teamName: 'B Team',
        teamNameAcronym: 'BT',
        teamImageUrl:
            'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
        totalWins: 8,
        totalLose: 20,
        place: '2nd',
      )
    ];
  }
}
