import 'package:one_bataan_league_pass/models/team_model.dart';

class GameModel {
  GameModel({
    this.gameDate,
    this.team1,
    this.team2,
    this.team1Score = 0,
    this.team2Score = 0,
  });

  final DateTime gameDate;
  final TeamModel team1;
  final TeamModel team2;
  final int team1Score;
  final int team2Score;

  bool get isGameToday {
    final dateTimeNow = DateTime.now();
    final gameDate = DateTime(this.gameDate.year, this.gameDate.month, this.gameDate.day);

    return gameDate.month == dateTimeNow.month &&
    gameDate.day == dateTimeNow.day &&
    gameDate.year == dateTimeNow.year;
  }
}
