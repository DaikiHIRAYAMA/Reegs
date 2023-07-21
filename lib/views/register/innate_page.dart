//生年月日による分類
import 'package:flutter/scheduler.dart';
import 'package:reegs/constants/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
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

    final user = firebase.FirebaseAuth.instance.currentUser;

    if (user == null) {
      //userのNullチェック
      return;
    }
    final birthday = _birthdayController.text;
    final updates = {
      'id': user.uid,
      'birthday': birthday,
      'updated_at': DateTime.now().toIso8601String(),
    };

    try {
      await FirebaseFirestore.instance
          .collection('characters')
          .doc(user.uid)
          .set(updates, SetOptions(merge: true));
    } catch (error) {
      showBirthdayErrorSnackBar();
      _loading = false;
      return;
    }

    setState(() {
      _loading = false;
      // mainColor = updates['color'];
    });
  }

  void showBirthdaySuccessSnackBar() {
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('生年月日を登録しました')),
        );
      });
    }
  }

  void showBirthdayErrorSnackBar() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('生年月日を登録できませんでした')),
      );
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('生年月日'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.all(0)), // この行を追加
              ),
              child: Text(
                _birthdayController.text.isEmpty
                    ? '生年月日を登録してください'
                    : _birthdayController.text,
                style: TextStyle(
                    fontSize: 40,
                    color: _birthdayController.text.isEmpty
                        ? Colors.grey
                        : Colors.black),
              ),
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990, 1, 1),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  print('確認 $picked');
                  _onDateSelected(picked);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: IconButton(
              icon: const Icon(
                Icons.forward,
                color: Colors.black,
                size: 80, // アイコンを大きくする
              ),
              onPressed: _loading
                  ? null
                  : () async {
                      try {
                        await _registerBirthday();
                        if (!_loading) {
                          Navigator.pushNamed(context, '/siblings');
                        }
                      } catch (error) {
                        showBirthdayErrorSnackBar();
                        if (Navigator.canPop(context)) {
                          // Check if Navigator has a previous page
                          Navigator.pop(
                              context); // Go back to the previous page
                        }
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }
}
