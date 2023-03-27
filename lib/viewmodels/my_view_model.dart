import 'package:flutter/material.dart';
import 'package:gonput_2/domain/userdata/userclassdata.dart';
import 'package:gonput_2/models/repository/my_repository.dart';

class MyViewModel extends ChangeNotifier {
  UserClassData? user;
  final MyRepository myRepository;

  MyViewModel({required MyRepository myRepository})
      : myRepository = myRepository {
    myRepository.fetchUserStream().listen((userData) {
      user = userData;
      notifyListeners();
    });
  }
}
