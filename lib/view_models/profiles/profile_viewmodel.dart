import 'package:flutter/material.dart';
import 'package:reegs/constants/appbar.dart';
import 'package:reegs/constants/background_color.dart';

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
