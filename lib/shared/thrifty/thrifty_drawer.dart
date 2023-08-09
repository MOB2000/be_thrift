import 'package:be_thrift/generated/l10n.dart';
import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/screens/categories.dart';
import 'package:be_thrift/screens/currencies.dart';
import 'package:be_thrift/screens/screens.dart';
import 'package:be_thrift/services/services.dart';
import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThriftyDrawer extends StatelessWidget {
  const ThriftyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<CustomUser>(context);

    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                DrawerHeader(user),
                const SizedBox(height: 10),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, CategoriesScreen.routeName);
                  },
                  leading: const Icon(Icons.category),
                  title: Text(S.of(context)!.thriftyDrawerTextCategories),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, CurrenciesScreen.routeName);
                  },
                  leading: const Icon(Icons.attach_money),
                  title: Text(S.of(context)!.thriftyDrawerTextCurrencies),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, SettingsScreen.routeName);
                  },
                  leading: const Icon(Icons.settings),
                  title: Text(S.of(context)!.thriftyDrawerTextSettings),
                ),
                const Divider(),
                ListTile(
                  onTap: () async {
                    Navigator.pop(context);
                    showAboutDialog(
                      context: context,
                      applicationIcon: ThriftyLogo(
                        size: 80,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      applicationName: S.of(context)!.appName,
                      applicationLegalese:
                          S.of(context)!.thriftyDrawerTextAboutAppLegalese,
                      applicationVersion: '1.0',
                      children: [
                        const SizedBox(height: 30),
                        Text(S.of(context)!.thriftyDrawerTextAboutFooter),
                      ],
                    );
                  },
                  leading: const Icon(Icons.local_library),
                  title: Text(S.of(context)!.thriftyDrawerTextAbout),
                ),
                const Divider(),
                ListTile(
                  onTap: () => logout(context),
                  leading: const Icon(Icons.exit_to_app),
                  title: Text(S.of(context)!.thriftyDrawerTextLogout),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  logout(BuildContext context) {
    AuthService authService = AuthService();
    Navigator.pop(context);
    authService.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
      (route) => false,
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader(this.user, {super.key});

  final CustomUser user;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        width: double.infinity,
        height: 180,
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 45),
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              user.email,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
