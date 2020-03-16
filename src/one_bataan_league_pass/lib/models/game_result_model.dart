import 'package:one_bataan_league_pass_business/entities.dart';

class GameResultModel {
  GameResultModel({
    this.team,
    this.q1,
    this.q2,
    this.q3,
    this.q4,
    this.fieldGoals,
    this.totalFieldGoals,
    this.threePointers,
    this.totalThreePointers,
    this.freeThrows,
    this.totalFreeThrows,
  });

  final TeamEntity team;
  final int q1;
  final int q2;
  final int q3;
  final int q4;
  final int fieldGoals;
  final int totalFieldGoals;
  final int threePointers;
  final int totalThreePointers;
  final int freeThrows;
  final int totalFreeThrows;

  int get total => q1 + q2 + q3 + q4;

  double get fieldGoalPercentage => ((fieldGoals / totalFieldGoals) * 100);

  double get threePointerPercentage => ((threePointers / totalThreePointers) * 100);

  double get freeThrowPercentage => ((freeThrows / totalFreeThrows) * 100);
}
