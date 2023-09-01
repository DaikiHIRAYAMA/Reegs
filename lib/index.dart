import 'package:flutter/material.dart';
// import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:reegs/views/friends/friend_detail_page.dart';
import 'package:reegs/views/friends/friends_list_page.dart';
import 'package:reegs/views/profiles/profile_edit_page.dart';
import 'package:reegs/views/profiles/profile_page.dart';
import 'views/friends/qr_scan_page.dart';
import 'views/profiles/profile_QR_page.dart';

class LiquidSwipeViews extends StatelessWidget {
  //スワイプエフェクト
  LiquidSwipeViews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: const MaterialApp(
          title: 'Flutter Demo',
          home: MyStatefulWidget(
            userId: '',
          ),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  final String userId;
  const MyStatefulWidget({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static final _screens = [
    MyProfilePage(),
    const FriendListPage(),
    MyProfileQRPage(userId: ""),
    const MyProfileEditPage(),
    const FriendDetailPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'EGO'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Friends'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'QR'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Notions'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
