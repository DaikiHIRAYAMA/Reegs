import 'package:flutter/material.dart';
import 'package:reegs/constants/appbar.dart';
import 'package:reegs/constants/background_color.dart';

class NearFriendList extends StatelessWidget {
  const NearFriendList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: NearFriendListAppbar(),
      body: NearFriendListBackgroundColor(),
    );
  }
}
