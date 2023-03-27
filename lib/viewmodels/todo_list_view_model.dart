import 'dart:async'; // 追加
import 'package:flutter/material.dart';
import 'package:gonput_2/models/repository/todo_repository.dart';
import '../domain/tododata/todo.dart';

class TodoListViewModel extends ChangeNotifier {
  List<Todo>? todoList;
  final TodoListRepository todoListRepository;
  StreamSubscription? todoListSubscription;

  TodoListViewModel({required TodoListRepository todoListRepository})
      : todoListRepository = todoListRepository {
    subscribeTodoList();
  }

  void subscribeTodoList() {
    todoListSubscription?.cancel();
    todoListSubscription =
        todoListRepository.fetchTodoListStream().listen((newTodoList) {
      todoList = newTodoList;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    todoListSubscription?.cancel();
    super.dispose();
  }

  Future<void> delete(Todo todoList) async {
    await todoListRepository.delete(todoList);
  }

  Future<void> update(List<Todo> todoList) async {
    await todoListRepository.update(todoList);
  }

  Future<void> logout() async {
    await todoListRepository.logout();
  }
}
