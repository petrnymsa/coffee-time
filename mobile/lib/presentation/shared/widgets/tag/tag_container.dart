import 'package:flutter/material.dart';

class TagContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final EdgeInsets padding;
  TagContainer({
    this.title,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF63A69F), //todo hardcoded color
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: title != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 16,
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          : Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
    );
  }
}
