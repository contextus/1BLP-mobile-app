import 'package:one_bataan_league_pass_business/src/mappers/todo_mapper.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_data/database.dart';
import 'package:one_bataan_league_pass_web_service/web_services.dart';

class TodoManager {
  TodoManager(this._mapper, this._repository, this._webService);

  final TodoMapper _mapper;
  final TodoRepository _repository;
  final TodoWebService _webService;

  Stream<List<TodoEntity>> get todosStream async* {
    await for (final todoDataObjects in _repository.watchItems())
      yield todoDataObjects.map((t) => _mapper.toEntityFromDataObject(t)).toList();
  }

  Future<void> createTodo(TodoEntity newTodo) async {
    final newTodoDataContract = _mapper.toDataContract(newTodo);
    final newTodoDataObject = _mapper.toDataObject(newTodo);

    await _webService.createTodo(newTodoDataContract);
    await _repository.insertItem(newTodoDataObject);
  }

  Future<void> deleteTodo(TodoEntity todoToDelete) async {
    final todoToDeleteDO = _mapper.toDataObject(todoToDelete);

    await _webService.deleteTodo(todoToDelete.id);
    await _repository.deleteItem(todoToDeleteDO);
  }
}
