import 'package:flutter/material.dart';
import 'package:gonput_2/models/my_repository.dart';

class MyViewModel extends ChangeNotifier {
  final MyRepository _myRepository = MyRepository();
  bool isLoading = false;
  bool isFetched = false;
  String? email;
  String? name;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    startLoading();
    final userData = await _myRepository.fetchUser();
    if (userData != null) {
      email = userData['email'];
      name = userData['name'];
      isFetched = true;
    }
    endLoading();
    notifyListeners();
  }
}
