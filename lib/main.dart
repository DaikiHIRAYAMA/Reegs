import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:reegs/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .envを読み込めるように設定
  await dotenv.load(fileName: '.env');

  //supabaseの初期化
  await Supabase.initialize(
    url: dotenv.get('VAR_URL'), // .envのURLを取得
    anonKey: dotenv.get('VAR_ANONKEY'), // .envのanonを取得
  );

  //Line SDKの設定
  await LineSDK.instance.setup(dotenv.get('CHANNEL_ID'));

  runApp(const MyApp());
}
