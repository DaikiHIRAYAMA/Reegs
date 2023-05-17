import 'package:flutter/material.dart';
import 'package:reegs/constants/appbar.dart';
import 'package:reegs/constants/background_color.dart';

class MyProfileEdit extends StatelessWidget {
  const MyProfileEdit({super.key});

  @override
  Widget build(Object context) {
    return const Scaffold(
      appBar: ProfileEditAppbar(),
      body: ProfileEditBackgroundColor(),
    );
  }
}
