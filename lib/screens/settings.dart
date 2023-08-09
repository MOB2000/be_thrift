import 'package:be_thrift/config/utils.dart';
import 'package:be_thrift/data/languages.dart';
import 'package:be_thrift/generated/l10n.dart';
import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/screens/screens.dart';
import 'package:be_thrift/services/services.dart';
import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<CustomUser>(context);
    var settings = Provider.of<SettingsProvider>(context);

    updateStatusBarColor(context);

    return MultiProvider(
      providers: [
        StreamProvider<CustomUser?>.value(
          value: UserDatabaseService(user).userDocument,
          initialData: null,
        ),
      ],
      child: Scaffold(
        body: Consumer<CustomUser?>(
          builder: (context, user, _) => SafeArea(
            child: ListView(
              children: <Widget>[
                const ThriftyAppBar(canGoBack: true),
                const SizedBox(height: 20),
                buildHeader(
                    S.of(context)!.settingsScreenHeaderTitlePreferences),
                buildAccentColorSelector(settings),
                buildAppLanguageSelector(settings),
                buildBiometricsSwitch(settings),
                const Divider(),
                buildHeader(S.of(context)!.settingsScreenHeaderTitleAccount),
                buildNameSetting(user),
                buildEmailSetting(user),
                buildCurrencySetting(user),
                const Divider(),
                buildHeader(S.of(context)!.settingsScreenHeaderTitleDangerZone),
                buildDeleteAccount()
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile buildNameSetting(CustomUser? user) {
    return ListTile(
      leading: Icon(
        Icons.person,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        S.of(context)!.settingsScreenSettingTitleName,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Text(
        user?.name ?? '',
        textAlign: TextAlign.end,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => UpdateNameDialog(
            name: user?.name ?? "",
          ),
        );
      },
    );
  }

  ListTile buildEmailSetting(CustomUser? user) {
    return ListTile(
      enabled: false,
      leading: Icon(
        Icons.mail,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        S.of(context)!.settingsScreenSettingTitleEmailAddress,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: SizedBox(
        width: 150,
        child: Text(
          user?.email ?? '',
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  ListTile buildCurrencySetting(CustomUser? user) {
    return ListTile(
      leading: Icon(
        Icons.monetization_on,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        S.of(context)!.settingsScreenSettingTitleCurrency,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Text(
        '${user?.currency?.symbol} (${user?.currency?.name})',
        textAlign: TextAlign.end,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const CurrencySelectionDialog(),
        );
      },
    );
  }

  Padding buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 4,
      ),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  ListTile buildDeleteAccount() {
    return ListTile(
      leading: Icon(
        Icons.delete_sweep,
        color: Colors.red[800],
      ),
      title: Text(
        S.of(context)!.settingsScreenSettingTitleDeleteAccount,
        style: TextStyle(
          color: Colors.red[800],
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(S.of(context)!.deleteAccountDialogTitle),
            content: Text(S.of(context)!.deleteAccountDialogContent),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(S.of(context)!.deleteAccountDialogButtonTextCancel),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    AuthService().deleteUser();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginScreen.routeName,
                      (route) => false,
                    );
                  } catch (error) {
                    print('Something went wrong, please try again!');
                  }
                },
                child: Text(
                  S.of(context)!.deleteAccountDialogButtonTextDelete,
                  style: TextStyle(
                    color: Colors.red[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  FutureBuilder<bool> buildBiometricsSwitch(SettingsProvider settings) {
    return FutureBuilder<bool>(
      initialData: false,
      future: _localAuth.canCheckBiometrics,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var enabled = snapshot.data ?? false;

          return ListTile(
            enabled: enabled,
            leading: Icon(
              Icons.fingerprint,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              S.of(context)!.settingsScreenSettingTitleBiometric,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              S.of(context)!.settingsScreenSettingTitleBiometricDescription,
            ),
            trailing: Switch(
              value: settings.biometricsEnabled,
              activeColor: Theme.of(context).colorScheme.secondary,
              onChanged: enabled
                  ? (value) {
                      settings.setBiometricsEnabled(value);
                    }
                  : null,
            ),
            onTap: () {
              settings.setBiometricsEnabled(!settings.biometricsEnabled);
            },
          );
        }

        return Container();
      },
    );
  }

  ListTile buildAppLanguageSelector(SettingsProvider settings) {
    return ListTile(
      leading: Icon(
        Icons.language,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        S.of(context)!.settingsScreenSettingTitleLanguage,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: DropdownButton<Locale>(
        onChanged: settings.setAppLanguage,
        value: settings.appLang,
        items: languages
            .map((x) => DropdownMenuItem(
                  value: Locale(x.code),
                  child: Text(x.title),
                ))
            .toList(),
      ),
    );
  }

  ListTile buildAccentColorSelector(SettingsProvider settings) {
    List<Color> colorOptions = [
      const Color(0xFF1B54A9),
      Colors.black,
      Colors.red[800]!,
      Colors.pink[600]!,
      Colors.teal[600]!,
      Colors.green[800]!,
      Colors.deepOrange[800]!,
      Colors.deepPurple[700]!,
    ];

    return ListTile(
      leading: Icon(
        Icons.color_lens,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        S.of(context)!.settingsScreenSettingTitleAccentColor,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: DropdownButton<Color>(
        underline: Container(),
        onChanged: settings.setAccentColor,
        value: settings.accentColor,
        items: colorOptions
            .map(
              (x) => DropdownMenuItem(
                value: x,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: x,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
