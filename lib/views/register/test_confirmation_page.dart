import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TestConfirmationPage extends StatelessWidget {
  TestConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るを非表示
        backgroundColor: Colors.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/splashes/splash.png',
            ), // ここに画像パスを設定
            const Text(
              '(全140問)',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              ' ① 2択質問 × 140問 \n（推定最大所要時間：18分）です \n\n ② できるだけ中断せず回答しきってください。\n\n ③ 深く悩まず直感的に答えを選んでください。',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold, // テキストを太字に
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 100),
            const Text(
              '「わからない場合」や「どちらにも当てはまらない場合」\n問題をスキップできますが、スキップ数が多い場合\n正確な解析ができないことがあります。',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fixedSize: const Size.fromWidth(200),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor: Colors.grey, // グレーの色を指定
              ),
              onPressed: () {
                completeDiagnosis('profile_complete').then((_) {
                  Navigator.pushNamed(context, '/acquired');
                });
              },
              child: const Center(
                child: Text(
                  'はじめる',
                  textAlign: TextAlign.center, // テキストをボタンの中央に配置
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // テキストを太字に
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> completeDiagnosis(String diagnosisKey) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    if (userId == null) {
      // ユーザーIDがnullの場合の処理（エラーメッセージの表示など）
      return;
    }

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      return await users.doc(userId).update({'profile_complete': true});
    } catch (e) {
      // エラーが発生した場合の処理（エラーメッセージの表示など）
    }
  }
}
