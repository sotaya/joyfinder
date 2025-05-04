import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joyfinder/main.dart';

//マイアカウント画面用Widget
class MyaccountPartici extends StatelessWidget {
  const MyaccountPartici({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: GradientAppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Center(
            child: Text(
          'マイアカウント',
          style: GoogleFonts.abyssinicaSil(color: Colors.black),
        )),
        gradient: LinearGradient(colors: [Colors.greenAccent, Colors.yellow]),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('アカウント名'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('アカウント削除'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('ログアウト'),
              onTap: () async {
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return MyApp();
                  }),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('お問い合わせ'),
              onTap: () {},
            ),
            Divider()
          ],
        ),
      ),
    ));
  }
}
