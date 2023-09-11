import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanView extends StatefulWidget {
  const QrScanView({super.key});

  @override
  _QrScanViewState createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _showQrView = true;
  late final String userId;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // void _toggleView() {
  //   if (_showQrView) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => MyProfileQRPage(userId: userId),
  //       ),
  //     ).then((value) {
  //       _returnToQrView();
  //     });
  //   } else {
  //     _returnToQrView();
  //   }
  // }

  // void _returnToQrView() {
  //   setState(() {
  //     _showQrView = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true, //TODO:ここはTRUE
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QR READ'),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: IconButton(
            // 戻るボタン
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: _buildQrView(context),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea,
            overlayColor: Color.fromRGBO(255, 244, 213, 1)), // 透明な色を設定),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera(); // スキャン後にカメラを一時停止
      String? friendUserId = scanData.code; // 取得したユーザーID

      // 友達の追加処理を呼び出し
      bool success = await _addFriend(friendUserId!);

      // 成功/失敗のフィードバック
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('友達が追加されました！')),
        );
        Navigator.pop(context); // このページを閉じる
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('友達の追加に失敗しました。もう一度お試しください。')),
        );
        controller.resumeCamera(); // カメラを再開して再スキャンを許可
      }
    });
  }

  Future<bool> _addFriend(String userId) async {
    try {
      // 例: 現在のユーザーID (自分のユーザーID) を取得します。
      String currentUserId = "your_current_user_id";

      // 友達を追加するロジック。ここでは単純に友達リストにユーザーIDを追加しています。
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({
        'friends': FieldValue.arrayUnion([userId]),
      });

      return true; // 追加に成功
    } catch (e) {
      print(e); // エラーをログに出力
      return false; // 追加に失敗
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
