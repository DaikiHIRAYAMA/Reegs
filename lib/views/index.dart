//My Appの設定
//ナビゲーションバーの設定
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:zajonc/views/friend_detail_page.dart';
// import 'package:zajonc/constants/splashscreen.dart';
// import 'package:zajonc/views/accout_page.dart';
import 'package:zajonc/views/friends_list_page.dart';
import 'package:zajonc/views/profile_edit_page.dart';
// import 'package:zajonc/views/login_page.dart';
import 'package:zajonc/views/profile_page.dart';
import 'package:zajonc/views/near_friends_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LiquidSwipeViews(),
    );
  }
}

class LiquidSwipeViews extends StatelessWidget {
  //スワイプエフェクト
  const LiquidSwipeViews({Key? key}) : super(key: key);

  static List<Widget> pages = <Widget>[
    //スワイプ先
    Container(
      child: const FriendListPage(), //ここでページ指定
    ),
    Container(
      child: const NearFriendListPage(),
    ),
    Container(
      child: const FriendDetailPage(),
    ),
    Container(
        child: PageView(
      scrollDirection: Axis.vertical,
      children: const [
        MyProfilePage(),
        MyProfileEditPage(),
      ],
    )),
  ];

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      body: LiquidSwipe.builder(
        initialPage: 0, //友達一覧の表示
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          return pages[index];
        },

        enableLoop: true, //ループ許可
      ),
    );
  }
}
