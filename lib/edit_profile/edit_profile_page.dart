
import 'package:flutter/material.dart';
import 'package:gonput_2/edit_profile/edit_profile_model.dart';
import 'package:provider/provider.dart';


class EditProfilePage extends StatelessWidget {
    EditProfilePage(this.name);
  final String name;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileModel>(
      create: (_) => EditProfileModel(
        name,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('プロフィール編集'),
        ),
        body: Center(
          child: Consumer<EditProfileModel>(builder: (context, model, child) {
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
                        ? (){
                              // 追加の処理
                              model.update();
                              Navigator.of(context).pop();
                            } 
                        : null,
                    child: const Text('更新する'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}