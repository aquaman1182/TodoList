import 'dart:async'; // 追加
import 'package:flutter/material.dart';
import 'package:gonput_2/models/repository/todo_repository.dart';
import '../domain/tododata/todo.dart';

class TodoListViewModel extends ChangeNotifier {
  List<Todo>? todoList;
  final TodoListRepository todoListRepository;
  StreamSubscription? _todoListSubscription; // 追加

  TodoListViewModel({required this.todoListRepository});

  void subscribeTodoList() {
    // 追加
    _todoListSubscription?.cancel();
    _todoListSubscription =
        todoListRepository.fetchTodoListStream().listen((newTodoList) {
      todoList = newTodoList;
      for (var todo in todoList!) {
        print('ID: ${todo.id}, Task: ${todo.task}, Name: ${todo.name}');
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _todoListSubscription?.cancel(); // 追加
    super.dispose();
  }

  Future<void> delete(Todo todoList) async {
    await todoListRepository.delete(todoList);
    // await fetchTodoList(); 削除
  }

  Future<void> update(List<Todo> todoList) async {
    await todoListRepository.update(todoList);
    // await fetchTodoList(); 削除
  }

  Future<void> logout() async {
    await todoListRepository.logout();
  }
}
