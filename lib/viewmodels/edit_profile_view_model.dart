import 'package:flutter/material.dart';
import 'package:gonput_2/models/repository/edit_profile_repository.dart';

import '../domain/userdata/userclassdata.dart';

class EditProfileViewModel extends ChangeNotifier {
  final EditProfileRepository editProfileRepository;

  EditProfileViewModel(
      {required this.currentUserData,
      required EditProfileRepository editProfileRepository})
      : editProfileRepository = editProfileRepository;

  final UserClassData currentUserData;

  bool isUpdated(String name) {
    return currentUserData.name != name;
  }

  Future<void> updateProfile(String name) async {
    final updatedUserData = currentUserData.copyWith(name: name);

    await editProfileRepository.update(updatedUserData);
  }
}
