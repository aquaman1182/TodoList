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
    return Scaffold(
        appBar: AppBar(
          title: const Text('プロフィール編集'),
        ),
        body: Center(
          child: Consumer<EditProfileViewModel>(
            builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: model.nameController,
                      decoration: const InputDecoration(
                        hintText: '名前',
                      ),
                      onChanged: (text) {
                        model.setName(text);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: model.isUpdated()
                          ? () {
                              // 追加の処理
                              model.update();
                              context.go("/my_page");
                            }
                          : null,
                      child: const Text('更新する'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
    );
  }
}