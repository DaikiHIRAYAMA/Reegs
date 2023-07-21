//兄弟構成

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SiblingsPage extends StatefulWidget {
  @override
  _SiblingsPageState createState() => _SiblingsPageState();
}

enum SiblingsValue { Eldest, Middle, Youngest, Only }

extension SiblingsValueExtension on SiblingsValue {
  int toInt() {
    switch (this) {
      case SiblingsValue.Eldest:
        return 0;
      case SiblingsValue.Middle:
        return 1;
      case SiblingsValue.Youngest:
        return 2;
      case SiblingsValue.Only:
        return 3;
      default:
        throw Exception('Unknown Siblings value');
    }
  }
}

class _SiblingsPageState extends State<SiblingsPage> {
  SiblingsValue _siblingsValue = SiblingsValue.Eldest;

  var _loading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void showSiblingsErrorSnackBar() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('生年月日を登録できませんでした')),
      );
    });
  }

  void showSiblingsSuccessSnackBar() {
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('兄弟構成を登録しました')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.2),
        child: AppBar(
          title: const SizedBox(
            child: Text('兄弟構成'),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Card(
            child: Column(children: [
              //一人っ子
              InkWell(
                onTap: _loading
                    ? null
                    : () async {
                        try {
                          _onRadioSelected(SiblingsValue.Only);
                          await _registerSiblings();
                          if (!_loading) {
                            Navigator.pushNamed(context, '/testConfirm');
                          }
                          // 任意の遷移処理をここに追加してください
                        } catch (error) {
                          showSiblingsErrorSnackBar();
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        }
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/assets/images/siblings/SB1.png',
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
              //長子
              InkWell(
                onTap: _loading
                    ? null
                    : () async {
                        try {
                          _onRadioSelected(SiblingsValue.Eldest);
                          await _registerSiblings();
                          if (!_loading) {
                            Navigator.pushNamed(context, '/testConfirm');
                          }
                          // 任意の遷移処理をここに追加してください
                        } catch (error) {
                          showSiblingsErrorSnackBar();
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        }
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/assets/images/siblings/SB2.png',
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
                onTap: _loading
                    ? null
                    : () async {
                        try {
                          _onRadioSelected(SiblingsValue.Middle);
                          await _registerSiblings();
                          if (!_loading) {
                            Navigator.pushNamed(context, '/testConfirm');
                          }
                          // 任意の遷移処理をここに追加してください
                        } catch (error) {
                          showSiblingsErrorSnackBar();
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        }
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/assets/images/siblings/SB3.png',
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
                onTap: _loading
                    ? null
                    : () async {
                        try {
                          _onRadioSelected(SiblingsValue.Youngest);
                          await _registerSiblings();
                          if (!_loading) {
                            Navigator.pushNamed(context, '/testConfirm');
                          }
                          // 任意の遷移処理をここに追加してください
                        } catch (error) {
                          showSiblingsErrorSnackBar();
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        }
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/assets/images/siblings/SB4.png',
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
      backgroundColor: Colors.white,
    );
  }

  void _onRadioSelected(value) {
    setState(() {
      _siblingsValue = value;
    });
  }

  Future<void> _registerSiblings() async {
    setState(() {
      _loading = true;
    });
    final user = _auth.currentUser;
    if (user != null) {
      final updates = {
        'id': user.uid,
        'siblings': _siblingsValue.toInt(),
        'updated_at': DateTime.now().toIso8601String(),
      };
      try {
        await _firestore
            .collection('characters')
            .doc(user.uid)
            .set(updates, SetOptions(merge: true));
        showSiblingsSuccessSnackBar();
      } catch (error) {
        showSiblingsErrorSnackBar();
      }
    }
    setState(() {
      _loading = false;
    });
  }
}
