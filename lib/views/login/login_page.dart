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
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController;
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signInGoogle() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase.auth.signInWithOAuth(Provider.google);
      if (mounted) {
        context.showSnackBar(message: 'Login!');
        _emailController.clear();
      }
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    }
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase.auth.signInWithOtp(
        email: _emailController.text,
        emailRedirectTo:
            kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      );
      if (mounted) {
        context.showSnackBar(message: 'Check your email for login link!');
        _emailController.clear();
      }
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _lineLogin() async {
    await LineSDK.instance.setup("LINE_CHANNEL_ID");
    setState(() {
      _isLoading = true;
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
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
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
    _emailController.dispose();
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
          const Text('Sign in via the magic link with your email below'),
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _signIn,
            child: Text(_isLoading ? 'Loading' : 'Send Magic Link'),
          ),
          ElevatedButton(
            onPressed: _isLoading
                ? null
                : () async {
                    await _signInGoogle();
                  },
            child: Text(_isLoading ? 'Loading' : 'Google Login'),
          ),
          ElevatedButton(
            onPressed: _isLoading
                ? null
                : () async {
                    await _lineLogin();
                  },
            child: Text(_isLoading ? 'Loading' : 'LINE Login'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
