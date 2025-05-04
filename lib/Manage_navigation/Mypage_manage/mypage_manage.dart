import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joyfinder/Manage_navigation/Mypage_manage/myaccount_manage.dart';

//マイページ画面用Widget
class MypageScreen_manage extends StatelessWidget {
  MypageScreen_manage(this.user);
  final User user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: GradientAppBar(
        title: Center(
          child: Text(
            'サブスクリプション',
            style: GoogleFonts.abyssinicaSil(color: Colors.black),
          ),
        ),
        gradient: LinearGradient(colors: [Colors.greenAccent, Colors.yellow]),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyaccountManage()),
                      );
                    },
                    icon: Icon(Icons.account_circle),
                    iconSize: 40))
          ],
        ),
      ),
    ));
  }
}
