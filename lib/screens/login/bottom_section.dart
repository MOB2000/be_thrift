import 'package:be_thrift/generated/l10n.dart';
import 'package:be_thrift/screens/screens.dart';
import 'package:be_thrift/services/services.dart';
import 'package:flutter/material.dart';

class BottomSection extends StatefulWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  _BottomSectionState createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(flex: 2),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            S.of(context)!.loginTextTagline,
            textAlign: TextAlign.center,
            style: const TextStyle(
              height: 1.6,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(flex: 2),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton.icon(
            onPressed: () => signIn(false),
            // textColor: Theme.of(context).colorScheme.secondary,
            // padding: const EdgeInsets.symmetric(vertical: 15),
            icon: Image.asset(
              'assets/images/google_icon.png',
              width: 28,
              height: 28,
            ),
            label: Text(
              S.of(context)!.loginButtonTextGoogle,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            onPressed: () => signIn(true),
            // padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              S.of(context)!.loginButtonTextGuest,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }

  Future<void> signIn(bool isAnonymous) async {
    try {
      var user = isAnonymous
          ? await _authService.signInAnonymously()
          : await _authService.signInWithGoogle();
      if (user == null) {
        Navigator.pushReplacementNamed(context, ProfileSetupScreen.routeName);
      } else if (await UserDatabaseService(user).checkIfUserExists) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, ProfileSetupScreen.routeName);
      }
    } catch (e) {
      return;
    }
  }
}
