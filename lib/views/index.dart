//My Appの設定
//ナビゲーションバーの設定
import 'package:flutter/material.dart';
import 'package:zajonc/models/friendListModel.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:zajonc/views/friendsListPage.dart';
import 'package:zajonc/views/maybeFriendListPage.dart';
import 'package:zajonc/views/nearFriendListPage.dart';

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
      child: const friendListPage(), //ここでページ指定
    ),
    Container(
      child: const nearFriendListPage(),
    ),
    Container(
      child: const maybeFriendListPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
