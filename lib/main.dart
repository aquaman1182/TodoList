import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gonput_2/add_todo/add_todo_page.dart';
import 'package:gonput_2/edit_profile/edit_profile_page.dart';
import 'package:gonput_2/login/login_page.dart';
import 'package:gonput_2/mypage/my_page.dart';
import 'package:gonput_2/todo_list/todo_list.dart';
import 'package:provider/provider.dart';

import 'add_todo/add_todo_model.dart';
import 'login/login_model.dart';
import 'mypage/my_model.dart';
import 'todo_list/todo_list_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddTodoModel()),
        ChangeNotifierProvider(create: (_) => LoginModel()),
        ChangeNotifierProvider(create: (_) => TodoListModel()..fetchTodoList()),
        ChangeNotifierProvider(create: (_) => MyModel()..fetchUser()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          AddTodoPage.routeName: (context) => AddTodoPage(),
          TodoListPage.routeName: (context) => TodoListPage(),
          MyPage.routeName: (context) => MyPage(),
          EditProfilePage.routeName: (context) => EditProfilePage(""),
        },
      ),
    );
  }
}

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:gonput_2/add_todo/add_todo_page.dart';
// import 'package:gonput_2/login/login_page.dart';
// import 'package:gonput_2/mypage/my_page.dart';
// import 'package:gonput_2/todo_list/todo_list.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Gonput',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: LoginPage.routeName,
//       routes: {
//         LoginPage.routeName: (context) => const LoginPage(),
//         MyPage.routeName: (context) =>  MyPage(),
//         TodoListPage.routeName: (context) => const TodoListPage(),
//         AddTodoPage.routeName: (context) =>  AddTodoPage(),
//       },
//     );
//   }
// }