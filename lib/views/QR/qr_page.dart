//プロフィールページ

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reegs/view_models/QR/QR_view_model.dart';
import 'package:reegs/views/QR/qr_scan_page.dart';

class QrPage extends StatelessWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String uid = currentUser?.uid ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QrScanView()),
              );
            },
            icon: const Icon(Icons.qr_code_scanner),
          ),
        ],
      ),
      body: QrViewModel(
        uid: uid, //ここに自身のUIDを渡す処理を加える
      ),
    );
  }
}
