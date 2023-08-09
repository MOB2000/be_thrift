import 'package:be_thrift/screens/categories.dart';
import 'package:be_thrift/screens/currencies.dart';
import 'package:be_thrift/screens/screens.dart';
import 'package:be_thrift/screens/splash.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  ProfileSetupScreen.routeName: (context) => const ProfileSetupScreen(),
  CurrencySetupScreen.routeName: (context) => const CurrencySetupScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  CategoriesScreen.routeName: (context) => const CategoriesScreen(),
  CurrenciesScreen.routeName: (context) => const CurrenciesScreen(),
  SettingsScreen.routeName: (context) => const SettingsScreen(),
};
