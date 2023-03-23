import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
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
}