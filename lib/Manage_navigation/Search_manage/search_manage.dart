import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';

// 検索画面用widget
class Search_manage extends StatelessWidget {
  Search_manage(this.user);
  final User user;
  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: GradientAppBar(
          title: Row(children: [
            Expanded(
                flex: 2,
                child: Container(
                    child: TextField(
                  controller: _controller,
                  autofocus: true,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.transparent)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _controller.clear();
                        },
                        icon: Icon(Icons.clear)),
                    filled: true,
                    fillColor: Colors.white.withAlpha(180),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    hintText: '検索',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ))),
          ]),
          gradient: LinearGradient(colors: [Colors.greenAccent, Colors.yellow]),
        ),
        body: Container(
          child: Column(),
        ),
      ),
    );
  }
}
