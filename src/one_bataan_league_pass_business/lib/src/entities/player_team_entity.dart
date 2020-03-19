import 'package:one_bataan_league_pass_business/src/entities/entity_base.dart';
import 'package:one_bataan_league_pass_business/src/entities/team_entity.dart';

class PlayerTeamEntity extends EntityBase {
  PlayerTeamEntity({this.team, this.playerNum, this.positions});

  final TeamEntity team;
  final String playerNum;
  final List<String> positions;

  // TODO: Move to UI
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
