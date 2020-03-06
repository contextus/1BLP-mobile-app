import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';

class TeamsTabViewModel extends TabViewModelBase {
  final teams = [
    TeamModel(
      teamName: '1Bataan Risers',
      teamImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
    ),
    TeamModel(
      teamName: 'Alska Aces',
      teamImageUrl: 'https://dashboard.pba.ph/assets/logo/ALA_web.png',
    ),
    TeamModel(
      teamName: 'Barangay Ginebra San Miguel',
      teamImageUrl: 'https://dashboard.pba.ph/assets/logo/GIN_web.png',
    ),
  ];
}
