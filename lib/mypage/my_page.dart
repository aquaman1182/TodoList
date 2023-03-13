import 'package:flutter/material.dart';
import 'package:gonput_2/edit_profile/edit_profile_page.dart';
import 'package:gonput_2/mypage/my_model.dart';
import 'package:provider/provider.dart';

import '../login/login_page.dart';

class MyPage extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
       create: (_) => MyModel()..fetchUser(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("MyPage"),
           actions: [
             Consumer<MyModel>(builder: (context, model, child) {
             return IconButton(
              onPressed: () async{
                await Navigator.push(
                 context,
                 MaterialPageRoute(
                      builder: (context) =>
                           EditProfilePage(model.name ?? ""), 
                    ),
                );
                model.fetchUser();
               }, 
             icon: const Icon(Icons.edit),
          );
         })
       ]
      ),
        body: Center(
          child: Consumer<MyModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column( children: [
                      Text(
                      model.name ?? "名前なし",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      Text(
                         model.email ?? "メールアドレスなし",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                  ],),
                ),
                if (model.isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            );
  }),
        
          ),
      ),
    );
  }
}