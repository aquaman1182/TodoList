import 'package:flutter/material.dart';
import 'package:gonput_2/domain/tododata/todo.dart';
import 'package:gonput_2/domain/userdata/userclassdata.dart';
import 'package:gonput_2/models/repository/add_todo_repository.dart';
import 'package:gonput_2/models/repository/todo_repository.dart';
import 'package:gonput_2/viewmodels/todo_list_view_model.dart';

class AddTodoViewModel extends ChangeNotifier {
  final AddTodoRepository addTodoRepository;
  final TodoListViewModel todoListViewModel;

  AddTodoViewModel({
    required this.todoList,
    required this.currentUserData,
    required AddTodoRepository addTodoRepository,
    required TodoListViewModel todoListViewModel,
    required TodoListRepository todoListRepository,
  })  : addTodoRepository = addTodoRepository,
        todoListViewModel = todoListViewModel;

  final UserClassData currentUserData;
  final Todo todoList;

  void updateTodos() {
    todoList.task;
    notifyListeners();
  }

  Future<void> addTodo() async {
    // 新しいTodoオブジェクトを作成
    final newTodo = Todo(id: '', task: todoList.task, name: '', userId: '');

    // 新しいTodoを追加
    await addTodoRepository.addTodo(newTodo);
    notifyListeners();
  }
}
