import 'package:after_layout/after_layout.dart';
import 'package:be_thrift/config/config.dart';
import 'package:be_thrift/screens/screens.dart';
import 'package:be_thrift/services/services.dart';
import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  void afterFirstLayout(BuildContext context) async {
    updateStatusBarColor(context);
    Future.delayed(const Duration(seconds: 1), _checkIfUserIsLoggedIn);
  }

  checkUserPreferences() async {
    var settings = Provider.of<SettingsProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int theme = prefs.getInt('theme') ?? 0;
    String appLang = prefs.getString('appLang') ?? 'en';
    int color = prefs.getInt('accentColor') ?? thriftyBlue.value;
    bool biometricsEnabled = prefs.getBool('biometricsEnabled') ?? false;

    settings.setAccentColor(Color(color));
    settings.setAppLanguage(Locale(appLang));
    settings.setBiometricsEnabled(biometricsEnabled);
  }

  _checkIfUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthService auth = AuthService();
    var user = auth.getUser;

    try {
      var isAuthenticated = true;
      if (await _localAuthentication.canCheckBiometrics) {
        if (prefs.getBool('biometricsEnabled') ?? false) {
          isAuthenticated = await _localAuthentication.authenticate(
            localizedReason: "Please authenticate yourself to access the app.",
            options: const AuthenticationOptions(
              sensitiveTransaction: false,
              useErrorDialogs: true,
              stickyAuth: true,
            ),
          );
        }
      }

      if (isAuthenticated) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
      } else {
        _scaffoldKey.currentState?.showSnackBar(const SnackBar(
          content: Text(
            'No soup for you! 🥣',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
      }
    } on PlatformException catch (e) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Text(e.message ?? ""),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    checkUserPreferences();

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: const Center(
          child: ThriftyLogo(size: 100),
        ),
      ),
    );
  }
}
