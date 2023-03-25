import 'package:flutter/material.dart';
import 'package:gonput_2/domain/tododata/todo.dart';
import 'package:gonput_2/models/repository/add_todo_repository.dart';
import 'package:gonput_2/models/repository/todo_repository.dart';
import 'package:gonput_2/viewmodels/todo_list_view_model.dart';

class AddTodoViewModel extends ChangeNotifier {
  final AddTodoRepository _addTodoRepository;
  final TodoListViewModel _todoListViewModel;

  AddTodoViewModel({
    required AddTodoRepository addTodoRepository, 
    required TodoListViewModel todoListViewModel, required TodoListRepository todoListRepository,
    })
      : _addTodoRepository = addTodoRepository,
        _todoListViewModel = todoListViewModel;

  String task = '';

  void updateTodos(Todo todoList) {
    task = todoList.task;
    notifyListeners();
  }

  Future<void> addTodo() async {
    // 新しいTodoオブジェクトを作成
    final newTodo = Todo(id: '', task: task, name: '', userId: '');

    // 新しいTodoを追加
    await _addTodoRepository.addTodo(newTodo);
    notifyListeners();
  }
}
