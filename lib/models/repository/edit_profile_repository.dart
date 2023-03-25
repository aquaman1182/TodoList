//修正前のコード
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class EditProfileRepository {
//   Future<void> update(String name) async {
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//     await FirebaseFirestore.instance.collection('users').doc(uid).update({
//       'name': name,
//     });
//   }
// }

import 'package:gonput_2/domain/userdata/userclassdata.dart';
import 'package:gonput_2/models/db/database_manager.dart';

class EditProfileRepository {
  final DatabaseManager _databaseManager;

  EditProfileRepository({required DatabaseManager databaseManager})
      : _databaseManager = databaseManager;

  Future<void> update(UserClassData user) async {
    await _databaseManager.updateProfile(user);
  }

}
