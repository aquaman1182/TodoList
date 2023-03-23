import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/LoginPage';

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
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
                    TextField(
                      controller: viewModel.titleController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      onChanged: (text) {
                        viewModel.setEmail(text);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: viewModel.authorController,
                      decoration: const InputDecoration(
                        hintText: 'パスワード',
                      ),
                      onChanged:
                      (text) {
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
                          await viewModel.login().then((value) => GoRouter.of(context).go('/todo_list'));
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