// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:reegs/index.dart';
import 'package:reegs/view_models/login/store.dart';
import 'package:reegs/views/register/profile_confirmation_page.dart';
import 'package:reegs/views/register/test_confirmation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  final store = Store();

  SplashPage({Key? key}) : super(key: key);

  Future<void> completeDiagnosis(String diagnosisKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(diagnosisKey, true);
  }

  Future<Map<String, bool>> checkDiagnosesCompletion(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final profileKey = '${userId}_profile_complete';
    final testKey = '${userId}_test_complete';
    Map<String, bool> completionStatus = {
      'profile_complete': prefs.getBool(profileKey) ?? false,
      'test_complete': prefs.getBool(testKey) ?? false,
    };

    return completionStatus;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //ユーザーがサインインしている場合
          return FutureBuilder<Map<String, bool>>(
            future: checkDiagnosesCompletion(userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, bool>? data = snapshot.data;
                bool? profileComplete = data?['profile_complete'];
                if (profileComplete == null || !profileComplete) {
                  // profileが未完了または診断の状態が不明の場合
                  print(profileComplete);
                  print("not profile or not diagnose");
                  return const ProfileConfirmationPage();
                } else if (!(data?['test_complete'] ?? false)) {
                  // profileは完了し、testが未完了または診断の状態が不明の場合
                  print("not diagnose or not test");
                  return TestConfirmationPage();
                } else {
                  // すべての診断が完了している場合
                  print("all complete");
                  print("all complete");
                  return LiquidSwipeViews();
                }
              } else {
                // データがまだロードされていない場合、ローディングスピナーを表示するなど
                print("loading");
                return const CircularProgressIndicator();
              }
            },
          );
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
