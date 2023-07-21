import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _characterNameController = TextEditingController();
  var _loading = false;

  /// Called once a user id is received within `onAuthenticated()`
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
        _characterNameController.text = (data['username'] ?? '') as String;
      } else {
        // Handle case where no document is found.
      }
    } catch (error) {
      showNameErrorSnackBar(); // <-- Update here
    }

    setState(() {
      _loading = false;
    });
  }

  Future<void> _registerProfile() async {
    setState(() {
      _loading = true;
    });
    final characterName = _characterNameController.text;
    final user = firebase.FirebaseAuth.instance.currentUser;
    if (user != null) {
      final updates = {
        'id': user.uid,
        'name': characterName,
        'updated_at': DateTime.now().toIso8601String(),
      };
      try {
        await FirebaseFirestore.instance
            .collection('characters')
            .doc(user.uid)
            .set(updates, SetOptions(merge: true));

        showNameSuccessSnackBar(); // <-- Update here
      } catch (error) {
        showNameErrorSnackBar(); // <-- Update here
      }
    } else {
      Navigator.pushNamed(context, '/login');
    }
    setState(() {
      _loading = false;
    });
  }

  void showNameSuccessSnackBar() {
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('名前を登録しました')),
        );
      });
    }
  }

  void showNameErrorSnackBar() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('名前を変更できませんでした')),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getCharacter());
  }

  @override
  void dispose() {
    _characterNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('おなまえ'),
        automaticallyImplyLeading: false, // 戻るを非表示
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            alignment: Alignment.center,
            child: TextFormField(
              controller: _characterNameController,
              decoration: const InputDecoration(
                // labelText: 'TYPE HERE',
                hintText: '_ _ _ _ _ _',
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.always, // ラベルを常に表示
                labelStyle:
                    TextStyle(fontSize: 20, height: 2), // ラベルの文字サイズと高さ調整
              ),
              style: const TextStyle(fontSize: 40), // 文字を大きくする
              textAlign: TextAlign.center, // テキストを中央寄せにする
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: IconButton(
              icon: const Icon(
                Icons.forward,
                color: Colors.black,
                size: 80, // アイコンを大きくする
              ),
              onPressed: _loading
                  ? null
                  : () async {
                      // Disable the button when _loading is true
                      try {
                        await _registerProfile(); // Wait until _registerProfile is complete
                        if (!_loading) {
                          // Check again if _loading is false, if not, do not navigate
                          Navigator.pushNamed(context, '/innate');
                        }
                      } catch (error) {
                        showNameErrorSnackBar(); // <-- Show error message
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
