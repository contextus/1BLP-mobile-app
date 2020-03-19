import 'package:one_bataan_league_pass/view_models/view_models.dart';

class StandingsTabViewModel extends TabViewModelBase {
  final teams = [
    TeamStandingsModel(
      name: '1Bataan Risers',
      teamNameAcronym: '1BR',
      logoUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
      totalWins: 41,
      totalLose: 18,
      gamesBehind: 15,
    ),
    TeamStandingsModel(
      name: 'Alska Aces',
      teamNameAcronym: 'AA',
      logoUrl: 'https://dashboard.pba.ph/assets/logo/ALA_web.png',
      totalWins: 21,
      totalLose: 35,
      gamesBehind: 23,
    ),
    TeamStandingsModel(
      name: 'Barangay Ginebra San Miguel',
      teamNameAcronym: 'BGSM',
      logoUrl: 'https://dashboard.pba.ph/assets/logo/GIN_web.png',
      totalWins: 13,
      totalLose: 34,
      gamesBehind: 24,
    ),
  ];
}

class TeamStandingsModel {
  TeamStandingsModel({
    this.name,
    this.teamNameAcronym,
    this.logoUrl,
    this.totalWins,
    this.totalLose,
    this.gamesBehind,
  });

  final String name;
  final String teamNameAcronym;
  final String logoUrl;
  final int totalWins;
  final int totalLose;
  final int gamesBehind;

  int get winPercentage => ((totalWins / (totalWins + totalLose)) * 100).floor();
}
