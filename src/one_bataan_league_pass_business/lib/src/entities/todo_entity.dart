import 'package:one_bataan_league_pass_business/src/entities/entity_base.dart';

class TodoEntity extends EquatableEntityBase {
  TodoEntity({this.id, this.name, this.description});

  final String description;
  final int id;
  final String name;

  @override
  List<Object> get props => [id];
}
