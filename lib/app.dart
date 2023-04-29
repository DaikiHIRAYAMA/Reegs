// main.dartでrunAppに渡す上位のアプリケーションクラスです。
// 以下のようなことを行うことが多いです。

// アプリ全体のテーマの設定

import 'package:flutter/material.dart';
import 'package:reegs/constants/constants.dart';
import 'package:reegs/constants/splashscreen.dart';
import 'package:reegs/views/login/login_page.dart';
import 'package:reegs/views/login/signup_page.dart';
import 'package:reegs/views/profiles/profile_page.dart';
import 'package:reegs/views/register/account_page.dart';
import 'package:reegs/views/register/acquired_page.dart';
import 'package:reegs/views/register/innate_page.dart';
import 'package:reegs/views/register/position_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Supabase Flutter',
        theme: appTheme,
        routes: <String, WidgetBuilder>{
          //ここにルーティングをかく
          '/': (_) => const SplashPage(),
          '/login': (_) => const LoginPage(),
          '/account': (_) => const AccountPage(),
          '/signup': (_) => const SignUpPage(
                isRegistering: true,
              ),
          '/myprofile': (_) => const MyProfilePage(),
          '/innate': (_) => InnatePage(),
          '/acquired': (_) => AcquiredPage(),
          '/position': (_) => PositionPage(),
        });
  }
}
