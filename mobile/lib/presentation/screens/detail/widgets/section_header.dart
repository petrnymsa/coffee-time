import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> after;

  const SectionHeader({Key key, this.icon, this.title, this.after})
      : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(
          width: 16.0,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline,
        ),
        if (after != null) ...after
      ],
    );
  }
}
