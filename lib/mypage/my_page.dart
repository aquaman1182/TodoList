import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gonput_2/edit_profile/edit_profile_page.dart';
import 'package:gonput_2/mypage/my_model.dart';
import 'package:gonput_2/todo_list/todo_list.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  static const routeName = '/MyPage';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? '';

    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel()..fetchUser(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('マイページ'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                final name = Provider.of<MyModel>(context, listen: false).name ?? "";
                Navigator.of(context).pushNamed(
                  EditProfilePage.routeName,
                  arguments: name,
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Consumer<MyModel>(
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
                      model.name ?? '',
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          onTap: (index) {
            switch (index) {
              case 0:
              Navigator.pushNamed(
                  context,
                  TodoListPage.routeName,
                );
                break;
              case 1:
                break;
              
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "TodoList"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "MyPage"
            ),
            
          ],
        ),
      ),
    );
  }
}