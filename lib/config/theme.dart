import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  fontFamily: 'FiraSans',
  primaryColor: Colors.white,
  brightness: Brightness.light,
  tabBarTheme: TabBarTheme(
    labelColor: Colors.white,
  ),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
    },
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    ),
    focusColor: Colors.grey,
    hintStyle: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.grey,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.grey,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.grey,
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    backgroundColor: const Color(0xFFFFFFFF),
    brightness: Brightness.light,
  ),
);
