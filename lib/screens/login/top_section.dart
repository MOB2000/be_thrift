import 'package:be_thrift/shared/shared.dart';
import 'package:flutter/material.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Stack(
          children: <Widget>[
            const Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: ThriftyLogo(size: 100),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 260,
                margin: const EdgeInsets.only(bottom: 40),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Opacity(
                        opacity: 0.25,
                        child: Image.asset(
                          'assets/images/coins.png',
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/money_plant.png',
                        width: 240,
                        height: 240,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Opacity(
                        opacity: 0.25,
                        child: Image.asset(
                          'assets/images/wallet.png',
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
