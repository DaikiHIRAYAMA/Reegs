import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zajonc/constants/splashscreen.dart';
import 'package:zajonc/views/login/login_page.dart';
import 'package:zajonc/views/register/accout_page.dart';
import 'package:zajonc/views/register/acquired_page.dart';
import 'package:zajonc/views/register/innate_page.dart';
import 'package:zajonc/views/register/position_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Line SDKの設定
  // LineSDK.instance.setup(dotenv.get('CHANEL_ID')).then((_) {
  //   print("LineSDK Prepared");
  // });

  // .envを読み込めるように設定
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.get('VAR_URL'), // .envのURLを取得
    anonKey: dotenv.get('VAR_ANONKEY'), // .envのanonを取得
  );

  runApp(const MyApp());
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
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
        '/innate': (_) => InnatePage(),
        '/acquired': (_) => AcquiredPage(),
        '/position': (_) => PositionPage(),
      },
    );
  }
}
