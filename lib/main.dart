import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:reegs/constants/splashscreen.dart';
import 'package:reegs/views/login/login_page.dart';
import 'package:reegs/views/register/accout_page.dart';
import 'package:reegs/views/register/acquired_page.dart';
import 'package:reegs/views/register/innate_page.dart';
import 'package:reegs/views/register/position_page.dart';

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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Flutter',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        //ここにルーティングをかく
        '/': (_) => const SplashPage(),
        '/login': (_) => LoginPage(),
        '/account': (_) => const AccountPage(),
        '/innate': (_) => InnatePage(),
        '/acquired': (_) => AcquiredPage(),
        '/position': (_) => PositionPage(),
      },
    );
  }
}
