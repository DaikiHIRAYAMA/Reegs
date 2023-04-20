// MBTIによる分類

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:reegs/views/login/login_page.dart';

class AcquiredPage extends StatefulWidget {
  @override
  _AcquiredPage createState() => _AcquiredPage();
}

enum Question1 { test1, test2, test3, test4 }

class _AcquiredPage extends State<AcquiredPage> {
  Question1 _quiestion1 = Question1.test1;
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
        title: const Text('Acquired'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(width: 200, height: 50),
          RadioListTile(
            value: Question1.test1,
            groupValue: _quiestion1,
            onChanged: ((value) => _selectedQuestion(value)),
          ),
          RadioListTile(
            value: Question1.test2,
            groupValue: _quiestion1,
            onChanged: ((value) => _selectedQuestion(value)),
          ),
          RadioListTile(
            value: Question1.test3,
            groupValue: _quiestion1,
            onChanged: ((value) => _selectedQuestion(value)),
          ),
          RadioListTile(
            value: Question1.test4,
            groupValue: _quiestion1,
            onChanged: ((value) => _selectedQuestion(value)),
          ),
        ],
      )),
    );
  }

  _selectedQuestion(value) {
    setState(() {
      _quiestion1 = value;
    });
  }
}
