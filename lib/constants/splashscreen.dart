// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reegs/app.dart';
import 'package:reegs/constants/constants.dart';
import 'package:reegs/models/profiles/user_state.dart';
import 'package:reegs/view_models/login/store.dart';
import 'package:reegs/views/login/login_page.dart';
import 'package:reegs/views/profiles/profile_page.dart';

class SplashPage extends StatelessWidget {
  final store = Store();

  @override
  Widget build(BuildContext context) => Scaffold(
          body: StreamBuilder<UserState>(
        stream: initStream(),
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case null:
            case UserState.waiting:
              return Center(
                  child: SpinKitCircle(
                size: 24,
                color: Colors.black, //色を変えれます
              ));
            case UserState.signedOut:
              return const LoginPage();
            case UserState.signedIn:
              return MyProfilePage(); //　ここの設定を変える
          }
        },
      ));

  Stream<UserState> initStream() async* {
    yield UserState.waiting;
    var signedIn = await store.signedIn;
    if (signedIn) {
      yield UserState.signedIn;
    } else {
      yield UserState.signedOut;
    }
  }
}

//  SplashPageState extends State<SplashPage> {
//   bool _redirectCalled = false;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _redirect();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _redirect();
//   }

//   Future<void> _redirect() async {
//     // await for for the widget to mount
//     await Future.delayed(Duration.zero);

//     final session = supabase.auth.currentSession;
//     if (session == null) {
//       Navigator.of(context).pushReplacementNamed('/login');
//     } else {
//       Navigator.of(context).pushReplacementNamed('/qrscan');
//       // Navigator.of(context).pushReplacementNamed('/account');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: preloader,
//     );
//   }
// }
