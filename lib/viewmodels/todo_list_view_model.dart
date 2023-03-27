import 'dart:async'; // 追加
import 'package:flutter/material.dart';
import 'package:gonput_2/models/repository/todo_repository.dart';
import '../domain/tododata/todo.dart';

class TodoListViewModel extends ChangeNotifier {
  List<Todo>? todoList;
  final TodoListRepository todoListRepository;
  StreamSubscription? todoListSubscription; // 追加

  TodoListViewModel({required TodoListRepository todoListRepository})
      : todoListRepository = todoListRepository {
    subscribeTodoList(); // 追加
  }

  void subscribeTodoList() { // 追加
    todoListSubscription?.cancel();
    todoListSubscription = todoListRepository.fetchTodoListStream().listen((newTodoList) {
      todoList = newTodoList;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    todoListSubscription?.cancel(); // 追加
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
