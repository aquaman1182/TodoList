import 'package:flutter/material.dart';
import 'package:gonput_2/view/components/bottom_navigation.dart';
import 'package:gonput_2/view/components/tasks_all_list.dart';

class TasksAllPage extends StatelessWidget {
  static const routeName = '/TodoListPage';

  @override
  Widget build(BuildContext context) {
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
