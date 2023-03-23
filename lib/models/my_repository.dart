import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyRepository {
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
}