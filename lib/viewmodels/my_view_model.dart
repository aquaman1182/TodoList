// import 'package:flutter/material.dart';
// import 'package:gonput_2/domain/userdata/userclassdata.dart';
// import 'package:gonput_2/models/repository/my_repository.dart'; // 追加: DatabaseManagerをインポート

// class MyViewModel extends ChangeNotifier {
//   String? name;
//   UserClassData? user; // 追加: UserClassDataオブジェクトを追加
//   final MyRepository _myRepository;

//   MyViewModel({required MyRepository myRepository}) : _myRepository = myRepository;

//   bool _isFetched = false;
  
//   bool get isFetched => _isFetched;

//     Future<void> fetchUser() async {
//       final userData = await _myRepository.getUser();
//     if (userData != null) {
//       // 追加: UserClassDataオブジェクトを作成
//       user = UserClassData(
//           uid: userData.uid,
//           name: userData.name,
//           email: userData.email,
//       );
//     } else {
//       // デフォルト値を設定
//       user = UserClassData(uid: '', name: '', email: '');
//     }
    
//     _isFetched = true;
//     notifyListeners();
//   }
//     Future<UserClassData?> getUser() async {
//     await fetchUser();
//     return user;
//   }
// }

import 'package:flutter/material.dart';
import 'package:gonput_2/domain/userdata/userclassdata.dart';
import 'package:gonput_2/models/repository/my_repository.dart';

class MyViewModel extends ChangeNotifier {
  UserClassData? user;
  final MyRepository _myRepository;

  MyViewModel({required MyRepository myRepository}) : _myRepository = myRepository {
    _myRepository.fetchUserStream().listen((userData) {
      user = userData;
      notifyListeners();
    });
  }
}
