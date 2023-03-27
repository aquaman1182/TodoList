import 'package:gonput_2/domain/tododata/todo.dart';
import 'package:gonput_2/models/db/database_manager.dart';

class TodoListRepository {
  final DatabaseManager _databaseManager;

  TodoListRepository({required DatabaseManager databaseManager})
      : _databaseManager = databaseManager;

Stream<List<Todo>> fetchTodoListStream() {
  return _databaseManager.fetchTodoListStream();
}

  Future<void> delete(Todo todoList) async {
    await _databaseManager.delete(todoList);
  }

  Future<void> update(List<Todo> todoList) async {
    await _databaseManager.updateTodos(todoList);
  }

  Future<void> logout() async {
    await _databaseManager.logout();
  }
}
