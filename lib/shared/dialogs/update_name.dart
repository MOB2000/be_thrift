import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateNameDialog extends StatefulWidget {
  final String name;

  const UpdateNameDialog({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<UpdateNameDialog> createState() => _UpdateNameDialogState();
}

class _UpdateNameDialogState extends State<UpdateNameDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<CustomUser>(context);

    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          const Text(
            'Please enter a new name for your account',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _nameController,
          ),
          const SizedBox(height: 15),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  UserDatabaseService(user).updateUserName(
                    _nameController.text,
                  );
                  Navigator.pop(context);
                },
                //  textColor: Theme.of(context).colorScheme.secondary,
                icon: const Icon(Icons.sync),
                label: const Text('Update'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
