import 'package:flutter/material.dart';
import 'package:reegs/constants/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _characterNameController = TextEditingController();
  String? _avatarUrl;
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
        _avatarUrl = (data['avatar_url'] ?? '') as String;
      } else {
        // Handle case where no document is found.
      }
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected exception occurred');
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
    final updates = {
      'id': user!.uid,
      'name': characterName,
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await FirebaseFirestore.instance
          .collection('characters')
          .doc(user.uid)
          .set(updates, SetOptions(merge: true));

      if (mounted) {
        context.showSnackBar(message: 'Successfully updated profile!');
      }
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpeted error occurred');
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
  void dispose() {
    _characterNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NAME?'),
      ),
      backgroundColor: const Color.fromRGBO(255, 244, 213, 1),
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
                hintText: 'TYPE HERE',
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
              onPressed: () {
                _registerProfile();
                Navigator.pushNamed(context, '/innate');
              },
            ),
          ),
        ],
      ),
    );
  }
}

// List<TextSpan> _buildUnderlinedText(String text) {
//   return text.split('').map((char) {
//     return TextSpan(
//       text: char + ' ',
//       style: const TextStyle(
//         decoration: TextDecoration.underline
//         decorationStyle: TextDecorationStyle.solid,
//         decorationColor: Colors.black,
//       ),
//     );
//   }).toList();
// }
