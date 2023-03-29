//近くにいる友達のページ

import 'package:flutter/material.dart';
import 'package:zajonc/constants/appbar.dart';
import 'package:zajonc/constants/background_color.dart';

class NearFriendListPage extends StatelessWidget {
  const NearFriendListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NearFriendListAppbar(),
      body: NearFriendListBackgroundColor(),
    );
  }
}
