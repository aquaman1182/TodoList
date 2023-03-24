import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/firebase_options.dart';
import 'package:gonput_2/router/router.dart';
import 'package:provider/provider.dart';
import 'package:gonput_2/di/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final goRouter = createGoRouter(); // 追加: goRouterを作成
  runApp(MultiProvider(providers: globalProviders, child: MyApp(goRouter: goRouter)));
}

class MyApp extends StatelessWidget {
  final GoRouter goRouter; // 追加: goRouterのフィールド

  MyApp({required this.goRouter}); // 追加: goRouterをコンストラクタで受け取る

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TodoListApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //下記を追加すると動いた
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}
