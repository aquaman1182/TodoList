import 'package:flutter/material.dart';
import 'package:gonput_2/models/db/database_manager.dart';
import 'package:gonput_2/models/repository/register_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterRepository _registerRepository = RegisterRepository(databaseManager: DatabaseManager());

  final titleController = TextEditingController();
  final authorController = TextEditingController();

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setEmail(String email) {
    _registerRepository.setEmail(email);
    notifyListeners();
  }

  void setPassword(String password) {
    _registerRepository.setPassword(password);
    notifyListeners();
  }

  Future<void> signUp() async {
    String? email;
    String? password;
    await _registerRepository.signUp(email!, password!);
  }
}
