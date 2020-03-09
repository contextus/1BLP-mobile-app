import 'entity_base.dart';

class TeamEntity extends EntityBase {
  TeamEntity({
    this.teamName,
    this.teamNameAcronym,
    this.teamImageUrl,
    this.totalWins,
    this.totalLose,
    this.gamesBehind,
  });

  final String teamName;
  final String teamNameAcronym;
  final String teamImageUrl;
  final int totalWins;
  final int totalLose;
  final int gamesBehind;

  int get winPercentage => ((totalWins / (totalWins + totalLose)) * 100).round();
}
