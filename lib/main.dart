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
        onGenerateRoute: (settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) => LoginPage(), // あなたのホームページウィジェットに置き換えてください。
      );
    }
    if (settings.name == TodoListPage.routeName) {
      return MaterialPageRoute(
        builder: (context) => TodoListPage());
    }
    if (settings.name == EditProfilePage.routeName) {
      final String name = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => EditProfilePage(name),
      );
    }
    if (settings.name == MyPage.routeName) {
      return MaterialPageRoute(
        builder: (context) => MyPage(),
      );
    }
    if (settings.name == LoginPage.routeName) {
      return MaterialPageRoute(
        builder: (context) => LoginPage(),
      );
    }
    if (settings.name == AddTodoPage.routeName) {
      return MaterialPageRoute(
        builder: (context) => AddTodoPage(),
      );
    }
    // 他のルートの設定もここに追加できます。
    return null;
  },
      ),
    );
  }
}
