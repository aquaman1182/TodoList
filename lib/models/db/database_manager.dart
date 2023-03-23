import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gonput_2/domain/todo.dart';

class DatabaseManager {
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

  Future<void> updateProfile(String name) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': name,
    });
  }

  Future<String?> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final currentUser = FirebaseAuth.instance.currentUser;
      return currentUser?.uid;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<Map<String, String?>?> fetchUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    // ユーザーのメールアドレスを取得
    final email = user.email;

    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final data = snapshot.data();
    if (data == null) return null;

    final name = data['name'];
    return {'email': email, 'name': name};
  }

  Future<void> signUp(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      // firebase authでユーザー作成
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user != null) {
        final uid = user.uid;

        // firestoreに追加
        final doc = FirebaseFirestore.instance.collection('users').doc(uid);
        await doc.set({
          'uid': uid,
          'email': email,
        });
      }
    }
  }

  Future<List<Todo>> fetchTodoList() async {
    await Firebase.initializeApp();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    final snapshot = await FirebaseFirestore.instance
        .collection('todo')
        .where('userId', isEqualTo: user.uid)
        .get();

    final List<Todo> todo = [];

    for (final doc in snapshot.docs) {
      final id = doc.id;
      final data = doc.data();
      final task = data['task'];
      final userId = data['userId'];

      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final userData = userSnapshot.data();
      final name = userData?['name'] ?? '';

      todo.add(Todo(id: id, task: task, name: name));
    }

    return todo;
  }

  Future<void> delete(Todo todo) async {
    await FirebaseFirestore.instance.collection('todo').doc(todo.id).delete();
  }

  Future<void> updateTodos(List<Todo> todoList) async {
    final batch = FirebaseFirestore.instance.batch();

    final oldTodos = FirebaseFirestore.instance.collection('todo').where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid);

    await oldTodos.get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });
    });

    todoList.forEach((todo) {
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
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

