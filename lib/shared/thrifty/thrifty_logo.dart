import 'package:flutter/material.dart';

class ThriftyLogo extends StatelessWidget {
  final double size;
  final Color color;

  const ThriftyLogo({
    Key? key,
    required this.size,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(color, BlendMode.modulate),
        child: Image.asset('assets/logos/logo_white.png'),
      ),
    );
  }
}
