import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reegs/constants/appbar.dart';

class QrViewModel extends StatelessWidget {
  final String uid;

  const QrViewModel({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImage(
          data: uid,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
