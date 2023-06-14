import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLineLoading = false;
  bool _redirecting = false;
  late StreamSubscription<firebase.User?> _authStateSubscription;

  Future<void> lineSignIn() async {
    // LINE SDKを初期化
    await LineSDK.instance.setup(dotenv.get('CHANNEL_ID'));

    try {
      // ローディング状態をtrueにセット
      setState(() {
        _isLineLoading = true;
      });

      // LINEでユーザーにログインさせる
      final result =
          await LineSDK.instance.login(scopes: ["profile", "openid"]);

      // LINE Access Tokenを取得
      final accessToken = result.accessToken.value;

      // FirebaseにLINE Access Tokenを使用してサインイン
      final credential =
          firebase.OAuthProvider('line').credential(accessToken: accessToken);
      await firebase.FirebaseAuth.instance.signInWithCredential(credential);

      // ローディング状態をfalseにセット
      setState(() {
        _isLineLoading = false;
      });

      // ログイン成功時の処理
      // 例えば、Firebaseから取得したユーザー情報を表示するなど
    } on firebase.FirebaseAuthException catch (error) {
      // ローディング状態をfalseにセット
      setState(() {
        _isLineLoading = false;
      });

      // Firebaseの認証エラー処理
      print('Firebase Auth Error: ${error.message}');
    } on AuthException catch (error) {
      // ローディング状態をfalseにセット
      setState(() {
        _isLineLoading = false;
      });

      // LINEの認証エラー処理
      print('LINE Auth Error: ${error.message}');
    } catch (error) {
      // ローディング状態をfalseにセット
      setState(() {
        _isLineLoading = false;
      });

      // 予期しないエラー処理
      print('Unexpected error occurred: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _authStateSubscription = firebase.FirebaseAuth.instance
        .authStateChanges()
        .listen((firebase.User? user) {
      if (_redirecting) return;

      if (user == null) {
        print('User is currently signed out!');
      } else {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/account');
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          ElevatedButton(
            onPressed: _isLineLoading
                ? null
                : () async {
                    await lineSignIn();
                  },
            child: Text(_isLineLoading ? 'Loading' : 'LINE Login'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/startConfirm');
            },
            child: const Text('Test時のみここからクリック'),
          ),
        ],
      ),
    );
  }
}
