import 'package:flutter/material.dart';
import 'package:gonput_2/domain/userdata/userclassdata.dart';
import 'package:gonput_2/models/repository/register_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterRepository registerRepository;

  RegisterViewModel({required RegisterRepository registerRepository})
      : registerRepository = registerRepository;

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<String?> signUp(String email, String pass) async {
    startLoading();
    try {
      final user = UserClassData(email: email, name: '', uid: '');
      await registerRepository.signUp(user, pass);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      endLoading();
    }
  }
}
