// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:reegs/app.dart';
import 'package:reegs/constants/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _redirectCalled = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _redirect();
  }

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    // await for for the widget to mount
    await Future.delayed(Duration.zero);

    final session = supabase.auth.currentSession;
    if (session == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      Navigator.of(context).pushReplacementNamed('/myprofile');
      // Navigator.of(context).pushReplacementNamed('/account');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: preloader,
    );
  }
}
