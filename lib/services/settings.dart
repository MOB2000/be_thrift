import 'package:be_thrift/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  Locale appLang = const Locale('en');
  Color accentColor = Color(thriftyBlue.value);
  bool biometricsEnabled = false;

  setAppLanguage(Locale? locale) async {
    if (locale == null) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('appLang', locale.languageCode);
    appLang = locale;
    notifyListeners();
  }

  setAccentColor(Color? color) async {
    if (color == null) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accentColor', color.value);
    accentColor = color;
    notifyListeners();
  }

  setBiometricsEnabled(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometricsEnabled', value);
    biometricsEnabled = value;
    notifyListeners();
  }
}
