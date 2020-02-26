import 'package:one_bataan_league_pass_business/src/entities/todo_entity.dart';
import 'package:one_bataan_league_pass_business/src/mappers/todo_mapper.dart';
import 'package:one_bataan_league_pass_data/data_objects.dart';
import 'package:one_bataan_league_pass_web_service/data_contracts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(TodoMapper, () {
    final id = 1;
    final name = 'Test Name';
    final desc = 'Test Description';
    final entity = TodoEntity(id: id, name: name, description: desc);
    final dataObject = TodoDataObject(id: id, name: name, description: desc);
    final dataContract = TodoDataContract(id: id, name: name, description: desc);
    TodoMapper unit;

    setUp(() {
      unit = TodoMapper();
    });

    test('Verify TodoEntity maps to TodoDataObject', () {
      // Act
      final dataObject = unit.toDataObject(entity);

      // Assert
      expect(dataObject.id, id);
      expect(dataObject.name, name);
      expect(dataObject.description, desc);
    });

    test('Verify TodoDataObject maps to TodoEntity', () {
      // Act
      final entity = unit.toEntityFromDataObject(dataObject);

      // Assert
      expect(entity.id, id);
      expect(entity.name, name);
      expect(entity.description, desc);
    });

    test('Verify TodoDataContract maps to TodoEntity', () {
      // Act
      final entity = unit.toEntityFromDataContract(dataContract);

      // Assert
      expect(entity.id, id);
      expect(entity.name, name);
      expect(entity.description, desc);
    });

    test('Verify TodoEntity maps to TodoDataContract', () {
      // Act
      final dataContract = unit.toDataContract(entity);

      // Assert
      expect(dataContract.id, id);
      expect(dataContract.name, name);
      expect(dataContract.description, desc);
    });
  });
}
