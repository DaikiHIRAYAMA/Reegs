import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:reegs/views/friends/friend_detail_page.dart';
import 'package:reegs/views/friends/friends_list_page.dart';
import 'package:reegs/views/profiles/profile_edit_page.dart';
import 'package:reegs/views/profiles/profile_page.dart';
import 'views/friends/qr_scan_page.dart';

class LiquidSwipeViews extends StatelessWidget {
  //スワイプエフェクト
  LiquidSwipeViews({Key? key}) : super(key: key);

  final myProfileController = PageController(initialPage: 0); // 0-indexed
  final friendListController = PageController(initialPage: 1); // 0-indexed
  final qrScanController = PageController(initialPage: 0); // 0-indexed

  List<Widget> get pages {
    return <Widget>[
      //スワイプ先
      PageView(
        controller: myProfileController,
        scrollDirection: Axis.vertical,
        children: [
          MyProfilePage(),
          const MyProfileEditPage(),
        ],
      ),
      PageView(
        controller: friendListController,
        scrollDirection: Axis.vertical,
        children: [
          MyProfilePage(),
          FriendListPage(),
          FriendDetailPage(),
        ],
      ),
      PageView(
        controller: qrScanController,
        scrollDirection: Axis.vertical,
        children: [
          QrScanView(),
          const MyProfileEditPage(),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController();
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
