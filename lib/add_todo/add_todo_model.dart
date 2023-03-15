import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gonput_2/todo_list/todo_list_model.dart';

class AddTodoModel extends ChangeNotifier {
  String task = '';

  void updateTask(String value) {
    task = value;
    notifyListeners();
  }

  Future<void> addTodo() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? 'ナナシさん';
    final collection = FirebaseFirestore.instance.collection('todo');
    await collection.add({
      'task': task,
      'createdAt': Timestamp.now(),
      'isDone': false,
      'userId': userId, 
    });

    // 更新されたデータを再取得する
    final todoListModel = TodoListModel();
    await todoListModel.fetchTodoList();
    todoListModel.update(todoListModel.todoList!);
  }
}