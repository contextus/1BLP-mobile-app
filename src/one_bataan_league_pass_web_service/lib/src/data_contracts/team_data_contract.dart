import 'package:one_bataan_league_pass_web_service/src/data_contracts/data_contract_base.dart';

class TeamDataContract extends DataContractBase {
  TeamDataContract({
    this.id,
    this.name,
    this.owner,
    this.manager,
    this.coach,
    this.logoUrl,
  });

  final String id;
  final String name;
  final String owner;
  final String manager;
  final String coach;
  final String logoUrl;

  factory TeamDataContract.fromJson(Map<String, Object> json) {
    return TeamDataContract(
      id: json['id'],
      name: json['name'],
      owner: json['owner'],
      manager: json['manager'],
      coach: json['coach'],
      logoUrl: json['logo_url'],
    );
  }
}
