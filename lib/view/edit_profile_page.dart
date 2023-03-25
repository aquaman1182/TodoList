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
    final EditProfileViewModel editProfileViewModel = context.read();
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
                  autovalidateMode: AutovalidateMode.disabled, autofocus: true,
                  controller: editProfileViewModel.nameController,
                  decoration: const InputDecoration(
                    labelText: "Enter your name",
                    hintText: '名前',
                  ),
                  validator: (value) { // _formKey.currentState.validate()でコールされる
                    if (value!.isEmpty) {
                      return 'Please enter some text'; // エラー表示のメッセージを返す
                    }
                    return null; // 問題ない場合はnullを返す
                  }, 
                  onSaved: (value) => () { // this._formKey.currentState.save()でコールされる
                    print('$value');
                  },
                  onChanged: (text) {
                    editProfileViewModel.setName(text);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: editProfileViewModel.isUpdated()
                      ? () {
                          // 追加の処理
                          editProfileViewModel.updateProfile();
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
