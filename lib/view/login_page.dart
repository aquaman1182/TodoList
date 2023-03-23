import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/models/login_auth_repository.dart';
import 'package:gonput_2/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/LoginPage';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(authRepository: AuthRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ログイン'),
        ),
        body: Center(
          child: Consumer<LoginViewModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: model.titleController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        onChanged: (text) {
                          model.setEmail(text);
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: model.authorController,
                        decoration: const InputDecoration(
                          hintText: 'パスワード',
                        ),
                        onChanged:
                        (text) {
                          model.setPassword(text);
                        },
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          model.startLoading();

                          // 追加の処理
                          try {
                            await model.login().then((value) => GoRouter.of(context).go('/todo_list'));
                          } catch (e) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } finally {
                            model.endLoading();
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
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

