//近くにいる友達のページ

import 'package:flutter/material.dart';
import 'package:reegs/constants/appbar.dart';
import 'package:reegs/constants/background_color.dart';

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
