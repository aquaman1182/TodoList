import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../domain/todo.dart';


class TodoListModele extends ChangeNotifier {
  
  List<Todo>? todos;

  void fetchTodoList() async {
        final QuerySnapshot snapshot = 
        await FirebaseFirestore.instance.collection('todo').get();

        final  List<Todo> todos = snapshot.docs.map((DocumentSnapshot document) {
           Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            final String task = data["task"];
            final String user = data["user"];
            return Todo(task, user);
            }).toList();

            this.todos = todos;
            notifyListeners();
  }
}