import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FullWidthButton extends StatelessWidget {
  final String text;
  final Color color;
  final Icon icon;
  final Function onPressed;
  final EdgeInsets padding;
  const FullWidthButton(
      {Key key,
      this.text,
      this.color,
      this.icon,
      this.onPressed,
      this.padding =
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: padding,
        child: RaisedButton.icon(
          color: color,
          label: Text(text),
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
