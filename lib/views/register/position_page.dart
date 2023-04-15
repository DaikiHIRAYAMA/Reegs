//兄弟構成

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zajonc/constants/snackbar.dart';

class PositionPage extends StatefulWidget {
  @override
  _PositionPageState createState() => _PositionPageState();
}

enum PositionValue { Eldest, Middle, Youngest, Only }

extension PositionValueExtension on PositionValue {
  int toInt() {
    switch (this) {
      case PositionValue.Eldest:
        return 0;
      case PositionValue.Middle:
        return 1;
      case PositionValue.Youngest:
        return 2;
      case PositionValue.Only:
        return 3;
      default:
        throw Exception('Unknown position value');
    }
  }
}

class _PositionPageState extends State<PositionPage> {
  PositionValue _positionValue = PositionValue.Eldest;
  var _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Position'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Card(
              // color: Colors.black12,
              child: Column(children: [
                RadioListTile(
                  title: const Text('Eldest'),
                  value: PositionValue.Eldest,
                  groupValue: _positionValue,
                  onChanged: (value) => _onRadioSelected(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person, size: 48, color: Colors.red),
                    Icon(Icons.person, size: 36, color: Colors.black),
                    Icon(Icons.person, size: 30, color: Colors.black),
                  ],
                ),
              ]),
            ),
            Card(
              child: Column(children: [
                RadioListTile(
                  title: const Text('Middle'),
                  value: PositionValue.Middle,
                  groupValue: _positionValue,
                  onChanged: (value) => _onRadioSelected(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person, size: 48, color: Colors.black),
                    Icon(Icons.person, size: 36, color: Colors.red),
                    Icon(Icons.person, size: 30, color: Colors.black),
                  ],
                ),
              ]),
            ),
            Card(
              child: Column(children: [
                RadioListTile(
                  title: const Text('Youngest'),
                  value: PositionValue.Youngest,
                  groupValue: _positionValue,
                  onChanged: (value) => _onRadioSelected(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person, size: 48, color: Colors.black),
                    Icon(Icons.person, size: 36, color: Colors.black),
                    Icon(Icons.person, size: 30, color: Colors.red),
                  ],
                ),
              ]),
            ),
            Card(
              child: Column(children: [
                RadioListTile(
                  title: const Text('Only'),
                  value: PositionValue.Only,
                  groupValue: _positionValue,
                  onChanged: (value) => _onRadioSelected(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person, size: 48, color: Colors.red),
                  ],
                ),
              ]),
            ),
            ElevatedButton(
                onPressed: () {
                  _registerPosition();
                  Navigator.pushNamed(context, '/acquired');
                },
                child: const Text('NEXT'))
          ],
        ),
      ),
    );
  }

  void _onRadioSelected(value) {
    setState(() {
      _positionValue = value;
    });
  }

  Future<void> _registerPosition() async {
    setState(() {
      _loading = true;
    });
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'position': _positionValue.toInt(),
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await supabase.from('characters').upsert(updates);
      if (mounted) {
        context.showSnackBar(message: '兄弟構成を登録しました');
      }
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    }
    setState(() {
      _loading = true;
    });
  }
}
