import 'package:flutter/material.dart';

class Pricing extends StatelessWidget {
  final int pricing;

  Pricing(this.pricing);

  @override
  Widget build(BuildContext context) {
    if (pricing == 1) {
      return Text("\$");
    } else if (pricing == 2) return Text("\$\$");

    return Text("\$\$\$");
  }
}
