import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Start'),
        automaticallyImplyLeading: false, // 戻るを非表示
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'これからあなたをもっと深く知るため \n 140質問を行います。 \n 最大10分程度かかります。',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await completeDiagnosis('profile_complete');
                Navigator.pushNamed(context, '/acquired');
              },
              child: const Text('はじめる'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> completeDiagnosis(String diagnosisKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(diagnosisKey, true);
  }
}
