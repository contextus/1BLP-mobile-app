import 'team_entity.dart';
import 'entity_base.dart';

class PlayerEntity extends EntityBase {
  PlayerEntity({
    this.playerName,
    this.playerNumber,
    this.playerTeam,
    this.playerImageUrl,
    this.positions = const [],
  });

  final String playerName;
  final String playerNumber;
  final TeamEntity playerTeam;
  final String playerImageUrl;
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
