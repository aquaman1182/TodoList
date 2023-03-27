// import 'dart:async'; // 追加
// import 'package:flutter/material.dart';
// import 'package:gonput_2/domain/tododata/todo.dart';
// import 'package:gonput_2/models/db/database_manager.dart';

// class TasksAllViewModel extends ChangeNotifier {
//   List<Todo>? todos;
//   final DatabaseManager _databaseManager;
//   StreamSubscription? todosSubscription; // 追加

//   TasksAllViewModel({required DatabaseManager databaseManager})
//       : _databaseManager = databaseManager {
//     subscribeTodos(); // 追加
//   }
//     Stream<List<Todo>> todosStream() {
//     return _databaseManager.fetchTodos();
//   }

//   void subscribeTodos() { // 追加
//     todosSubscription?.cancel();
//     todosSubscription = _databaseManager.fetchTodos().listen((newTodos) {
//       todos = newTodos;

//       // Debug
//       for (var todo in todos!) {
//         print('Task: ${todo.task}, Name: ${todo.userId}');
//       }

//       notifyListeners();
//     });
//   }

//   @override
//   void dispose() {
//     todosSubscription?.cancel(); // 追加
//     super.dispose();
//   }
// }

// AllTasksViewModel.dart

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

