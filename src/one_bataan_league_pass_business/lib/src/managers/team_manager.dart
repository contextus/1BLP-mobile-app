import 'package:one_bataan_league_pass_business/src/entities/team_entity.dart';
import 'package:one_bataan_league_pass_business/src/mappers/team_mapper.dart';
import 'package:one_bataan_league_pass_web_service/web_services.dart';

class TeamManager {
  TeamManager(this._teamWebService, this._teamMapper);

  final TeamWebService _teamWebService;
  final TeamMapper _teamMapper;

  Future<List<TeamEntity>> getTeams() async {
    final teamDataContracts = await _teamWebService.getTeams();

    return teamDataContracts.map(_teamMapper.toEntity).toList();
  }
}
