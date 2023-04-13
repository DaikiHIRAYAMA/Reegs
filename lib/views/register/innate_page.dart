//生年月日による分類
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zajonc/constants/snackbar.dart';
import 'package:intl/intl.dart';

class InnatePage extends StatefulWidget {
  @override
  State<InnatePage> createState() => _InnatePageState();
}

class _InnatePageState extends State<InnatePage> {
  final _birthdayController = TextEditingController();
  var _loading = false;

  void _onDateSelected(DateTime date) {
    setState(() {
      _birthdayController.text = DateFormat('yyyy/MM/dd').format(date);
    });
  }

// これの関数を他のページで使用する際は、Riverpod等を用いる必要がある
  Future<void> _getCharacter() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase
          .from('characters')
          .select()
          .eq('id', userId)
          .single() as Map;
      _birthdayController.text = (data['username'] ?? '') as String;
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected exception occurred');
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _registerBirthday() async {
    setState(() {
      _loading = true;
    });
    final birthday = _birthdayController.text;
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'birthday': birthday,
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await supabase.from('characters').upsert(updates);
      if (mounted) {
        context.showSnackBar(message: '生年月日を登録しました'); //TODO
      }
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('生年月日を入力してください')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _birthdayController.text, // 変数を参照
              style: const TextStyle(
                fontSize: 20.0, // 文字の大きさを指定
                color: Colors.white, // 文字の色を指定
                fontWeight: FontWeight.bold, // 文字の太さを指定
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1950, 1, 1),
                      maxTime: DateTime.now(),
                      theme: const DatePickerTheme(
                          headerColor: Colors.green,
                          backgroundColor: Colors.black,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                    _onDateSelected(date);
                  }, currentTime: DateTime.now(), locale: LocaleType.jp);
                },
                child: const Text(
                  '生年月日を入力してね',
                  style: TextStyle(color: Colors.black),
                )),
            ElevatedButton(
                onPressed: () {
                  _registerBirthday();
                  Navigator.pushNamed(context, '/position');
                },
                child: const Text('NEXT'))
          ],
        ),
      ),
    );
  }
}
