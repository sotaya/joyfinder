import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'LoginPage/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: 'JoyFinder',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.green,
      ),
      // ログイン画面を表示
      home: LoginPage(),
    );
  }
}
