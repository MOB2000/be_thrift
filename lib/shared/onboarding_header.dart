import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        width: double.infinity,
        height: 200,
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: const ThriftyLogo(
                size: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
