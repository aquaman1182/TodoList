import 'package:flutter/material.dart';
import 'package:gonput_2/models/add_todo_repository.dart';
import 'package:gonput_2/models/todo_repository.dart';
import 'package:gonput_2/viewmodels/todo_list_view_model.dart';

class AddTodoViewModel extends ChangeNotifier {
  String task = '';
  final AddTodoRepository _addTodoRepository = AddTodoRepository();
  final TodoListRepository _todoListRepository = TodoListRepository();

  void updateTask(String value) {
    task = value;
    notifyListeners();
  }

  Future<void> addTodo() async {
    await _addTodoRepository.addTodo(task);

    // 更新されたデータを再取得する
    final todoListViewModel = TodoListViewModel(todoListRepository: _todoListRepository); // 修正: 名前付き引数を使用
    await todoListViewModel.fetchTodoList();
    todoListViewModel.update(todoListViewModel.todoList!);
  }

  void setTask(String text) {
    task = text;
  }
}
