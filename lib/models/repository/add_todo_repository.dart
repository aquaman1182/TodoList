import 'package:gonput_2/domain/tododata/todo.dart';
import 'package:gonput_2/models/db/database_manager.dart';

class AddTodoRepository {
  final DatabaseManager databaseManager;

  AddTodoRepository({required DatabaseManager databaseManager})
      : databaseManager = databaseManager;

  Future<void> addTodo(Todo todo) async {
    await databaseManager.addTodo(todo);
  }
}
