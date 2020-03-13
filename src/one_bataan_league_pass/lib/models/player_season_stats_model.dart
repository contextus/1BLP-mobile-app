class PlayerSeasonModel {
  PlayerSeasonModel(this.seasonName, this.stats);

  final String seasonName;
  final PlayerSeasonStatsModel stats;
}

class PlayerSeasonStatsModel {
  PlayerSeasonStatsModel({
    this.year,
    this.gp,
    this.min,
    this.pts,
    this.fgm,
    this.fga,
    this.fgPercentage,
  });

  final int year;
  final double gp;
  final double min;
  final double pts;
  final double fgm;
  final double fga;
  final double fgPercentage;
}
