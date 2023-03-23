import 'package:flutter/material.dart';
import 'package:gonput_2/models/repository/add_todo_repository.dart';
import 'package:gonput_2/models/repository/todo_repository.dart';

class AddTodoViewModel extends ChangeNotifier {
  final AddTodoRepository _addTodoRepository;
  final TodoListRepository _todoListRepository;

  AddTodoViewModel({required AddTodoRepository addTodoRepository, required TodoListRepository todoListRepository})
      : _addTodoRepository = addTodoRepository,
        _todoListRepository = todoListRepository;
  String task = '';

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

