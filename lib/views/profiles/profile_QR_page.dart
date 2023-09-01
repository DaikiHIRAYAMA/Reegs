import 'package:flutter/material.dart';
import 'package:reegs/view_models/profiles/profile_QR_view_model.dart';
import 'package:reegs/views/friends/qr_scan_page.dart';

class MyProfileQRPage extends StatelessWidget {
  final String userId;
  const MyProfileQRPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My QR Code'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.qr_code_scanner),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QrScanView()));
              },
            ),
          ],
        ),
        body: MyProfileQRViewModel(userId: userId));
  }
}
