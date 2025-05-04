import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

// ホーム画面用Widget
class HomeScreen_partici extends StatelessWidget {
  const HomeScreen_partici({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: GradientAppBar(
        title: Row(children: [
          Text(
            'JoyFinder',
            style: GoogleFonts.abyssinicaSil(color: Colors.black),
          ),
        ]),
        gradient: LinearGradient(colors: [Colors.greenAccent, Colors.yellow]),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: [Text('イベント画面')],
        ),
      ),
    ));
  }
}
