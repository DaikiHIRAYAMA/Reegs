//友達かもの表示ページ

import 'package:flutter/material.dart';
import 'package:zajonc/constants/appbar.dart';
import 'package:zajonc/views/friendsListPage.dart';

class maybeFriendListPage extends StatelessWidget {
  const maybeFriendListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: 'Maybe Friend List',
          backgroundColor: Color.fromARGB(255, 235, 60, 255),
          textColor: Colors.black,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 235, 60, 255),
                Color.fromARGB(255, 235, 120, 255),
                Color.fromARGB(255, 235, 180, 255),
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
              child: const Text('page3'),
            ),
          ),
        ));
  }
}
