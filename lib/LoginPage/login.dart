import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joyfinder/Manage_navigation/navi_manage.dart';
import 'package:joyfinder/Participate_navigation/navi_partici.dart';

import 'regist.dart';

// ログイン画面用Widget
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // メッセージ表示用
  String infoText = '';
  // 入力したメールアドレス・パスワード
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.greenAccent, Colors.yellow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('JoyFinder',
                  style: GoogleFonts.abyssinicaSil(
                      textStyle: TextStyle(color: Colors.white, fontSize: 40))),
              Container(
                padding: EdgeInsets.all(10),
              ),
              // メールアドレス入力
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              // パスワード入力
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                padding: EdgeInsets.all(8),
                // メッセージ表示
                child: Text(
                  infoText,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                // ログイン登録ボタン
                child: OutlinedButton(
                  child: Text('ログイン'),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      foregroundColor: Colors.white),
                  onPressed: () async {
                    try {
                      // メール/パスワードでログイン
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      final account_names = await FirebaseFirestore.instance
                          .collection('data')
                          .doc(email)
                          .get();
                      String account_name = account_names.get('objective');
                      if (account_name == '参加者') {
                        // ログインに成功した場合
                        // チャット画面に遷移＋ログイン画面を破棄
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return HomePage_partici(result.user!);
                          }),
                        );
                      } else {
                        // ログインに成功した場合
                        // チャット画面に遷移＋ログイン画面を破棄
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return HomePage_manage(result.user!);
                          }),
                        );
                      }
                    } catch (e) {
                      // ログインに失敗した場合
                      setState(() {
                        infoText = "正しく入力されていません";
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 4),
              TextButton(
                  child: Text('アカウント未登録の方へ'),
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      textStyle:
                          TextStyle(decoration: TextDecoration.underline)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegistPage()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
