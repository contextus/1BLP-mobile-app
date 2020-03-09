import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class PlayersTabViewModel extends TabViewModelBase {
  final choices = ['All Players', 'By Team', 'By Position'];
  final players = [
    PlayerModel(
      playerName: 'John Doe',
      playerNumber: '01',
      playerTeam: TeamModel(
        teamName: '1Bataan Risers',
        teamNameAcronym: '1BR',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      ),
      playerImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSAH12GEw7txHp8_ptb9oKFrBVdd3rwydr4QivK5j3mr8TlMA6V',
      positions: ['C'],
    ),
    PlayerModel(
      playerName: 'Juan Dela Cruz',
      playerNumber: '18',
      playerTeam: TeamModel(
        teamName: 'Barangay Ginebra San Miguel',
        teamNameAcronym: 'BGSM',
        teamImageUrl: 'https://dashboard.pba.ph/assets/logo/GIN_web.png',
      ),
      playerImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSc6bQQyf3SA05K66hZfUbd8zTjDuU76IlKawa1U5hquyfoXAca',
      positions: ['G'],
    ),
    PlayerModel(
      playerName: 'Jose Makabayan',
      playerNumber: '23',
      playerTeam: TeamModel(
        teamName: 'Alska Aces',
        teamNameAcronym: 'AA',
        teamImageUrl: 'https://dashboard.pba.ph/assets/logo/ALA_web.png',
      ),
      playerImageUrl:
          'https://www.proballers.com/media/cache/resize_300/ul/player/backup/24548-1-5db4c950184820190127-kings-v-clippers-081.jpg',
      positions: ['C', 'F'],
    ),
  ];

  int selectedChoiceIndex = 0;

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
}
