//生年月日による分類
import 'package:flutter/scheduler.dart';
import 'package:reegs/constants/constants.dart';
import 'package:reegs/models/profiles/calcurate_color.dart';
import 'package:reegs/constants/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> _getCharacter() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = firebase.FirebaseAuth.instance.currentUser!.uid;
      final docSnapshot = await FirebaseFirestore.instance
          .collection('characters')
          .doc(userId)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        _birthdayController.text = (data['birthday'] ?? '') as String;
      } else {
        // Handle case where no document is found.
      }
    } catch (error) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.showErrorSnackBar(message: 'Unexpected exception occurred');
      });
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
    final user = firebase.FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Here handle the situation when user is null.
      // You may want to return from the function or show some error message
      return;
    }
    final updates = {
      'id': user.uid,
      'birthday': birthday,
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      setState(() {
        mainColor = calculateColor(birthday);
      });
      await FirebaseFirestore.instance
          .collection('characters')
          .doc(user.uid)
          .set(updates, SetOptions(merge: true));

      if (mounted) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.showSnackBar(message: '生年月日を登録しました');
        });
      }
    } catch (error) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.showErrorSnackBar(message: 'Unexpected error occurred');
      });
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
      appBar: AppBar(title: const Text('BIRTHDAY?')),
      backgroundColor: const Color.fromRGBO(255, 244, 213, 1),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(0)), // この行を追加
              ),
              child: Text(
                _birthdayController.text.isEmpty
                    ? 'TYPE HERE'
                    : _birthdayController.text,
                style: TextStyle(
                    fontSize: 40,
                    color: _birthdayController.text.isEmpty
                        ? Colors.grey
                        : Colors.black),
              ),
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
                  print('変更 $date');
                }, onConfirm: (date) {
                  print('確認 $date');
                  _onDateSelected(date);
                },
                    currentTime: DateTime.now(),
                    locale: LocaleType.jp); //スタート位置変更できる
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: IconButton(
              icon: const Icon(
                Icons.forward,
                color: Colors.black,
                size: 80, // アイコンを大きくする
              ),
              onPressed: () {
                _registerBirthday();
                Navigator.pushNamed(context, '/siblings');
              },
            ),
          ),
        ],
      ),
    );
  }
}
