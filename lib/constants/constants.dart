import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Supabase client
// final supabase = Supabase.instance.client;

//preloader
const preloader = Center(child: CircularProgressIndicator());

final appTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'TaleSys'),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 158, 175, 76),
      ),
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 40, // 文字の大きさを大きくする
        fontFamily: 'TaleSys', // 追加: フォントファミリーを指定
      ),
      elevation: 0,
      color: Color.fromRGBO(255, 244, 213, 1),
      toolbarHeight: 200, // AppBarを縦に広げる
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromRGBO(255, 244, 213, 1),
        padding: const EdgeInsets.only(bottom: 30), // アイコン表示場所を下に下げる
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
      iconSize: 80,
      focusColor: Colors.black,
    )));
