import 'package:flutter/material.dart';

class TransactionTypeSelector extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function()? onPressed;

  const TransactionTypeSelector({
    Key? key,
    required this.title,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Colors.transparent,
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 15,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
