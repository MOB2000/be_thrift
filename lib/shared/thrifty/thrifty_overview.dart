import 'package:be_thrift/config/config.dart';
import 'package:be_thrift/generated/l10n.dart';
import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ThriftyOverview extends StatelessWidget {
  const ThriftyOverview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<CustomUser?>(context);
    var balance = Provider.of<double?>(context);
    var expenses = Provider.of<List<Transaction>?>(context);

    if (user != null && balance != null && expenses != null) {
      return InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => UpdateBudgetDialog(
              initialValue: user.budget ?? 0,
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(25),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context)!.thriftyOverviewTextBalanceHeading,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatAmount(user, balance),
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    (user.budget != null)
                        ? Text(
                            S.of(context)!.thriftyOverviewTextBudgetSet(
                                  user.currency?.symbol,
                                  calculateAbsoluteSum(expenses)
                                      .toStringAsFixed(2),
                                  user.budget?.toStringAsFixed(2),
                                  DateFormat('MMMM y').format(DateTime.now()),
                                ),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text(
                            S.of(context)!.thriftyOverviewTextBudgetUnset,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              (user.budget != null)
                  ? buildBudgetMeter(context, expenses, user)
                  : const Icon(Icons.category, size: 60, color: Colors.white),
            ],
          ),
        ),
      );
    }

    return Container();
  }

  CircleAvatar buildBudgetMeter(
    BuildContext context,
    List<Transaction> expenses,
    CustomUser user,
  ) {
    return CircleAvatar(
      radius: 35,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: (35 - 6).toDouble(),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Text(
          '${((calculateAbsoluteSum(expenses) / (user.budget ?? 1)) * 100).toStringAsFixed(0)}%',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
