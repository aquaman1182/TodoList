import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/view/components/bottom_navigation.dart';
import 'package:gonput_2/viewmodels/my_view_model.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  static const routeName = '/MyPage';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? '';

    return ChangeNotifierProvider<MyViewModel>(
      create: (_) {
        final viewModel = MyViewModel();
        viewModel.fetchUser();
        return viewModel;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('マイページ'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                context.go("/edit_profile_page/:name");
              },
            ),
          ],
        ),
        body: Center(
          child: Consumer<MyViewModel>(
            builder: (context, model, child) {
              if (!model.isFetched) {
                return const CircularProgressIndicator();
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      model.name ?? '名無しの権兵衛',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
      ),
    );
  }
}
