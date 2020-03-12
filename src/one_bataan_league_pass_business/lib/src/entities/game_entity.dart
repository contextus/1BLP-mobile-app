import 'package:one_bataan_league_pass_business/src/entities/entity_base.dart';
import 'package:one_bataan_league_pass_business/src/entities/team_entity.dart';
import 'package:one_bataan_league_pass_common/utils.dart';

class GameEntity extends EntityBase {
  GameEntity({
    this.gameSeries,
    this.gameDate,
    this.gameLocation,
    this.gameVideoUrl,
    this.team1,
    this.team2,
    this.team1Score = 0,
    this.team2Score = 0,
    this.isLive = false,
  });

  final String gameSeries;
  final DateTime gameDate;
  final String gameLocation;
  final String gameVideoUrl;
  final TeamEntity team1;
  final TeamEntity team2;
  final int team1Score;
  final int team2Score;
  final bool isLive;

  bool get isGameToday => gameDate.isOnTheSameDay(DateTime.now());

  bool get isGameUpcoming => !isGameFinished && !isGameToday;

  bool get isGameFinished {
    final dateTimeNow = DateTime.now();
    final dateNow = DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day);
    final gameDate = DateTime(this.gameDate.year, this.gameDate.month, this.gameDate.day);

    final diffDays = dateNow.difference(gameDate).inDays;

    return diffDays > 0;
  }
}
