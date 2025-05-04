import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:joyfinder/main.dart';

//マイアカウント画面用Widget
class MyaccountManage extends StatelessWidget {
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
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('設定'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.person_outline),
                title: const Text('アカウント設定'),
                onPressed: (context) {},
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.remove_circle_outline),
                title: const Text('アカウント削除'),
                onPressed: (context) {},
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.logout),
                title: const Text('ログアウト'),
                onPressed: (context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.help_outline),
                title: const Text('お問い合わせ'),
                onPressed: (context) {},
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
