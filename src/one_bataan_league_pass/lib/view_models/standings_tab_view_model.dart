import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';

class StandingsTabViewModel extends ViewModelBase {
  final teams = [
    TeamModel(
      teamName: '1Bataan Risers',
      teamNameAcronym: '1BR',
      teamImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      totalWins: 41,
      totalLose: 18,
      gamesBehind: 15,
    ),
    TeamModel(
      teamName: 'Alska Aces',
      teamNameAcronym: 'AA',
      teamImageUrl: 'https://dashboard.pba.ph/assets/logo/ALA_web.png',
      totalWins: 21,
      totalLose: 35,
      gamesBehind: 23,
    ),
    TeamModel(
      teamName: 'Barangay Ginebra San Miguel',
      teamNameAcronym: 'BGSM',
      teamImageUrl: 'https://dashboard.pba.ph/assets/logo/GIN_web.png',
      totalWins: 13,
      totalLose: 34,
      gamesBehind: 24,
    ),
  ];
}
