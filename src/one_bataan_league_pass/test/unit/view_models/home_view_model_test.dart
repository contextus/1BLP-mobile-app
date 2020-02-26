import 'dart:async';

import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/manager_mocks.dart';

void main() {
  group('[HomeViewModel]', () {
    MockTodoManager mockTodoManager;
    HomeViewModel unit;
    StreamController<List<TodoEntity>> streamCtrl;

    setUp(() {
      mockTodoManager = MockTodoManager();
      streamCtrl = StreamController();
      when(mockTodoManager.todosStream).thenAnswer((_) => streamCtrl.stream);
      unit = HomeViewModel(mockTodoManager);
    });

    tearDown(() {
      streamCtrl.close();
    });

    test('Verify To-Do is created', () async {
      // Arrange
      final expectedTodo = TodoEntity(id: 1, name: 'Name', description: 'Description');

      when(mockTodoManager.createTodo(any)).thenAnswer((i) async {
        TodoEntity newTodo = i.positionalArguments.first;
        streamCtrl.add(<TodoEntity>[TodoEntity(id: 1, name: newTodo.name, description: newTodo.description)]);
      });

      // Act
      await unit.createTodo('Name', 'Description');

      // Assert
      verify(mockTodoManager.createTodo(any)).called(1);
      expect(unit.todos.first, expectedTodo);
    });
  });
}
