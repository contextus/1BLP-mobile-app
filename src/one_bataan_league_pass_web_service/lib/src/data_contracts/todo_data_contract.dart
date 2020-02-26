import 'package:one_bataan_league_pass_web_service/src/data_contracts/data_contract_base.dart';

class TodoDataContract extends JsonDataContract {
  TodoDataContract({
    this.id,
    this.name,
    this.description,
  });

  factory TodoDataContract.fromJson(Map<String, dynamic> json) => TodoDataContract(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );

  final String description;
  final int id;
  final String name;

  @override
  Map<String, Object> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}
