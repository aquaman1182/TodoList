import 'package:flutter/widgets.dart';
import 'package:gonput_2/models/login_auth_repository.dart';
import 'package:gonput_2/models/register_repository.dart';
import 'package:gonput_2/models/todo_repository.dart';
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
        ChangeNotifierProvider<LoginViewModel>(create: (_) => LoginViewModel(authRepository: AuthRepository())),
        ChangeNotifierProvider<RegisterViewModel>(create: (_) => RegisterViewModel(registerRepository: RegisterRepository())),
        ChangeNotifierProvider<TodoListViewModel>(create: (_) => TodoListViewModel(todoListRepository: TodoListRepository())),
        ChangeNotifierProvider<AddTodoViewModel>(create: (_) => AddTodoViewModel()),
        ChangeNotifierProvider<MyViewModel>(create: (_) => MyViewModel()),
        ChangeNotifierProvider<EditProfileViewModel>(create: (_) => EditProfileViewModel()),
      ],
      child: child,
    );
  }
}
