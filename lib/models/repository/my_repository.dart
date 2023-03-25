// //修正前のコード
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class MyRepository {
// //   Future<Map<String, String?>?> fetchUser() async {
// //     final user = FirebaseAuth.instance.currentUser;
// //     if (user == null) return null;

// //     // ユーザーのメールアドレスを取得
// //     final email = user.email;

// //     final snapshot =
// //         await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
// //     final data = snapshot.data();
// //     if (data == null) return null;

// //     final name = data['name'];
// //     return {'email': email, 'name': name};
// //   }
// // }

// import 'package:gonput_2/domain/userdata/userclassdata.dart';
// import 'package:gonput_2/models/db/database_manager.dart';

// class MyRepository {
//   final DatabaseManager _databaseManager;

//   MyRepository({required DatabaseManager databaseManager})
//       : _databaseManager = databaseManager;

//   Future<Stream<UserClassData?>> fetchUser() async {
//     return await _databaseManager.fetchUserStream();
//   }

//     Future<Stream<UserClassData?>> getUser() async {
//     return await _databaseManager.fetchUserStream();
//   }
// }

import 'package:gonput_2/domain/userdata/userclassdata.dart';

import '../db/database_manager.dart';

class MyRepository {
  final DatabaseManager _databaseManager;

  MyRepository({required DatabaseManager databaseManager})
      : _databaseManager = databaseManager;

  Stream<UserClassData?> fetchUserStream() {
    return _databaseManager.fetchUserStream();
  }
}

