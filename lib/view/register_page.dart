import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/viewmodels/register_view_model.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterViewModel>();
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
                      controller: viewModel.titleController,
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
                        viewModel.setEmail(text);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: viewModel.authorController,
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
                        viewModel.setPassword(text);
                      },
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        viewModel.startLoading();

                        // 追加の処理
                        try {
                          await viewModel.signUp();
                          context.go("/");
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        } finally {
                          viewModel.endLoading();
                        }
                      },
                      child: const Text('登録する'),
                    ),
                  ],
                ),
              ),
              if (viewModel.isLoading)
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
