//修正前のコード
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class RegisterRepository {
//   String? email;
//   String? password;

//   void setEmail(String email) {
//     this.email = email;
//   }

//   void setPassword(String password) {
//     this.password = password;
//   }

//   Future<void> signUp() async {
//     if (email != null && password != null) {
//       // firebase authでユーザー作成
//       final userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email!, password: password!);
//       final user = userCredential.user;

//       if (user != null) {
//         final uid = user.uid;

//         // firestoreに追加
//         final doc = FirebaseFirestore.instance.collection('users').doc(uid);
//         await doc.set({
//           'uid': uid,
//           'email': email,
//         });
//       }
//     }
//   }
// }

import 'package:gonput_2/domain/userdata/userclassdata.dart';

import '../db/database_manager.dart';

class RegisterRepository {
  String? email;
  String? password;
  final DatabaseManager _databaseManager;

  RegisterRepository({required DatabaseManager databaseManager})
      : _databaseManager = databaseManager;

  Future<void> signUp(UserClassData user, String password) async {
    await _databaseManager.signUp(user, password);
  }

  void setEmail(String email) {
    this.email;
  }

  void setPassword(String password) {
    this.password;
  }
}
