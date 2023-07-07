import 'package:flutter/material.dart';

//preloader
const preloader = Center(child: CircularProgressIndicator());

Color? mainColor; // NullableのColor型として宣言します

final appTheme = ThemeData.light().copyWith(
  textTheme: ThemeData.light().textTheme.apply(fontFamily: 'TaleSys'),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(),
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 40, // 文字の大きさを大きくする
      fontFamily: 'TaleSys', // 追加: フォントファミリーを指定
    ),
    elevation: 0,
    toolbarHeight: 200, // AppBarを縦に広げる
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.only(bottom: 30), // アイコン表示場所を下に下げる
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
    iconSize: 80,
    focusColor: Colors.black,
  )),
  cardTheme: const CardTheme(
    elevation: 0,
  ),
  primaryColor: mainColor,
);
