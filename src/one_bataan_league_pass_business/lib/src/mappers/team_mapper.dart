import 'package:one_bataan_league_pass_business/src/entities/team_entity.dart';
import 'package:one_bataan_league_pass_business/src/mappers/mapper_base.dart';
import 'package:one_bataan_league_pass_web_service/data_contracts.dart';

abstract class TeamMapper implements EntityMapper<TeamEntity, TeamDataContract> {}

class TeamMapperImpl implements TeamMapper {
  @override
  TeamEntity toEntity(TeamDataContract source) {
    return TeamEntity(
      id: source.id,
      name: source.name,
      coach: source.coach,
      manager: source.manager,
      owner: source.owner,
      logoUrl: source.logoUrl,
      foundingDate: source.foundingDate,
    );
  }
}
