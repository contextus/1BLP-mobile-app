import 'package:one_bataan_league_pass_web_service/src/data_contracts/data_contract_base.dart';
import 'package:one_bataan_league_pass_web_service/src/data_contracts/team_data_contract.dart';

class PlayerTeamDataContract extends DataContractBase {
  PlayerTeamDataContract({this.team, this.playerNum, this.positions});

  final TeamDataContract team;
  final String playerNum;
  final List<String> positions;

  factory PlayerTeamDataContract.fromJson(Map<String, Object> json) {
    return PlayerTeamDataContract(
      team: TeamDataContract.fromJson(json['team']),
      playerNum: json['player_num'],
      positions: json['positions'],
    );
  }
}
