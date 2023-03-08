import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gonput_2/firebase_options.dart';
import 'package:gonput_2/todo_list/todo_list.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ToDoList",
      home: ToDoListPage(),
    );
  }
}

