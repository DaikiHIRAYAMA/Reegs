import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyProfileQRViewModel extends StatelessWidget {
  const MyProfileQRViewModel({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // 画面の横幅の60%をQRコードのサイズに設定
    double qrSize = screenWidth * 0.6;
    return Scaffold(
      // appBar: const ProfileAppbar(),
      backgroundColor: const Color.fromRGBO(255, 244, 213, 1),
      body: Center(
        child: QrImage(
          data: 'https://www.google.com/',
          version: QrVersions.auto,
          size: qrSize, //QRコードのサイズ
          foregroundColor: Colors.pink, //QRコードの色
          padding: const EdgeInsets.all(40),
          embeddedImage: Image.network(
                  'https://icooon-mono.com/i/icon_11354/icon_113541_64.png')
              .image, //QRコードの真ん中に表示する画像
        ),
      ),
    );
  }
}
