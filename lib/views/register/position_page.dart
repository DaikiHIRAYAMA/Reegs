//兄弟構成

import 'package:flutter/material.dart';
import 'package:reegs/app.dart';
import 'package:reegs/constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:reegs/constants/snackbar.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.2),
        child: AppBar(
          title: const SizedBox(
            child: Text('SIBLINGS?'),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 244, 213, 1),
      body: Column(
        children: [
          Card(
            child: Column(children: [
              InkWell(
                onTap: () {
                  _onRadioSelected(PositionValue.Only);
                  _registerPosition();
                  Navigator.pushNamed(context, '/acquired');
                  // 任意の遷移処理をここに追加してください
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/assets/images/siblings/Only.png',
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.15,
                        fit: BoxFit.contain),
                  ],
                ),
              ),
            ]),
          ),
          Card(
            child: Column(children: [
              InkWell(
                onTap: () {
                  _onRadioSelected(PositionValue.Eldest);
                  _registerPosition();
                  Navigator.pushNamed(context, '/acquired');
                  // 任意の遷移処理をここに追加してください
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/assets/images/siblings/Eldest.png',
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.15,
                        fit: BoxFit.contain),
                  ],
                ),
              ),
            ]),
          ),
          Card(
            child: Column(children: [
              InkWell(
                onTap: () {
                  _onRadioSelected(PositionValue.Middle);
                  _registerPosition();
                  Navigator.pushNamed(context, '/acquired');
                  // 任意の遷移処理をここに追加してください
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/assets/images/siblings/Middle.png',
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.15,
                        fit: BoxFit.contain),
                  ],
                ),
              ),
            ]),
          ),
          Card(
            child: Column(children: [
              InkWell(
                onTap: () {
                  _onRadioSelected(PositionValue.Youngest);
                  _registerPosition();
                  Navigator.pushNamed(context, '/acquired');
                  // 任意の遷移処理をここに追加してください
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/assets/images/siblings/Youngest.png',
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.15,
                        fit: BoxFit.contain),
                  ],
                ),
              ),
            ]),
          ),
        ],
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
