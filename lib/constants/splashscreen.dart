// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:reegs/view_models/login/store.dart';
import 'package:reegs/views/profiles/profile_page.dart';

class SplashPage extends StatelessWidget {
  final store = Store();

  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //ユーザーがサインインしている場合
          return MyProfilePage();
        } else {
          //ユーザーがサインインしていない場合
          return const SignInScreen(
            providerConfigs: [
              // 使用したい認証方法をここに追加する
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                  clientId:
                      '70825632359-v3pejqdnk8okgpkbhrl4gb65iupobq9g.apps.googleusercontent.com'),
            ],
          );
        }
      },
    );
  }
}
