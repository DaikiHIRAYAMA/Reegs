import 'package:flutter/material.dart';
import 'package:zajonc/constants/appbar.dart';
import 'package:zajonc/constants/background_color.dart';
import 'package:zajonc/views/friends_list_page.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ProfileAppbar(),
      body: ProfileBackgroundColor(),
    );
  }
}
