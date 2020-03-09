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
        playerImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSAH12GEw7txHp8_ptb9oKFrBVdd3rwydr4QivK5j3mr8TlMA6V',
        positions: ['C'],
      ),
      PlayerEntity(
        playerName: 'Juan Dela Cruz',
        playerNumber: '18',
        playerTeam: TeamEntity(
          teamName: 'Barangay Ginebra San Miguel',
          teamNameAcronym: 'BGSM',
          teamImageUrl: 'https://dashboard.pba.ph/assets/logo/GIN_web.png',
        ),
        playerImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSc6bQQyf3SA05K66hZfUbd8zTjDuU76IlKawa1U5hquyfoXAca',
        positions: ['G'],
      ),
      PlayerEntity(
        playerName: 'Jose Makabayan',
        playerNumber: '23',
        playerTeam: TeamEntity(
          teamName: 'Alska Aces',
          teamNameAcronym: 'AA',
          teamImageUrl: 'https://dashboard.pba.ph/assets/logo/ALA_web.png',
        ),
        playerImageUrl:
            'https://www.proballers.com/media/cache/resize_300/ul/player/backup/24548-1-5db4c950184820190127-kings-v-clippers-081.jpg',
        positions: ['C', 'F'],
      ),
    ];
  }
}
