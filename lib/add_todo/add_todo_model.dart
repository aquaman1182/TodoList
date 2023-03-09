import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AddTodoModele extends ChangeNotifier {
  String? task;
  String? user;


  Future addTodo() async {

    //firestoreに追加
    await FirebaseFirestore.instance.collection("todo").add({
      "task": task,
      "user": user,
     }
    );
  }
}