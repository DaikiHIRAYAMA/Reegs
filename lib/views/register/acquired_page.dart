// MBTIによる分類

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:reegs/views/login/login_page.dart';

class AcquiredPage extends StatefulWidget {
  @override
  _AcquiredPage createState() => _AcquiredPage();
}

enum Question1 { test1, test2 }

class _AcquiredPage extends State<AcquiredPage> {
  Question1? _question1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                // ログアウトするボタン.
                await Supabase.instance.client.auth.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout)),
        ],
        title: const Text('Question1'),
      ),
      backgroundColor: const Color.fromRGBO(255, 244, 213, 1),
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'koko ni shitsumon ga hairuyo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 200, height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: RadioListTile(
                    value: Question1.test1,
                    groupValue: _question1,
                    onChanged: ((value) =>
                        _selectedQuestion(value as Question1)),
                    title: const Text('select A'),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: RadioListTile(
                    value: Question1.test2,
                    groupValue: _question1,
                    onChanged: ((value) =>
                        _selectedQuestion(value as Question1)),
                    title: const Text('select B'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _selectedQuestion(Question1? value) {
    setState(() {
      _question1 = value;
    });
    Navigator.pushNamed(context, '/acquired');
  }
}
