import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ThriftyAppBar extends StatefulWidget {
  final bool canGoBack;
  final bool hideAccount;

  const ThriftyAppBar({
    Key? key,
    this.canGoBack = false,
    this.hideAccount = false,
  }) : super(key: key);

  @override
  State<ThriftyAppBar> createState() => _ThriftyAppBarState();
}

class _ThriftyAppBarState extends State<ThriftyAppBar> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<CustomUser?>(context);

    return SizedBox(
      height: 120,
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          widget.canGoBack
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.arrow_back_ios),
                )
              : IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.menu),
                ),
          const SizedBox(width: 10),
          ThriftyLogo(
            size: 80,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const Spacer(),
          widget.hideAccount ? Container() : buildCircleAvatar(user),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget buildCircleAvatar(CustomUser? user) {
    if (user != null && user.photoURL.isNotEmpty) {
      return SizedBox(
        width: 50,
        child: ClipOval(
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: user.photoURL,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    return Container();
  }
}
