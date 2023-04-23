import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Supabase client
// final supabase = Supabase.instance.client;

//preloader
const preloader = Center(child: CircularProgressIndicator());

//appTheme
final appTheme = ThemeData.light().copyWith(
    primaryColor: Colors.green,
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'TaleSys'),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 158, 175, 76),
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.brown,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown[600],
      ),
    ));
