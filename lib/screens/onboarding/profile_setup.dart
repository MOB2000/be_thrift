import 'package:after_layout/after_layout.dart';
import 'package:be_thrift/generated/l10n.dart';
import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/screens/screens.dart';
import 'package:be_thrift/services/services.dart';
import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSetupScreen extends StatefulWidget {
  static const String routeName = '/profile-setup';

  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen>
    with AfterLayoutMixin<ProfileSetupScreen> {
  bool isGuest = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 500), () {
      var user = Provider.of<CustomUser>(context, listen: false);

      _nameController.text = user.name;
      _emailController.text = user.email;

      if (user.email.isEmpty) {
        setState(() => isGuest = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<CustomUser?>(context);

    return Scaffold(
      body: ListView(
        children: <Widget>[
          const OnboardingHeader(),
          const SizedBox(height: 50),
          Icon(
            Icons.person,
            size: 42,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 10),
          Text(
            S.of(context)!.profileSetupTextHeadline,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: S.of(context)!.profileSetupLabelTextFullName,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              enabled: isGuest,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: S.of(context)!.profileSetupLabelTextEmailAddress,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ThriftyButton(
              title: S.of(context)!.profileSetupButtonTextNext,
              onPressed: () async {
                if (_nameController.text.isEmpty ||
                    _emailController.text.isEmpty) return;

                await UserDatabaseService(user!)
                    .updateUserName(_nameController.text);
                await UserDatabaseService(user)
                    .updateUserEmail(_emailController.text);

                Navigator.pushReplacementNamed(
                  context,
                  CurrencySetupScreen.routeName,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
