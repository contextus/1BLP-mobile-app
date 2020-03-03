import 'package:one_bataan_league_pass/models/team_model.dart';

class GameModel {
  GameModel({
    this.gameDate,
    this.team1,
    this.team2,
    this.team1Score = 0,
    this.team2Score = 0,
    this.isLive = false,
  });

  final DateTime gameDate;
  final TeamModel team1;
  final TeamModel team2;
  final int team1Score;
  final int team2Score;
  final bool isLive;

  bool get isGameToday {
    final dateTimeNow = DateTime.now();
    final dateNow = DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day);
    final gameDate = DateTime(this.gameDate.year, this.gameDate.month, this.gameDate.day);

    return dateNow.difference(gameDate).inDays == 0;
  }

  bool get isGameUpcoming => !isGameFinished && !isGameToday;

  bool get isGameFinished {
    final dateTimeNow = DateTime.now();
    final dateNow = DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day);
    final gameDate = DateTime(this.gameDate.year, this.gameDate.month, this.gameDate.day);

    final diffDays = dateNow.difference(gameDate).inDays;

    return diffDays > 0;
  }
}
