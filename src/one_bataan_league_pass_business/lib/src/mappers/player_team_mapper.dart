import 'package:one_bataan_league_pass_business/src/entities/player_team_entity.dart';
import 'package:one_bataan_league_pass_business/src/mappers/mapper_base.dart';
import 'package:one_bataan_league_pass_business/src/mappers/team_mapper.dart';
import 'package:one_bataan_league_pass_web_service/data_contracts.dart';

abstract class PlayerTeamMapper implements EntityMapper<PlayerTeamEntity, PlayerTeamDataContract> {}

class PlayerTeamMapperImpl implements PlayerTeamMapper {
  PlayerTeamMapperImpl(this._teamMapper);

  final TeamMapper _teamMapper;

  @override
  PlayerTeamEntity toEntity(PlayerTeamDataContract source) {
    return PlayerTeamEntity(
      team: _teamMapper.toEntity(source.team),
      playerNum: source.playerNum,
      positions: source.positions,
    );
  }
}
