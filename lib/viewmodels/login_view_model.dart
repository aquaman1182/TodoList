import 'package:flutter/material.dart';
import 'package:gonput_2/models/repository/login_auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final AuthRepository _authRepository;

  LoginViewModel({required AuthRepository authRepository}) : _authRepository = authRepository;

  String? email;
  String? password;
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
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future<String?> login() async {
    startLoading();
    try {
      await _authRepository.login(email!, password!);
      endLoading();
      return null; // 認証成功時は null を返す
    } catch (e) {
      endLoading();
      return e.toString(); // エラーが発生した場合はエラーメッセージを返す
    }
  }
}
