import 'package:one_bataan_league_pass_business/src/entities/player_team_entity.dart';
import 'package:one_bataan_league_pass_business/src/entities/entity_base.dart';

class PlayerEntity extends EntityBase {
  PlayerEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.birthdate,
    this.nationality,
    this.province,
    this.municipalityTown,
    this.profile,
    this.playerTeam,
    this.imageUrl,
  });

  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthdate;
  final String nationality;
  final String province;
  final String municipalityTown;
  final Map<String, Object> profile;
  final String imageUrl;
  final PlayerTeamEntity playerTeam;
}
