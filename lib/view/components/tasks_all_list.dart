import 'package:flutter/material.dart';
import 'package:gonput_2/domain/tododata/todo.dart';
import 'package:gonput_2/viewmodels/tasks_all_view_model.dart';
import 'package:provider/provider.dart';

class TasksAllList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TasksAllViewModel tasksAllViewModel = context.read();
    final List<Todo>? tasks = tasksAllViewModel.allTasksList;

    if (tasks == null) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final todo = tasks[index];
        return ListTile(
          title: Text(todo.task),
        );
      },
    );
  }
}
