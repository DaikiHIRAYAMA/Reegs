import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/app.dart';
import 'package:reegs/view_models/login/store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//ログインしているのか判定
final storeProvider = ChangeNotifierProvider<Store>((ref) => Store());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .envを読み込めるように設定
  await dotenv.load(fileName: '.env');

  //firebase初期化
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((_) {
    print('Firebase prepared');
  });

  runApp(const ProviderScope(child: MyApp()));
}
