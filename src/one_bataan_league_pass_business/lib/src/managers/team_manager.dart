import 'package:one_bataan_league_pass_business/src/entities/team_entity.dart';
import 'package:one_bataan_league_pass_business/src/mappers/team_mapper.dart';
import 'package:one_bataan_league_pass_web_service/web_services.dart';

abstract class TeamManager {
  Future<List<TeamEntity>> getTeams();
}

class TeamManagerImpl implements TeamManager {
  TeamManagerImpl(this._teamWebService, this._teamMapper);

  final TeamWebService _teamWebService;
  final TeamMapper _teamMapper;

  @override
  Future<List<TeamEntity>> getTeams() async {
    final teamDataContracts = await _teamWebService.getTeams();

    return teamDataContracts.map(_teamMapper.toEntity).toList();
  }
}
