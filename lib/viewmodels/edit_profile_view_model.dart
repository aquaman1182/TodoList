import 'package:flutter/material.dart';
import 'package:gonput_2/models/edit_profile_repository.dart';

class EditProfileViewModel extends ChangeNotifier {
  final EditProfileRepository _editProfileRepository = EditProfileRepository();

  EditProfileViewModel() {
    nameController.text = name ?? "";
  }

  final nameController = TextEditingController();

  String? name;

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  bool isUpdated() {
    return name != null;
  }

  Future<void> update() async {
    name = nameController.text;
    await _editProfileRepository.update(name!);
  }
}
