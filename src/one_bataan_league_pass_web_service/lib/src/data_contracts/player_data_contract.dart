import 'package:one_bataan_league_pass_web_service/src/data_contracts/data_contract_base.dart';
import 'package:one_bataan_league_pass_web_service/src/data_contracts/player_team_data_contract.dart';

class PlayerDataContract extends DataContractBase {
  PlayerDataContract({
    this.id,
    this.firstName,
    this.lastName,
    this.birthdate,
    this.nationality,
    this.province,
    this.municipalityTown,
    this.imageUrl,
    this.profile,
    this.team,
  });

  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthdate;
  final String nationality;
  final String province;
  final String municipalityTown;
  final String imageUrl;
  final Map<String, Object> profile;
  final PlayerTeamDataContract team;

  factory PlayerDataContract.fromJson(Map<String, Object> json) {
    return PlayerDataContract(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      birthdate: json['birthdate'],
      nationality: json['nationality'],
      province: json['province'],
      municipalityTown: json['municipality_town'],
      imageUrl: json['image_url'],
      profile: json['profile'],
      team: PlayerTeamDataContract.fromJson(json['team']),
    );
  }
}
