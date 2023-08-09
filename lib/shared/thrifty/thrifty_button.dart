import 'package:flutter/material.dart';

class ThriftyButton extends StatefulWidget {
  final String title;
  final void Function()? onPressed;

  const ThriftyButton({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  State<ThriftyButton> createState() => _ThriftyButtonState();
}

class _ThriftyButtonState extends State<ThriftyButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        //   padding: const EdgeInsets.symmetric(horizontal: 30),
        // color: Theme.of(context).colorScheme.secondary,
        //disabledColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              width: 28,
              height: 28,
              child: Image.asset('assets/images/double_arrow.png'),
            ),
          ],
        ),
      ),
    );
  }
}
