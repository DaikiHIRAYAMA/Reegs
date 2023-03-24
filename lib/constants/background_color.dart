//色の設定

import 'package:flutter/material.dart';

class MyBodyColor extends StatelessWidget {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color backgroundColor3;

  const MyBodyColor({
    Key? key,
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.backgroundColor3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            backgroundColor1,
            backgroundColor2,
            backgroundColor3,
          ],
        ),
      ),
    );
  }
}

//Friend List
class FriendListBackgroundColor extends MyBodyColor {
  const FriendListBackgroundColor(
      {super.key,
      super.backgroundColor1 = const Color.fromARGB(235, 60, 235, 235),
      super.backgroundColor2 = const Color.fromARGB(235, 120, 235, 235),
      super.backgroundColor3 = const Color.fromARGB(235, 180, 235, 235)});
}

//Near Friend List
class NearFriendListBackgroundColor extends MyBodyColor {
  const NearFriendListBackgroundColor(
      {super.key,
      super.backgroundColor1 = const Color.fromARGB(235, 235, 235, 60),
      super.backgroundColor2 = const Color.fromARGB(235, 235, 235, 120),
      super.backgroundColor3 = const Color.fromARGB(235, 235, 235, 180)});
}

//Profile
class ProfileBackgroundColor extends MyBodyColor {
  const ProfileBackgroundColor(
      {super.key,
      super.backgroundColor1 = const Color.fromARGB(235, 235, 60, 235),
      super.backgroundColor2 = const Color.fromARGB(235, 235, 120, 235),
      super.backgroundColor3 = const Color.fromARGB(235, 235, 180, 235)});
}

//Friend Detail
class FriendDetailBackgroundColor extends MyBodyColor {
  const FriendDetailBackgroundColor(
      {super.key,
      super.backgroundColor1 = const Color.fromARGB(235, 150, 235, 150),
      super.backgroundColor2 = const Color.fromARGB(235, 180, 235, 180),
      super.backgroundColor3 = const Color.fromARGB(235, 200, 235, 200)});
}

//Profile Edit
class ProfileEditBackgroundColor extends MyBodyColor {
  const ProfileEditBackgroundColor(
      {super.key,
      super.backgroundColor1 = const Color.fromARGB(235, 235, 180, 235),
      super.backgroundColor2 = const Color.fromARGB(235, 235, 120, 235),
      super.backgroundColor3 = const Color.fromARGB(235, 235, 60, 235)});
}
