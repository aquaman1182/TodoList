import 'package:gonput_2/domain/tododata/todo.dart';
import 'package:gonput_2/domain/userdata/userclassdata.dart';
import 'package:gonput_2/models/repository/add_todo_repository.dart';
import 'package:gonput_2/models/repository/edit_profile_repository.dart';
import 'package:gonput_2/models/repository/my_repository.dart';
import 'package:gonput_2/models/repository/register_repository.dart';
import 'package:gonput_2/models/repository/todo_repository.dart';
import 'package:gonput_2/models/repository/tsaks_all_repository.dart';
import 'package:gonput_2/viewmodels/add_todo_view_model.dart';
import 'package:gonput_2/viewmodels/edit_profile_view_model.dart';
import 'package:gonput_2/viewmodels/login_view_model.dart';
import 'package:gonput_2/viewmodels/my_view_model.dart';
import 'package:gonput_2/viewmodels/register_view_model.dart';
import 'package:gonput_2/viewmodels/tasks_all_view_model.dart';
import 'package:gonput_2/viewmodels/todo_list_view_model.dart';
import 'package:provider/provider.dart';
import '../models/db/database_manager.dart';
import 'package:provider/single_child_widget.dart';
import '../models/repository/login_auth_repository.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
    create: (_) {
      return DatabaseManager();
    },
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, AuthRepository>(
    update: (_, dbManager, repo) => AuthRepository(databaseManager: dbManager),
  ),
  ProxyProvider<DatabaseManager, RegisterRepository>(
    update: (_, dbManager, repo) =>
        RegisterRepository(databaseManager: dbManager),
  ),
  ProxyProvider<DatabaseManager, TodoListRepository>(
    update: (_, dbManager, repo) =>
        TodoListRepository(databaseManager: dbManager),
  ),
  ProxyProvider<DatabaseManager, MyRepository>(
    update: (_, dbManager, repo) => MyRepository(databaseManager: dbManager),
  ),
  ProxyProvider<DatabaseManager, EditProfileRepository>(
    update: (_, dbManager, repo) =>
        EditProfileRepository(databaseManager: dbManager),
  ),
  ProxyProvider<DatabaseManager, AddTodoRepository>(
    update: (_, dbManager, repo) =>
        AddTodoRepository(databaseManager: dbManager),
  ),
  ProxyProvider<DatabaseManager, TasksAllRepository>(
    update: (_, dbManager, repo) =>
        TasksAllRepository(databaseManager: dbManager),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
      authRepository: context.read<AuthRepository>(),
    ),
  ),
  ChangeNotifierProvider<RegisterViewModel>(
    create: (context) => RegisterViewModel(
      registerRepository: context.read<RegisterRepository>(),
    ),
  ),
  ChangeNotifierProvider<TodoListViewModel>(
    create: (context) => TodoListViewModel(
      todoListRepository: context.read<TodoListRepository>(),
    ),
  ),
  ChangeNotifierProvider<MyViewModel>(
    create: (context) => MyViewModel(
      myRepository: context.read<MyRepository>(),
    ),
  ),
  ChangeNotifierProvider<EditProfileViewModel>(
      create: (context) => EditProfileViewModel(
            currentUserData: context.read<MyViewModel>().user ??
                UserClassData(uid: '', name: '', email: ''),
            editProfileRepository: context.read<EditProfileRepository>(),
          )),
  ChangeNotifierProvider<AddTodoViewModel>(
    create: (context) => AddTodoViewModel(
      addTodoRepository: context.read<AddTodoRepository>(),
      todoListRepository:
          TodoListRepository(databaseManager: DatabaseManager()),
      todoListViewModel: TodoListViewModel(
          todoListRepository:
              TodoListRepository(databaseManager: DatabaseManager())),
      currentUserData: UserClassData(email: "", name: "", uid: ""),
      todoList: Todo(id: "", task: "", name: "", userId: ""),
    ),
  ),
  ChangeNotifierProvider<TasksAllViewModel>(
    create: (context) => TasksAllViewModel(
      tasksAllRepository: context.read<TasksAllRepository>(),
    ),
  ),
];
