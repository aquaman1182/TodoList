import 'package:gonput_2/domain/tododata/todo.dart';
import 'package:gonput_2/models/db/database_manager.dart';

class TasksAllRepository {
  final DatabaseManager databaseManager;

  TasksAllRepository({required DatabaseManager databaseManager})
      : databaseManager = databaseManager;

  Stream<List<Todo>> fetchTodos() {
    return databaseManager.fetchTodos();
  }
}
