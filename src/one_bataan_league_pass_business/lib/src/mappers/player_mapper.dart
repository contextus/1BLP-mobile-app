import 'package:one_bataan_league_pass_business/src/entities/player_entity.dart';
import 'package:one_bataan_league_pass_business/src/mappers/mapper_base.dart';
import 'package:one_bataan_league_pass_business/src/mappers/player_team_mapper.dart';
import 'package:one_bataan_league_pass_web_service/data_contracts.dart';

class PlayerMapper implements EntityMapper<PlayerEntity, PlayerDataContract> {
  PlayerMapper(this._playerTeamMapper);

  final PlayerTeamMapper _playerTeamMapper;

  @override
  PlayerEntity toEntity(PlayerDataContract source) {
    return PlayerEntity(
      id: source.id,
      firstName: source.firstName,
      lastName: source.lastName,
      birthdate: source.birthdate,
      province: source.province,
      municipalityTown: source.municipalityTown,
      nationality: source.nationality,
      profile: source.profile,
      imageUrl: source.imageUrl,
      playerTeam: _playerTeamMapper.toEntity(source.team),
    );
  }
}
