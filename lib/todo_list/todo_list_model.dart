import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../domain/todo.dart';

class TodoListModel extends ChangeNotifier {
  List<Todo>? todoList;

  Future<void> fetchTodoList() async {
    await Firebase.initializeApp();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('todo')
        .where('userId', isEqualTo: user.uid)
        .get();

    final List<Todo> todos = snapshot.docs.map((doc) {
      final id = doc.id;
      final data = doc.data();
      final task = data['task'];
      return Todo(id, task);
    }).toList();

    todoList = todos;
    notifyListeners();
  }

  Future<void> delete(Todo todo) async {
    await FirebaseFirestore.instance.collection('todo').doc(todo.id).delete();
    await fetchTodoList();
  }

  Future<void> update(List<Todo> todo) async {
    final batch = FirebaseFirestore.instance.batch();

    final oldTodos = FirebaseFirestore.instance.collection('todo').where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid);

    await oldTodos.get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });
    });

    todo.forEach((todo) {
      final doc = FirebaseFirestore.instance.collection('todo').doc();
      batch.set(doc, {
        'id': doc.id,
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'task': todo.task,
        'createdAt': FieldValue.serverTimestamp(),
        'isDone': false,
      });
    });

    await batch.commit();
    await fetchTodoList();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}