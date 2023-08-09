import 'package:be_thrift/generated/l10n.dart';
import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/services/services.dart';
import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:provider/provider.dart';

class DailyTransactionList extends StatelessWidget {
  const DailyTransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<CustomUser?>(context);

    return StreamBuilder<List<Transaction>>(
      stream: TransactionDatabaseService(user).transactions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.isEmpty ?? true) {
            return const NoTransactionsFound();
          }

          if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  'Something has gone horribly wrong, please try again after some time!',
                ),
              ),
            );
          }

          var grouped = TransactionDatabaseService(user)
              .groupTransactionsByDate(snapshot.data!);

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: grouped.keys.length,
            itemBuilder: (context, index) {
              return TransactionList(
                date: grouped.keys.elementAt(index),
                grouped: grouped,
              );
            },
          );
        }

        return Container();
      },
    );
  }
}

class NoTransactionsFound extends StatelessWidget {
  const NoTransactionsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/money_man.png',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(height: 40),
          Text(
            S.of(context)!.homeDailyNoTransactionsTextTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            S.of(context)!.homeDailyNoTransactionsTextSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
