import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class PlayersTabViewModel extends ViewModelBase {
  final choices = ['All Players', 'By Team', 'By Position'];
  final players = [
    PlayerModel(
      playerName: 'Player 1',
      playerNumber: '01',
      playerTeam: TeamModel(
        teamName: '1BR',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      ),
      playerImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSAH12GEw7txHp8_ptb9oKFrBVdd3rwydr4QivK5j3mr8TlMA6V',
      positions: ['C'],
    ),
    PlayerModel(
      playerName: 'Player 2',
      playerNumber: '23',
      playerTeam: TeamModel(
        teamName: '1BR',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      ),
      playerImageUrl:
          'https://www.proballers.com/media/cache/resize_300/ul/player/backup/24548-1-5db4c950184820190127-kings-v-clippers-081.jpg',
      positions: ['C', 'F'],
    ),
    PlayerModel(
      playerName: 'Player 3',
      playerNumber: '18',
      playerTeam: TeamModel(
        teamName: '1BR',
        teamImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      ),
      playerImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSc6bQQyf3SA05K66hZfUbd8zTjDuU76IlKawa1U5hquyfoXAca',
      positions: ['G'],
    ),
  ];

  int selectedChoiceIndex = 0;

  void onSelectedChoiceIndexChanged(int index) {
    selectedChoiceIndex = index;
    notifyListeners('selectedChoiceIndex');
    debugInfo('Filter players: ${choices[selectedChoiceIndex]}');
  }
}
