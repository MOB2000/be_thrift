import 'package:be_thrift/config/utils.dart';
import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/services/services.dart';
import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    var user = Provider.of<CustomUser?>(context);
    updateStatusBarColor(context);

    if (user != null) {
      return MultiProvider(
        providers: [
          StreamProvider<CustomUser?>.value(
            value: UserDatabaseService(user).userDocument,
            initialData: null,
          ),
          StreamProvider<double>.value(
            value: TransactionDatabaseService(user).balance,
            initialData: 0,
          ),
          StreamProvider<List<Transaction>>.value(
            value: TransactionDatabaseService(user)
                .expensesByMonth(DateTime.now()),
            initialData: const [],
          ),
        ],
        child: Scaffold(
          key: scaffoldKey,
          drawer: const Drawer(
            child: ThriftyDrawer(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: const AddTransactionFloatingButton(),
          body: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const ThriftyAppBar(),
                Expanded(
                  child: ListView(
                    children: const <Widget>[
                      ThriftyOverview(),
                      DailyTransactionList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
