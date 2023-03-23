import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddTodoRepository {
  Future<void> addTodo(String task) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? 'ナナシさん';
    final collection = FirebaseFirestore.instance.collection('todo');
    await collection.add({
      'task': task,
      'createdAt': Timestamp.now(),
      'isDone': false,
      'userId': userId,
    });
  }
}
