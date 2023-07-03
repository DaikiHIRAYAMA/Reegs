import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class LoginPage extends StatefulWidget {
  final List<dynamic> providerConfigs;

  const LoginPage({Key? key, required this.providerConfigs}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        // children: <Widget>[
        //   SignInScreen(
        //       theme: SignInThemeData(),
        //       config: SignInScreenConfig(
        //         providers: SignInScreenConfig(),
        //       ),
        //       onSignedIn: (user) {
        //         print('サインインしました: ${user.displayName}');
        //       })
        // ],
      ),
    );
  }
}
