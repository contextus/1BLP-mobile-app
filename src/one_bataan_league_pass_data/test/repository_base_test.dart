import 'package:one_bataan_league_pass_data/database.dart';
import 'package:one_bataan_league_pass_data/src/database/app_database.dart';
import 'package:one_bataan_league_pass_data/src/database/query_executor_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor/src/runtime/executor/executor.dart';
import 'package:moor_ffi/moor_ffi.dart';

// Read more about testing using a mock database here https://moor.simonbinder.eu/docs/testing/

class MockQueryExecutorProvider implements QueryExecutorProvider {
  @override
  QueryExecutor get queryExecutor => VmDatabase.memory();
}

void main() {
  group(TodoRepository, () {
    AppDatabase db;
    TodoRepository unit;

    setUp(() {
      db = AppDatabase(MockQueryExecutorProvider());
      unit = TodoRepository(db);
    });

    tearDown(() {
      db.close();
    });

    test('Verify To-Do inserted', () async {
      // Arrange
      final todo = TodoDataObject(id: 1, name: 'Test', description: 'Desc');

      // Act
      await unit.insertItem(todo);

      final expectation = expectLater(
        unit.watchItems().map((t) => t),
        emitsInOrder([
          [todo]
        ]),
      );

      // Assert
      await expectation;
    });
  });
}
