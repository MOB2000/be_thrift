import 'package:be_thrift/models/models.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/services.dart';

updateStatusBarColor(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Theme.of(context).colorScheme.secondary,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
  ));
}

String formatAmount(CustomUser? user, double amount) {
  return '${amount >= 0 ? '' : '- '}${user?.currency?.symbol} ${amount.abs().toStringAsFixed(2)}'
      .replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  );
}

double calculateAbsoluteSum(List<Transaction> transactions) {
  return transactions.fold<double>(0, (value, txn) => value + txn.amount).abs();
}

String transformCategoryToKey(Category category) {
  return category.name.replaceAll(RegExp(r'[& ]'), '');
}
