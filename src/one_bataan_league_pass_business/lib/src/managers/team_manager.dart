import 'package:one_bataan_league_pass_business/src/entities/team_entity.dart';

class TeamManager {
  Future<List<TeamEntity>> getTeams() async {
    await Future.delayed(Duration(seconds: 1));

    return [
      TeamEntity(
        teamName: '1Bataan Risers',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      ),
      TeamEntity(
        teamName: 'Alska Aces',
        teamImageUrl: 'https://dashboard.pba.ph/assets/logo/ALA_web.png',
      ),
      TeamEntity(
        teamName: 'Barangay Ginebra San Miguel',
        teamImageUrl: 'https://dashboard.pba.ph/assets/logo/GIN_web.png',
      ),
    ];
  }
}
