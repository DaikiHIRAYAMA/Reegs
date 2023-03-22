//友達一覧のページ

import 'package:flutter/material.dart';
import 'package:zajonc/constants/appbar.dart';
import 'package:zajonc/views/near_friends_list_page.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: 'Your Friend List',
          backgroundColor: Color.fromARGB(235, 60, 255, 255),
          textColor: Colors.black,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(235, 60, 255, 255),
                Color.fromARGB(235, 120, 255, 255),
                Color.fromARGB(235, 180, 255, 255),
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
                        const NearFriendListPage()), //ここに作成したルートを書いてデバッグできる
              );
            },
            child: const Text('page1'),
          )),
        ));
  }
}
