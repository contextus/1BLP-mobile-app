import 'dart:async';

import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class HomeViewModel extends ViewModelBase {
  HomeViewModel(this._todoManager) {
    _todoStreamSubsc = _todoManager.todosStream.listen((t) => todos = t);
  }

  final TodoManager _todoManager;
  StreamSubscription _todoStreamSubsc;

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  set isBusy(bool value) {
    if (_isBusy != value) {
      _isBusy = value;
      notifyListeners('isBusy');
    }
  }

  List<TodoEntity> _todos = [];
  List<TodoEntity> get todos => _todos;
  set todos(List<TodoEntity> value) {
    if (_todos != value) {
      _todos = value;
      notifyListeners('todos');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _todoStreamSubsc.cancel();
  }

  Future<void> createTodo(String name, String description) async {
    debugInfo('Creating todo...');

    try {
      isBusy = true;
      await _todoManager.createTodo(TodoEntity(name: name, description: description));
    } on Exception catch (e) {
      debugError('Failed to create todo', e);
    } finally {
      isBusy = false;
    }
  }

  Future<void> deleteTodo(TodoEntity todoToDelete) async {
    debugInfo('Deleting todo with id ${todoToDelete.id}...');

    try {
      todos.remove(todoToDelete);
      notifyListeners();
      await _todoManager.deleteTodo(todoToDelete);
    } on Exception catch (e) {
      debugError('Failed to delete todo', e);
    }
  }
}
