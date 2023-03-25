//修正前のコード
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AddTodoRepository {
//   Future<void> addTodo(String task) async {
//     final user = FirebaseAuth.instance.currentUser;
//     final userId = user?.uid ?? 'ナナシさん';
//     final collection = FirebaseFirestore.instance.collection('todo');
//     await collection.add({
//       'task': task,
//       'createdAt': Timestamp.now(),
//       'isDone': false,
//       'userId': userId,
//     });
//   }
// }

import 'package:gonput_2/domain/tododata/todo.dart';
import 'package:gonput_2/models/db/database_manager.dart';

class AddTodoRepository {
  final DatabaseManager _databaseManager;

  AddTodoRepository({required DatabaseManager databaseManager})
      : _databaseManager = databaseManager;

  Future<void> addTodo(Todo todo) async {
    await _databaseManager.addTodo(todo);
  }
}
