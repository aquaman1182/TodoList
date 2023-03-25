import 'package:flutter/material.dart';
import 'package:gonput_2/domain/userdata/userclassdata.dart';
import 'package:gonput_2/models/repository/register_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterRepository _registerRepository;

  RegisterViewModel({required RegisterRepository registerRepository}) : _registerRepository = registerRepository;

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
    UserClassData? user;
    String? password;
    await _registerRepository.signUp(user!, password!);
  }
}
