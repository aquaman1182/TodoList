import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  CustomBottomNavigationBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) {
        if (index != currentIndex) {
          switch (index) {
            case 0:
              context.go('/todo_list');
              break;
            case 1:
              context.go('/my_page');
              break;
            case 2:
              context.go('/tasks_all');
              break;
          }
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "TodoList"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "MyPage"),
        BottomNavigationBarItem(icon: Icon(Icons.task), label: "TasksAll")
      ],
    );
  }
}