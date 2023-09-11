// main.dartでrunAppに渡す上位のアプリケーションクラスです。
// 以下のようなことを行うことが多いです。

// アプリ全体のテーマの設定

import 'package:flutter/material.dart';
import 'package:reegs/constants/constants.dart';
import 'package:reegs/constants/splash.dart';
import 'package:reegs/views/QR/qr_scan_page.dart';
import 'package:reegs/views/profiles/profile_page.dart';
import 'package:reegs/views/register/account_page.dart';
import 'package:reegs/views/register/acquired_page.dart';
import 'package:reegs/views/register/innate_page.dart';
import 'package:reegs/views/register/siblings_page.dart';
import 'package:reegs/views/register/profile_confirmation_page.dart';
import 'package:reegs/views/register/test_confirmation_page.dart';

import 'view_models/register/acquired_viewmodel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter',
        locale: const Locale('ja', 'JP'),
        theme: appTheme,
        routes: <String, WidgetBuilder>{
          //ここにルーティングをかく
          '/': (_) => SplashPage(),
          '/account': (_) => const AccountPage(),
          '/myprofile': (_) => MyProfilePage(),
          '/innate': (_) => InnatePage(),
          '/acquired': (_) => AcquiredPage(question: Question.q1),
          '/siblings': (_) => SiblingsPage(),
          '/qrscan': (_) => QrScanView(),
          '/profileConfirm': (_) => const ProfileConfirmationPage(),
          '/testConfirm': (_) => TestConfirmationPage()
        });
  }
}
