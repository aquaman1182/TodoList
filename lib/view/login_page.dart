import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/LoginPage';

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = context.read();
    final emailController = TextEditingController();
    final passController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
      ),
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      border: OutlineInputBorder(), // 外枠付きデザイン
                      filled: true, // fillColorで指定した色で塗り潰し
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      // _formKey.currentState.validate()でコールされる
                      if (value!.isEmpty) {
                        return 'Please enter some text'; // エラー表示のメッセージを返す
                      }
                      return null; // 問題ない場合はnullを返す
                    },
                    onSaved: (value) => () {
                      // this._formKey.currentState.save()でコールされる
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
                      border: OutlineInputBorder(), // 外枠付きデザイン
                      filled: true, // fillColorで指定した色で塗り潰し
                      hintText: 'パスワード',
                    ),
                    validator: (value) {
                      // _formKey.currentState.validate()でコールされる
                      if (value!.isEmpty) {
                        return 'Please enter some text'; // エラー表示のメッセージを返す
                      }
                      return null; // 問題ない場合はnullを返す
                    },
                    onSaved: (value) => () {
                      // this._formKey.currentState.save()でコールされる
                      print('$value');
                    },
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      loginViewModel.startLoading();
                      // 追加の処理
                      try {
                        await loginViewModel.login(
                            emailController.text, passController.text);
                        GoRouter.of(context).go('/todo_list');
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } finally {
                        loginViewModel.endLoading();
                      }
                    },
                    child: const Text('ログイン'),
                  ),
                  TextButton(
                    onPressed: () {
                      // 画面遷移
                      context.go("/register");
                    },
                    child: const Text('新規登録の方はこちら'),
                  ),
                ],
              ),
            ),
            if (loginViewModel.isLoading)
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
