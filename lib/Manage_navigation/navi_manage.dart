import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Search_manage/search_manage.dart';
import 'Mypage_manage/mypage_manage.dart';
import 'Subhome_manage/subhome_manage.dart';
import 'Home_manage/home_manage.dart';

// ナビゲーション用Widget
class HomePage_manage extends StatefulWidget {
  HomePage_manage(this.user);
  final User user;
  @override
  State<HomePage_manage> createState() => _HomePageState_manage(user);
}

class _HomePageState_manage extends State<HomePage_manage> {
  // 引数からユーザー情報を受け取れるようにする
  _HomePageState_manage(this.user);
  // ユーザー情報
  final User user;

  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen_manage(user),
      Search_manage(user),
      HistoryScreen_manage(user),
      MypageScreen_manage(user)
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: Colors.white),
              activeIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, color: Colors.white),
              activeIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: '検索',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.event_available_outlined,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.event_available,
                color: Colors.white,
              ),
              label: '開催イベント',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: 'マイページ',
            ),
          ],
          selectedIconTheme: const IconThemeData(size: 30),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
        ),
      ),
    );
  }
}
