import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/view/components/bottom_navigation.dart';
import 'package:gonput_2/viewmodels/my_view_model.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  static const routeName = '/MyPage';

  @override
  Widget build(BuildContext context) {
    final MyViewModel myViewModel = context.read();
    myViewModel.fetchUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              context.go("/edit_profile_page/:name");
              await myViewModel.fetchUser();
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
            //test
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    model.user?.name ?? '名無しの権兵衛',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    model.user?.email ?? '',
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
    );
  }
}
