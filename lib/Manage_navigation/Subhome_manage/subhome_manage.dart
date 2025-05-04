import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joyfinder/Manage_navigation/Subhome_manage/add_event.dart';

//サブホーム画面用Widget
class HistoryScreen_manage extends StatelessWidget {
  HistoryScreen_manage(this.user);
  final User user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: GradientAppBar(
        title: Center(
            child: Text(
          'イベントスケジュール',
          style: GoogleFonts.abyssinicaSil(color: Colors.black),
        )),
        gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.yellow],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
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
                        MaterialPageRoute(builder: (context) => AddEvent(user)),
                      );
                    },
                    icon: Icon(Icons.add_circle),
                    iconSize: 40))
          ],
        ),
      ),
    ));
  }
}
