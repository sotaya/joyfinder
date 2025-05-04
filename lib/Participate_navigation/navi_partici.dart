import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Search_partici/search_partici.dart';
import 'Mypage_partici/mypage_partici.dart';
import 'Subhome_partici/subhome_partici.dart';
import 'home_partici/home_partici.dart';

// ナビゲーション用Widget
class HomePage_partici extends StatefulWidget {
  HomePage_partici(this.user);
  final User user;
  @override
  State<HomePage_partici> createState() => _HomePageState_partici(user);
}

class _HomePageState_partici extends State<HomePage_partici> {
  // 引数からユーザー情報を受け取れるようにする
  _HomePageState_partici(this.user);
  // ユーザー情報
  final User user;

  int _selectedIndex = 0;

  static const _screens = [
    HomeScreen_partici(),
    Search_partici(),
    HistoryScreen_partici(),
    MypageScreen_partici()
  ];

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
