import 'package:flutter/material.dart';
import 'package:gonput_2/models/db/database_manager.dart';
import 'package:gonput_2/models/repository/todo_repository.dart';
import '../domain/todo.dart';

class TodoListViewModel extends ChangeNotifier {
  List<Todo>? todoList;
  final TodoListRepository _todoListRepository = TodoListRepository(databaseManager: DatabaseManager());

  

  Future<void> fetchTodoList() async {
    todoList = await _todoListRepository.fetchTodoList();
    notifyListeners();
  }

  Future<void> delete(Todo todo) async {
    await _todoListRepository.delete(todo);
    await fetchTodoList();
  }

  Future<void> update(List<Todo> todo) async {
    await _todoListRepository.update(todo);
    await fetchTodoList();
  }

  Future<void> logout() async {
    await _todoListRepository.logout();
  }
}
