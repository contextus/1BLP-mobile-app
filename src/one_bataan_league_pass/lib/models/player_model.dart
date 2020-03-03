import 'package:one_bataan_league_pass/models/models.dart';

class PlayerModel {
  PlayerModel({
    this.playerName,
    this.playerNumber,
    this.playerTeam,
    this.playerImageUrl,
    this.positions = const [],
  });

  final String playerName;
  final String playerNumber;
  final TeamModel playerTeam;
  final String playerImageUrl;
  final List<String> positions;

  String get formattedPositions {
    String formattedPositions = '';

    for (var i = 0; i < positions.length; i++) {
      formattedPositions = formattedPositions + positions[i];

      if (i < positions.length - 1) {
        formattedPositions = formattedPositions + '-';
      }
    }

    return formattedPositions;
  }
}
