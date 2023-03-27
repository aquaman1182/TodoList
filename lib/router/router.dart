import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/view/add_todo_page.dart';
import 'package:gonput_2/view/edit_profile_page.dart';
import 'package:gonput_2/view/login_page.dart';
import 'package:gonput_2/view/my_page.dart';
import 'package:gonput_2/view/register_page.dart';
import 'package:gonput_2/view/tasks_all_page.dart';

import '../view/todo_list.dart';

GoRouter createGoRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            MaterialPage(
          key: state.pageKey,
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            MaterialPage(
          key: state.pageKey,
          child: RegisterPage(),
        ),
      ),
      GoRoute(
        path: '/todo_list',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            MaterialPage(
          key: state.pageKey,
          child: TodoListPage(),
        ),
      ),
      GoRoute(
        name: "add_todo",
        path: '/add_todo',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: AddTodoPage(),
          );
        },
      ),
      GoRoute(
        path: '/my_page',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: MyPage(),
          );
        },
      ),
      GoRoute(
        path: '/edit_profile_page/:name',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: EditProfilePage(),
          );
        },
      ),
      GoRoute(
        path: '/tasks_all',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            MaterialPage(
          key: state.pageKey,
          child: TasksAllPage(),
        ),
      ),
    ],
  );
}
