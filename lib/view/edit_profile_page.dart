import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/viewmodels/edit_profile_view_model.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  static const routeName = '/EditProfilePage';
  final String name;

  EditProfilePage(this.name);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditProfileViewModel>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('プロフィール編集'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: viewModel.nameController,
                  decoration: const InputDecoration(
                    hintText: '名前',
                  ),
                  onChanged: (text) {
                    viewModel.setName(text);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: viewModel.isUpdated()
                      ? () {
                          // 追加の処理
                          viewModel.update();
                          context.go("/my_page");
                        }
                      : null,
                  child: const Text('更新する'),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
