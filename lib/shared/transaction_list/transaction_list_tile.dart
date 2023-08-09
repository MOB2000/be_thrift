import 'package:be_thrift/config/config.dart';
import 'package:be_thrift/generated/l10n.dart';
import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/services/services.dart';
import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionListTile extends StatelessWidget {
  final Transaction transaction;

  TransactionListTile(this.transaction) : super(key: Key(transaction.id));

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<CustomUser>(context);

    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          TransactionDatabaseService(user).deleteTransaction(transaction);
        }
      },
      background: buildRightSwipeBackground(),
      child: InkWell(
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => TransactionBottomSheet(
              transaction: transaction,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.15),
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                buildCategoryIcon(),
                const SizedBox(width: 10),
                Expanded(child: buildMeta(context)),
                buildAmount(user),
              ],
            ),
          ),
        ),
      ),
    );

  }

  Container buildRightSwipeBackground() {
    return Container(
      color: Colors.red,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Container buildCategoryIcon() {
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      child: Image.asset('assets/categories/${transaction.category.icon}'),
    );
  }

  Column buildMeta(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S
              .of(context)!
              .categoryName(transformCategoryToKey(transaction.category)),
          style: transactionTitleStyle,
        ),
        const SizedBox(height: 2),
        Row(
          children: <Widget>[
            Text(
              DateFormat().add_jm().format(transaction.timestamp),
              style: transactionSubtitleStyle,
            ),
            (transaction.description != null)
                ? Expanded(
                    flex: 1,
                    child: Text(
                      ' / ${transaction.description ?? ""}',
                      overflow: TextOverflow.ellipsis,
                      style: transactionSubtitleStyle,
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  Text buildAmount(CustomUser user) {
    return Text(
      formatAmount(user, transaction.amount),
      style: transactionAmountStyle(
        (transaction.amount > 0) ? Colors.green[400]! : Colors.red[700]!,
      ),
    );
  }
}

class DateLabel extends StatelessWidget {
  final String date;

  const DateLabel(this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      date.toUpperCase(),
      style: const TextStyle(
        fontSize: 13,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
