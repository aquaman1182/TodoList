import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/viewmodels/edit_profile_view_model.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  static const routeName = '/EditProfilePage';

  @override
  Widget build(BuildContext context) {
    final EditProfileViewModel editProfileViewModel = context.read();
    final nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール編集'),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              context.go("/my_page");
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Enter your name",
                  hintText: '名前',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => () {
                  print('$value');
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  if (editProfileViewModel.isUpdated(nameController.text)) {
                    editProfileViewModel.updateProfile(nameController.text);
                    context.go("/my_page");
                  }
                },
                child: const Text('更新する'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
