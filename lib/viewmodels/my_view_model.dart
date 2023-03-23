import 'package:flutter/material.dart';
import 'package:gonput_2/models/db/database_manager.dart';

class MyViewModel extends ChangeNotifier {
  String? name;
  String? email;
  bool isFetched = false;
  final DatabaseManager _databaseManager;

  MyViewModel({required DatabaseManager databaseManager})
      : _databaseManager = databaseManager {
    fetchUser();
  }

  Future<void> fetchUser() async {
    final userData = await _databaseManager.fetchUser();

    if (userData != null) {
      name = userData['name'];
      email = userData['email'];
    }

    isFetched = true;
    notifyListeners();
  }
}
