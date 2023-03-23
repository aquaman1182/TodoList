import 'package:flutter/material.dart';
import 'package:gonput_2/models/repository/add_todo_repository.dart';
import 'package:gonput_2/models/db/database_manager.dart';
import 'package:gonput_2/models/repository/todo_repository.dart';

class AddTodoViewModel extends ChangeNotifier {
  String task = '';
  final AddTodoRepository _addTodoRepository = AddTodoRepository(databaseManager: DatabaseManager());
  final TodoListRepository _todoListRepository = TodoListRepository(databaseManager: DatabaseManager());

  void updateTask(String value) {
    task = value;
    notifyListeners();
  }

  Future<void> addTodo() async {
    await _addTodoRepository.addTodo(task);

    // 更新されたデータを再取得する
    await _todoListRepository.fetchTodoList();
  }

  void setTask(String text) {
    task = text;
  }
}

