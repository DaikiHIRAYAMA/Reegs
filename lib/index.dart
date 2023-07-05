import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:reegs/constants/splash.dart';
import 'package:reegs/views/friends/friends_list_page.dart';
import 'package:reegs/views/login/login_page.dart';
import 'package:reegs/views/friends/near_friends_list_page.dart';
import 'package:reegs/views/profiles/profile_edit_page.dart';
import 'package:reegs/views/profiles/profile_page.dart';
import 'package:reegs/views/register/acquired_page.dart';
import 'package:reegs/views/register/innate_page.dart';
import 'package:reegs/views/register/siblings_page.dart';

import 'view_models/register/acquired_viewmodel.dart';

class LiquidSwipeViews extends StatelessWidget {
  //スワイプエフェクト
  const LiquidSwipeViews({Key? key}) : super(key: key);

  static List<Widget> pages = <Widget>[
    //スワイプ先
    Container(
      child: SiblingsPage(), //ここでページ指定
    ),
    Container(
      child: InnatePage(),
    ),
    Container(
      child: AcquiredPage(question: Question.q1),
    ),
    Container(
        child: PageView(
      scrollDirection: Axis.vertical,
      children: [
        MyProfilePage(),
        const MyProfileEditPage(),
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
