import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:zajonc/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Line SDKの設定
  // LineSDK.instance.setup(dotenv.get('CHANEL_ID')).then((_) {
  //   print("LineSDK Prepared");
  // });

  // .envを読み込めるように設定
  await dotenv.load(fileName: '.env');
  // await Supabase.initialize(
  //   url: dotenv.get('VAR_URL'), // .envのURLを取得
  //   anonKey: dotenv.get('VAR_ANONKEY'), // .envのanonを取得
  // );

  runApp(const MyApp());
}
