// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyModel extends ChangeNotifier {
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
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // ユーザーのメールアドレスを取得
    this.email = user.email;

    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final data = snapshot.data();
    if (data == null) return;

    this.name = data['name'];
    isFetched = true;
    notifyListeners();
  }
}