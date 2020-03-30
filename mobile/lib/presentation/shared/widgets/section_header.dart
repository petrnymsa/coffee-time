import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> after;

  const SectionHeader({Key key, this.icon, this.title, this.after})
      : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //return LayoutBuilder(builder: (ctx, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FaIcon(icon),
        const SizedBox(
          width: 16.0,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(), //todo constraint it on smaller devices
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
        ),
        if (after != null) ...after
      ],
    );
//    });
  }
}
