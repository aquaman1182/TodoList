import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gonput_2/domain/tododata/todo.dart';
import 'package:gonput_2/domain/userdata/userclassdata.dart';

  class DatabaseManager {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    //修正済　動作確認済（多分）
    Future<String> fetchUserName(UserClassData user) async {
      final userSnapshot = await _db.collection('users').doc(user.uid).get();
      final userData = userSnapshot.data();
      return userData?['name'] ?? '';
    }

        //修正済み　動作確認完了
Future<void> addTodo(Todo todo) async {
  final user = FirebaseAuth.instance.currentUser;
  final name = user?.displayName ?? 'ナナシさん';
  final task = todo.task;
  final userId = user?.uid ?? "";

  // 新しいTodoドキュメントを作成
  final docRef = _db.collection('todo').doc();

  // TodoオブジェクトにドキュメントIDとユーザーIDを追加
  final updatedTodo = todo.copyWith(
    id: docRef.id,
    task: task,
    name: name,
    userId: userId
  );

  // 新しいTodoドキュメントにデータをセット
  await docRef.set(updatedTodo.toJson());
}


    //修正前
    // Future<void> addTodo(String task) async {
    //   final user = FirebaseAuth.instance.currentUser;
    //   final userId = user?.uid ?? 'ナナシさん';
    //   final collection = FirebaseFirestore.instance.collection('todo');
    //   await collection.add({
    //     'task': task,
    //     'createdAt': Timestamp.now(),
    //     'isDone': false,
    //     'userId': userId,
    //   });
    // }
    //修正済　動作確認済
      Future<void> updateProfile(UserClassData user) async {
        await _db.collection('users').doc(user.uid).update(user.toJson(),);
      }
    //修正済　動作確認済
    Future<String?> login(UserClassData user, String password) async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: user.email, password: password);
        final currentUser = FirebaseAuth.instance.currentUser;
        return currentUser?.uid;
      } on FirebaseAuthException catch (e) {
        return e.message;
      } catch (e) {
        return e.toString();
      }
    }
      //修正済　動作確認済
    Stream<UserClassData?> fetchUserStream() {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) return Stream.value(null);

        // ユーザーのメールアドレスを取得
        final String email = user.email!;

        return _db
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .map((snapshot) {
              final data = snapshot.data();
              if (data == null) return null;

              final userClassData = UserClassData.fromJson(data);

              final updatedUserClassData = userClassData.copyWith(email: email);

              return updatedUserClassData;
            });
      }



    //修正前
    // Future<Map<String, String?>?> fetchUser() async {
    //   final user = FirebaseAuth.instance.currentUser;
    //   if (user == null) return null;

    //   // ユーザーのメールアドレスを取得
    //   final email = user.email;

    //   final snapshot =
    //       await _db.collection('users').doc(user.uid).get();
    //   final data = snapshot.data();
    //   if (data == null) return null;
    //   final name = data['name'];
    //   return {'email': email, 'name': name};
    // }

  //修正済　動作確認済
Future<void> signUp(UserClassData user, String password) async {
    if (user.email.isNotEmpty && password.isNotEmpty) {
      // firebase authでユーザー作成
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user.email, password: password);
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // firestoreに追加
        final doc = _db.collection('users').doc(user.uid);
        await doc.set(user.toJson());
      }
    }
  }

    //修正前
    // Future<List<Todo>> fetchTodoList() async {
    //   await Firebase.initializeApp();
    //   final user = FirebaseAuth.instance.currentUser;
    //   if (user == null) return [];

    //   final snapshot = await FirebaseFirestore.instance
    //       .collection('todo')
    //       .where('userId', isEqualTo: user.uid)
    //       .get();

    //   final List<Todo> todo = [];

    //   for (final doc in snapshot.docs) {
    //     final id = doc.id;
    //     final data = doc.data();
    //     final task = data['task'];
    //     final userId = data['userId'];

    //     final userSnapshot = await FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(userId)
    //         .get();
    //     final userData = userSnapshot.data();
    //     final name = userData?['name'] ?? '';

    //     todo.add(Todo(id: id, task: task, name: name));
    //   }

    //   return todo;
    // }
    //修正済　動作確認済
Stream<List<Todo>> fetchTodoListStream() async* {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) yield [];

  await for (final snapshot in _db
      .collection('todo')
      .where('userId', isEqualTo: user!.uid)
      .snapshots()) {
    final List<Todo> todo = [];

    for (final doc in snapshot.docs) {
      final id = doc.id;
      final data = doc.data();
      final task = data['task'];
      final userId = data['userId']; // ここを修正

      // データベース内のnameフィールドをuserIdフィールドにマッピング
      final userSnapshot = await _db.collection('users').doc(userId).get();
      final userData = userSnapshot.data();
      final name = userData?['name'] ?? '';

      todo.add(Todo(id: id, task: task, name: name, userId: userId)); // ここを修正
    }

    yield todo;
  }
}







    //修正済　動作確認済
    Future<void> delete(Todo todo) async {
      await _db.collection('todo').doc(todo.id).delete();
    }

    //修正済み
  //   Future<void> updateTodos(List<Todo> todoList) async {
  //   final batch = _db.batch();

  //   final oldTodos = _db.collection('todo').where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid);

  //   await oldTodos.get().then((snapshot) {
  //     snapshot.docs.forEach((doc) {
  //       batch.delete(doc.reference);
  //     });
  //   });

  //   todoList.forEach((todo) {
  //     final doc = _db.collection('todo').doc();
  //     final updatedTodo = todo.copyWith(id: doc.id);
  //     batch.set(doc, updatedTodo.toJson());
  //   });

  //   await batch.commit();
  // }

    //修正済　動作確認済
    Future<void> updateTodos(List<Todo> todoList) async {
      final batch = _db.batch();

      final oldTodos = _db.collection('todo').where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid);

      await oldTodos.get().then((snapshot) {
        snapshot.docs.forEach((doc) {
          batch.delete(doc.reference);
        });
      });

      todoList.forEach((todo) {
        final doc = _db.collection('todo').doc();
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

