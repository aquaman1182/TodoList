import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gonput_2/models/repository/tsaks_all_repository.dart';
import '../domain/tododata/todo.dart';

class TasksAllViewModel extends ChangeNotifier {
  List<Todo>? allTasksList;
  final TasksAllRepository tasksAllRepository;
  StreamSubscription? allTasksListSubscription;

  TasksAllViewModel({required TasksAllRepository tasksAllRepository})
      : tasksAllRepository = tasksAllRepository {
    subscribeAllTasksList();
  }

  void subscribeAllTasksList() {
    allTasksListSubscription?.cancel();
    allTasksListSubscription =
        tasksAllRepository.fetchTodos().listen((newAllTasksList) {
      allTasksList = newAllTasksList;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    allTasksListSubscription?.cancel();
    super.dispose();
  }
}
