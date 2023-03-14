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
    final collection = FirebaseFirestore.instance.collection('todo');
    await collection.add({
      'task': task,
      'createdAt': Timestamp.now(),
      'isDone': false,
    });

    // 更新されたデータを再取得する
    final todoListModel = TodoListModel();
    await todoListModel.fetchTodoList();
    todoListModel.update(todoListModel.todoList!);
  }
}