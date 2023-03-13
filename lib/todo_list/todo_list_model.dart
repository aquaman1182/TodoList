import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../domain/todo.dart';


class TodoListModele extends ChangeNotifier {
  String? name;
  List<Todo>? todo;

        Future <void> fetchTodoList() async {
        final QuerySnapshot snapshot = 
        await FirebaseFirestore.instance.collection('todo').get();
        final  List<Todo> todo = snapshot.docs.map((DocumentSnapshot document) {
           Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            final String id = document.id;
            final String task = data["task"];
            return Todo(id, task);
            }).toList();

            this.todo = todo;
            notifyListeners();
  }

  Future delete(Todo todo) {
    return FirebaseFirestore.instance.collection('todo').doc(todo.id).delete();
  }

  Future logout() async{
    await FirebaseAuth.instance.signOut();
  }
}