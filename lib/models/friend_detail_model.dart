import 'package:flutter/material.dart';
import 'package:zajonc/constants/appbar.dart';
import 'package:zajonc/constants/background_color.dart';
import 'package:zajonc/views/friend_detail_page.dart';
import 'package:zajonc/views/friends_list_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
