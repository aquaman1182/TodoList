//修正前のコード

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import '../domain/todo.dart';

// class TodoListRepository {
//   Future<List<Todo>> fetchTodoList() async {
//     await Firebase.initializeApp();
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return [];

//     final snapshot = await FirebaseFirestore.instance
//         .collection('todo')
//         .where('userId', isEqualTo: user.uid)
//         .get();

//     final List<Todo> todo = [];

//     for (final doc in snapshot.docs) {
//       final id = doc.id;
//       final data = doc.data();
//       final task = data['task'];
//       final userId = data['userId'];

//       final userSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .get();
//       final userData = userSnapshot.data();
//       final name = userData?['name'] ?? '';

//       todo.add(Todo(id: id, task: task, name: name));
//     }

//     return todo;
//   }

//   Future<void> delete(Todo todo) async {
//     await FirebaseFirestore.instance.collection('todo').doc(todo.id).delete();
//   }

//   Future<void> update(List<Todo> todo) async {
//     final batch = FirebaseFirestore.instance.batch();

//     final oldTodos = FirebaseFirestore.instance.collection('todo').where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid);

//     await oldTodos.get().then((snapshot) {
//       snapshot.docs.forEach((doc) {
//         batch.delete(doc.reference);
//       });
//     });

//     todo.forEach((todo) {
//       final doc = FirebaseFirestore.instance.collection('todo').doc();
//       batch.set(doc, {
//         'id': doc.id,
//         'userId': FirebaseAuth.instance.currentUser?.uid,
//         'task': todo.task,
//         'createdAt': FieldValue.serverTimestamp(),
//         'isDone': false,
//       });
//     });

//     await batch.commit();
//   }

//   Future<void> logout() async {
//     await FirebaseAuth.instance.signOut();
//   }
// }

import 'package:gonput_2/domain/todo.dart';
import 'package:gonput_2/models/db/database_manager.dart';

class TodoListRepository {
  final DatabaseManager _databaseManager;

  TodoListRepository({required DatabaseManager databaseManager})
      : _databaseManager = databaseManager;

  Future<List<Todo>> fetchTodoList() async {
    return await _databaseManager.fetchTodoList();
  }

  Future<void> delete(Todo todo) async {
    await _databaseManager.delete(todo);
  }

  Future<void> update(List<Todo> todo) async {
    await _databaseManager.updateTodos(todo);
  }

  Future<void> logout() async {
    await _databaseManager.logout();
  }
}
