import 'package:flutter/material.dart';
import 'package:reegs/constants/appbar.dart';
import 'package:reegs/constants/background_color.dart';
import 'package:reegs/views/friends/friends_list_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: unused_element
class FriendListState extends State<FriendListPage> {
  List<Widget> list = [];

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: const FriendListAppbar(),
      body: const FriendListBackgroundColor(),
    );
  }
}
