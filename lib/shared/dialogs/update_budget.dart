import 'package:be_thrift/generated/l10n.dart';
import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateBudgetDialog extends StatefulWidget {
  final double? initialValue;

  const UpdateBudgetDialog({
    Key? key,
    this.initialValue,
  }) : super(key: key);

  @override
  State<UpdateBudgetDialog> createState() => _UpdateBudgetDialogState();
}

class _UpdateBudgetDialogState extends State<UpdateBudgetDialog> {
  final TextEditingController _budgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _budgetController.text = widget.initialValue!.toStringAsFixed(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<CustomUser>(context);

    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            S.of(context)!.updateBudgetBottomSheetHeadingText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              height: 1.5,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _budgetController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: S.of(context)!.updateBudgetBottomSheetLabelTextBudget,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  UserDatabaseService(user).updateUserBudget(null);
                  Navigator.pop(context);
                },
                //     textColor: Colors.red,
                icon: const Icon(Icons.clear),
                label: Text(
                  S.of(context)!.updateBudgetBottomSheetButtonTextClear,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                //     textColor: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  if (_budgetController.text.isEmpty) return;
                  UserDatabaseService(user).updateUserBudget(
                    double.parse(_budgetController.text),
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check),
                label: Text(
                  S.of(context)!.updateBudgetBottomSheetButtonTextSetBudget,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
