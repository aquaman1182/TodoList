import 'package:gonput_2/domain/tododata/todo.dart';
import 'package:gonput_2/models/db/database_manager.dart';

class TodoListRepository {
  final DatabaseManager databaseManager;

  TodoListRepository({required DatabaseManager databaseManager})
      : databaseManager = databaseManager;

  Stream<List<Todo>> fetchTodoListStream() {
    return databaseManager.fetchTodoListStream();
  }

  Future<void> delete(Todo todoList) async {
    await databaseManager.delete(todoList);
  }

  Future<void> update(List<Todo> todoList) async {
    await databaseManager.updateTodos(todoList);
  }

  Future<void> logout() async {
    await databaseManager.logout();
  }
}
