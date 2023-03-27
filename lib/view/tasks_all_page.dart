import 'package:flutter/material.dart';
import 'package:gonput_2/view/components/bottom_navigation.dart';
import 'package:gonput_2/view/components/tasks_all_list.dart';
import 'package:gonput_2/viewmodels/tasks_all_view_model.dart';
import 'package:provider/provider.dart';

class TasksAllPage extends StatelessWidget {
  static const routeName = '/TodoListPage';

  @override
  Widget build(BuildContext context) {
    final TasksAllViewModel tasksAllViewModel = context.read();
    final todos = tasksAllViewModel.allTasksList;

    if (todos == null) {
      return Center(
        child: CircularProgressIndicator()
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("みんなのToDo一覧"),
      ),
      body: Center(
        child: TasksAllList(),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),
    );
  }
}