import 'package:one_bataan_league_pass_business/src/mappers/mapper_base.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_data/data_objects.dart';
import 'package:one_bataan_league_pass_web_service/data_contracts.dart';

class TodoMapper implements EntityDataContractObjectMapper<TodoEntity, TodoDataContract, TodoDataObject> {
  @override
  TodoDataContract toDataContract(TodoEntity source) {
    return TodoDataContract(
      id: source.id,
      name: source.name,
      description: source.description,
    );
  }

  @override
  TodoDataObject toDataObject(TodoEntity source) {
    return TodoDataObject(
      id: source.id,
      name: source.name,
      description: source.description,
    );
  }

  @override
  TodoEntity toEntityFromDataContract(TodoDataContract source) {
    return TodoEntity(
      id: source.id,
      name: source.name,
      description: source.description,
    );
  }

  @override
  TodoEntity toEntityFromDataObject(TodoDataObject source) {
    return TodoEntity(
      id: source.id,
      name: source.name,
      description: source.description,
    );
  }
}
