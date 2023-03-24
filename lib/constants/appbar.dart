import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;

  const MyAppBar({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//Friend List
class FriendListAppbar extends MyAppBar {
  const FriendListAppbar(
      {super.key,
      super.title = 'Your Friend List',
      super.backgroundColor = const Color.fromARGB(235, 60, 235, 235),
      super.textColor = Colors.black});
}

//Near Friend List
class NearFriendListAppbar extends MyAppBar {
  const NearFriendListAppbar(
      {super.key,
      super.title = 'Near Friend List',
      super.backgroundColor = const Color.fromARGB(235, 235, 235, 60),
      super.textColor = Colors.black});
}

//Profile
class ProfileAppbar extends MyAppBar {
  const ProfileAppbar(
      {super.key,
      super.title = 'My Profile',
      super.backgroundColor = const Color.fromARGB(235, 235, 60, 235),
      super.textColor = Colors.black});
}

//Friend Detail
class FriendDetailAppbar extends MyAppBar {
  const FriendDetailAppbar(
      {super.key,
      super.title = 'Friend name', //友達の名前を表示させる
      super.backgroundColor = const Color.fromARGB(235, 150, 235, 150),
      super.textColor = Colors.black});
}

//Profile
class ProfileEditAppbar extends MyAppBar {
  const ProfileEditAppbar(
      {super.key,
      super.title = 'My Profile Edit',
      super.backgroundColor = const Color.fromARGB(235, 235, 180, 235),
      super.textColor = Colors.black});
}
