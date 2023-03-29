import 'package:flutter/material.dart';
import 'package:zajonc/constants/appbar.dart';
import 'package:zajonc/constants/background_color.dart';

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
