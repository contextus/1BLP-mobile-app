import 'package:one_bataan_league_pass_business/src/entities/player_entity.dart';
import 'package:one_bataan_league_pass_business/src/entities/team_entity.dart';

class PlayerManager {
  Future<List<PlayerEntity>> getPlayers() async {
    await Future.delayed(Duration(seconds: 1));

    return [
      PlayerEntity(
        playerName: 'John Doe',
        playerNumber: '01',
        playerTeam: TeamEntity(
          teamName: '1Bataan Risers',
          teamNameAcronym: '1BR',
          teamImageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
        ),
        playerAvatarImageUrl:
            'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
        playerImageUrl:
            'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
        positions: ['C'],
        ppg: 12.2,
        apg: 6.4,
        rpg: 5.3,
      ),
      PlayerEntity(
        playerName: 'Mark Smith',
        playerNumber: '18',
        playerTeam: TeamEntity(
          teamName: 'A Team',
          teamNameAcronym: 'AT',
          teamImageUrl:
              'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
        ),
        playerAvatarImageUrl:
            'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
        playerImageUrl:
            'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
        positions: ['G'],
        ppg: 12.2,
        apg: 6.4,
        rpg: 5.3,
      ),
      PlayerEntity(
        playerName: 'Jake Cruz',
        playerNumber: '23',
        playerTeam: TeamEntity(
          teamName: 'B Team',
          teamNameAcronym: 'BT',
          teamImageUrl:
              'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
        ),
        playerAvatarImageUrl:
            'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
        playerImageUrl:
            'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
        positions: ['C', 'F'],
        ppg: 12.2,
        apg: 6.4,
        rpg: 5.3,
      ),
    ];
  }
}
