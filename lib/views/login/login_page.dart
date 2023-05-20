import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reegs/app.dart';
// import 'package:reegs/constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:reegs/constants/snackbar.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isGoogleLoading = false;
  bool _isLineLoading = false;
  bool _redirecting = false;
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signInGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });
    try {
      await supabase.auth.signInWithOAuth(Provider.google);
      if (mounted) {
        context.showSnackBar(message: 'Login!');
      }
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    }
    setState(() {
      _isGoogleLoading = false;
    });
  }

  Future<void> _lineLogin() async {
    await LineSDK.instance.setup("LINE_CHANNEL_ID");
    setState(() {
      _isLineLoading = true;
    });
    try {
      final result =
          await LineSDK.instance.login(scopes: ["profile", "openid"]);
      // user id -> result.userProfile?.userId
      // user name -> result.userProfile?.displayName

      // ログイン成功時の処理
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    }

    setState(() {
      _isLineLoading = false;
    });
  }

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/account');
      }
    });
    super.initState();
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
            onPressed: _isGoogleLoading
                ? null
                : () async {
                    await _signInGoogle();
                  },
            child: Text(_isGoogleLoading ? 'Loading' : 'Google Login'),
          ),
          ElevatedButton(
            onPressed: _isLineLoading
                ? null
                : () async {
                    await _lineLogin();
                  },
            child: Text(_isLineLoading ? 'Loading' : 'LINE Login'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/account');
            },
            child: const Text('Test時のみここからクリック'),
          ),
        ],
      ),
    );
  }
}
