import 'dart:js';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/di/provider.dart';
import 'package:gonput_2/view/add_todo_page.dart';
import 'package:gonput_2/view/edit_profile_page.dart';
import 'package:gonput_2/view/login_page.dart';
import 'package:gonput_2/view/my_page.dart';
import 'package:gonput_2/view/register_page.dart';
import 'package:gonput_2/view/todo_list.dart';
import 'package:gonput_2/viewmodels/add_todo_view_model.dart';
import 'package:gonput_2/viewmodels/edit_profile_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppProviders(child: MyApp()));
}

  final GoRouter _goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: RegisterPage(),
      ),
    ),
    GoRoute(
      path: '/todo_list',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
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
        final name = state.params['name'] ?? '名無しの権兵衛';
        return MaterialPage(
          key: state.pageKey,
          child: EditProfilePage(name),
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TodoListApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}