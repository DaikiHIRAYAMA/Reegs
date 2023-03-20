//近くにいる友達のページ

import 'package:flutter/material.dart';
import 'package:zajonc/constants/appbar.dart';
import 'package:zajonc/views/friendsListPage.dart';

class nearFriendListPage extends StatelessWidget {
  const nearFriendListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: 'Near Friend List',
          backgroundColor: Color.fromARGB(255, 255, 235, 60),
          textColor: Colors.black,
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 235, 60),
                  Color.fromARGB(255, 255, 235, 120),
                  Color.fromARGB(255, 255, 235, 180),
                ],
              ),
            ),
            child: Center(
                child: ElevatedButton(
              onPressed: () {
                //画面遷移のコード
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            friendListPage())); //ここに作成したルートを書いてデバッグできる
              },
              child: const Text('page2'),
            ))));
  }
}
