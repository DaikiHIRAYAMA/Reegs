import 'package:flutter/material.dart';
import 'package:zajonc/constants/appbar.dart';
import 'package:zajonc/constants/background_color.dart';
import 'package:zajonc/views/friends/friend_detail_page.dart';

// ignore: unused_element
class FriendDetailState extends State<FriendDetailPage> {
  List<Widget> list = [];

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: const FriendDetailAppbar(),
      body: const FriendDetailBackgroundColor(),
    );
  }
}
