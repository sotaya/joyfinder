import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

//サブホーム画面用Widget
class HistoryScreen_partici extends StatelessWidget {
  const HistoryScreen_partici({Key? key}) : super(key: key);
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
          children: [Text('終了イベント画面')],
        ),
      ),
    ));
  }
}
