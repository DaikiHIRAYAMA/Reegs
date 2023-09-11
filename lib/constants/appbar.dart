import 'package:flutter/material.dart';
import 'package:reegs/constants/progressbar.dart';

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
      super.backgroundColor = const Color.fromARGB(245, 238, 227, 255),
      super.textColor = Colors.black,
      required List<IconButton> actions});
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
      super.backgroundColor = const Color.fromARGB(245, 238, 227, 255),
      super.textColor = Colors.black});
}

//質問回答
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final int totalQuestions;

  CustomAppBar({
    required this.currentIndex,
    required this.totalQuestions,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget buildAppBarTitle(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/assets/images/splashes/splash.png'),
          SizedBox(height: screenSize.height * 0.02),
          LinearProgressBar(
            progress: ((currentIndex + 1) / totalQuestions),
          ),
          Text(
            '${currentIndex + 1}/$totalQuestions',
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.white,
      title: buildAppBarTitle(context),
      actions: [Container(width: screenSize.width * 0.125)],
    );
  }
}
