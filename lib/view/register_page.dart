import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/viewmodels/register_view_model.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final passController = TextEditingController();
    final RegisterViewModel registerViewModel = context.read();
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              context.go("/");
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      border: OutlineInputBorder(), // 外枠付きデザイン
                      filled: true, // fillColorで指定した色で塗り潰し
                      hintText: 'Email',
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
                  TextFormField(
                    controller: passController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.key),
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'パスワード',
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
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      registerViewModel.startLoading();

                      // 追加の処理
                      try {
                        await registerViewModel.signUp(
                            nameController.text, passController.text);
                        context.go("/");
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } finally {
                        registerViewModel.endLoading();
                      }
                    },
                    child: const Text('登録する'),
                  ),
                ],
              ),
            ),
            if (registerViewModel.isLoading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
