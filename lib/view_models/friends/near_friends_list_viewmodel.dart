import 'package:flutter/material.dart';
import 'package:zajonc/constants/appbar.dart';
import 'package:zajonc/constants/background_color.dart';

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
