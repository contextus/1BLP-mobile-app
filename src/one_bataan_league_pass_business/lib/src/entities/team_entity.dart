import 'entity_base.dart';

class TeamEntity extends EntityBase {
  TeamEntity({
    this.id,
    this.name,
    this.owner,
    this.manager,
    this.coach,
    this.logoUrl,
    this.foundingDate,
  });

  final String id;
  final String name;
  final String owner;
  final String manager;
  final String coach;
  final String logoUrl;
  final DateTime foundingDate;
}
