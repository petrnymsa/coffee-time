import 'package:flutter/material.dart';

class Pricing extends StatelessWidget {
  final pricing;

  Pricing(this.pricing);

  @override
  Widget build(BuildContext context) {
    if (this.pricing == 1)
      return Text("\$");
    else if (this.pricing == 2) return Text("\$\$");

    return Text("\$\$\$");
  }
}
