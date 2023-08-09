import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';

class AddTransactionFloatingButton extends StatelessWidget {
  const AddTransactionFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const TransactionBottomSheet(),
        );
      },
      elevation: 0,
      splashColor: Colors.white.withOpacity(0.5),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      foregroundColor: Colors.white,
      child: const Icon(
        Icons.add,
        size: 32,
      ),
    );
  }
}
