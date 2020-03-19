import 'package:one_bataan_league_pass_business/entities.dart';

class PlayerGameStatsModel {
  PlayerGameStatsModel({this.player, this.category, this.score});

  final PlayerEntity player;
  final GameLeaderCategory category;
  final int score;
}

enum GameLeaderCategory {
  points,
  rebounds,
  assists,
  steals,
  blocks,
}
