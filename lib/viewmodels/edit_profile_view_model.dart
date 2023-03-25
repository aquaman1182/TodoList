import 'package:flutter/material.dart';
import 'package:gonput_2/models/repository/edit_profile_repository.dart';

import '../domain/userdata/userclassdata.dart';

class EditProfileViewModel extends ChangeNotifier {
  final EditProfileRepository _editProfileRepository;

  EditProfileViewModel({required this.currentUserData, required EditProfileRepository editProfileRepository})
      : _editProfileRepository = editProfileRepository {
    nameController.text = currentUserData.name;
  }

  final nameController = TextEditingController();
  
  String? name;
  final UserClassData currentUserData;

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  bool isUpdated() {
    return name != null;
  }

  Future<void> updateProfile() async {
    name = nameController.text;

    // 新しい UserClassData オブジェクトを作成
    final updatedUserData = currentUserData.copyWith(name: name ?? "");

    await _editProfileRepository.update(updatedUserData);
  }
}
