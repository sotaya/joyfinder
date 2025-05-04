import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'account.dart';
import 'login.dart';

// アドレス登録画面
class RegistPage extends StatefulWidget {
  @override
  _RegistPageState createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  // メッセージ表示用
  String infoText = '';
  // 入力したメールアドレス・パスワード
  String email = '';
  String password = '';
  String repassword = '';
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
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード(確認用)'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    repassword = value;
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
              Container(
                width: double.infinity,
                // ユーザー登録ボタン
                child: ElevatedButton(
                  child: Text('ユーザー登録'),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      foregroundColor: Colors.white),
                  onPressed: () async {
                    if (email.isNotEmpty &&
                        password.isNotEmpty &&
                        repassword.isNotEmpty) {
                      if (password == repassword) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AccountPage(email, password)));
                      } else {
                        setState(() {
                          infoText = "パスワードが一致しません";
                        });
                      }
                    } else {
                      setState(() {
                        infoText = "パスワードを入力してください";
                      });
                    }
                  },
                ),
              ),
              Container(
                // ユーザー登録ボタン
                child: TextButton(
                  child: Text(
                    '戻る',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
