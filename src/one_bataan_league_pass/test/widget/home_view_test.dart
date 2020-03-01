// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:one_bataan_league_pass/view_models/home_view_model.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/manager_mocks.dart';

void main() {
  group(HomeView, () {
    MockTodoManager mockTodoManager;
    HomeViewModel viewModel;
    HomeView widget;
    StreamController<List<TodoEntity>> streamCtrl;

    setUp(() {
      mockTodoManager = MockTodoManager();
      streamCtrl = StreamController();
      when(mockTodoManager.todosStream).thenAnswer((_) => streamCtrl.stream);
      viewModel = HomeViewModel(mockTodoManager);
      widget = HomeView(viewModel, '', null);
    });

    tearDown(() {
      streamCtrl.close();
    });
    testWidgets('Verify empty view is shown when no To-Dos', (tester) async {
      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.byKey(HomeViewKeys.todoListView), findsNothing);
      expect(find.byKey(HomeViewKeys.emptyTodoListView), findsOneWidget);
      expect(find.byKey(HomeViewKeys.todoListViewLoader), findsNothing);
    });

    testWidgets('Verify list view is shown when there are To-Dos', (tester) async {
      // Arrange
      streamCtrl.add(<TodoEntity>[TodoEntity(name: 'Test', description: 'Test')]);

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.byKey(HomeViewKeys.todoListView), findsOneWidget);
      expect(find.byKey(HomeViewKeys.emptyTodoListView), findsNothing);
      expect(find.byKey(HomeViewKeys.todoListViewLoader), findsNothing);
    });

    testWidgets('Verify add To-Do dialog is shown', (tester) async {
      // Act
      await tester.pumpWidget(MaterialApp(home: widget));
      await tester.pump();
      await tester.tap(find.byKey(HomeViewKeys.addTodoBtn));
      await tester.pump();

      // Assert
      expect(find.byKey(HomeViewKeys.addTodoDialog), findsOneWidget);
    });

    testWidgets('Verify To-Do list view is shown when To-Do is added using dialog', (tester) async {
      // Arrange
      final expectedTodoName = 'Test Name';
      final expectedTodoDesc = 'Test Description';

      when(mockTodoManager.createTodo(any)).thenAnswer((i) async {
        TodoEntity newTodo = i.positionalArguments.first;
        streamCtrl.add(<TodoEntity>[TodoEntity(id: 1, name: newTodo.name, description: newTodo.description)]);
      });

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));
      await tester.tap(find.byKey(HomeViewKeys.addTodoBtn));
      await tester.pump();
      await tester.enterText(find.byKey(HomeViewKeys.addTodoDialogName), expectedTodoName);
      await tester.enterText(find.byKey(HomeViewKeys.addTodoDialogDesc), expectedTodoDesc);
      await tester.tap(find.byKey(HomeViewKeys.addTodoDialogAddBtn));
      await tester.pump();

      // Assert
      expect(find.byKey(HomeViewKeys.todoListView), findsOneWidget);
      expect(find.byKey(HomeViewKeys.emptyTodoListView), findsNothing);
      expect(find.byKey(HomeViewKeys.todoListViewLoader), findsNothing);
    });
  });
}
