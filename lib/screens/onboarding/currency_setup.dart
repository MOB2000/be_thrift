import 'package:be_thrift/generated/l10n.dart';
import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/screens/screens.dart';
import 'package:be_thrift/services/currency.dart';
import 'package:be_thrift/services/database/user_db.dart';
import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencySetupScreen extends StatefulWidget {
  static const String routeName = '/currency-setup';

  const CurrencySetupScreen({super.key});

  @override
  _CurrencySetupScreenState createState() => _CurrencySetupScreenState();
}

class _CurrencySetupScreenState extends State<CurrencySetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              const OnboardingHeader(),
              const SizedBox(height: 50),
              Icon(
                Icons.attach_money,
                size: 42,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 15),
              Text(
                S.of(context)!.currencySetupTextHeadline,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              const CurrencyGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyGridView extends StatelessWidget {
  const CurrencyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<CustomUser>(context);
    var currencyProvider = Provider.of<CurrencyProvider>(context);

    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2,
      mainAxisSpacing: 40,
      shrinkWrap: true,
      children: currencyProvider.currencies
          .map((Currency currency) => CurrencyCircle(
              currency: currency,
              onPressed: () async {
                await UserDatabaseService(user).updateUserCurrency(currency);
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              }))
          .toList(),
    );
  }
}

class CurrencyCircle extends StatelessWidget {
  final Currency currency;
  final void Function() onPressed;

  const CurrencyCircle({
    Key? key,
    required this.currency,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      heroTag: currency.name,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      foregroundColor: Colors.white,
      onPressed: onPressed,
      child: Text(
        currency.symbol,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
