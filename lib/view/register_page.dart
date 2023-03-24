import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/viewmodels/register_view_model.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      controller: registerViewModel.titleController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        border: OutlineInputBorder(), // 外枠付きデザイン
                        filled: true, // fillColorで指定した色で塗り潰し
                        hintText: 'Email',
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
                        registerViewModel.setEmail(text);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: registerViewModel.authorController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.key),
                        border: OutlineInputBorder(), // 外枠付きデザイン
                        filled: true, // fillColorで指定した色で塗り潰し
                        hintText: 'パスワード',
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
                        registerViewModel.setPassword(text);
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
                          await registerViewModel.signUp();
                          context.go("/");
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
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
