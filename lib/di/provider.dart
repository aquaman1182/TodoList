
import 'package:flutter/material.dart';
import 'package:gonput_2/models/db/database_manager.dart';
import 'package:gonput_2/viewmodels/my_view_model.dart';
import 'package:gonput_2/viewmodels/register_view_model.dart';
import 'package:gonput_2/viewmodels/todo_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gonput_2/viewmodels/login_view_model.dart';
import 'package:gonput_2/viewmodels/add_todo_view_model.dart';
import 'package:gonput_2/viewmodels/edit_profile_view_model.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  AppProviders({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(create: (_) => LoginViewModel()),
        ChangeNotifierProvider<RegisterViewModel>(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider<TodoListViewModel>(create: (_) => TodoListViewModel()),
        ChangeNotifierProvider<AddTodoViewModel>(create: (_) => AddTodoViewModel()),
        ChangeNotifierProvider<MyViewModel>(create: (_) => MyViewModel(databaseManager: DatabaseManager())),
        ChangeNotifierProvider<EditProfileViewModel>(create: (_) => EditProfileViewModel()),
      ],
      child: child,
    );
  }
}
