//近くにいる友達のページ

import 'package:flutter/material.dart';
import 'package:zajonc/constants/appbar.dart';
import 'package:zajonc/views/friends_list_page.dart';

class NearFriendListPage extends StatelessWidget {
  const NearFriendListPage({Key? key}) : super(key: key);

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
                            const FriendListPage())); //ここに作成したルートを書いてデバッグできる
              },
              child: const Text('page2'),
            ))));
  }
}
