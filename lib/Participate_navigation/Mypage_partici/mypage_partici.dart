import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joyfinder/Participate_navigation/Mypage_partici/myaccount_partici.dart';

//マイページ画面用Widget
class MypageScreen_partici extends StatelessWidget {
  const MypageScreen_partici({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: GradientAppBar(
        title: Center(
            child: Text(
          'サブスクリプション',
          style: GoogleFonts.abyssinicaSil(color: Colors.black),
        )),
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
                            builder: (context) => MyaccountPartici()),
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
