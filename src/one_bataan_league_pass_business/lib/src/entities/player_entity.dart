import 'team_entity.dart';
import 'entity_base.dart';

class PlayerEntity extends EntityBase {
  PlayerEntity({
    this.playerName,
    this.playerNumber,
    this.playerTeam,
    this.playerAvatarImageUrl,
    this.playerImageUrl,
    this.positions = const [],
    this.ppg = 0.0,
    this.rpg = 0.0,
    this.apg = 0.0,
  });

  final String playerName;
  final String playerNumber;
  final TeamEntity playerTeam;
  final String playerAvatarImageUrl;
  final String playerImageUrl;
  final List<String> positions;
  final double ppg;
  final double rpg;
  final double apg;

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
