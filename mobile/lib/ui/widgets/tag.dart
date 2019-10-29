import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  Color _darkerColor;
  Tag(this.title, {this.icon, this.color = Colors.black}) {
    const reduce = 40;
    _darkerColor = color
        .withBlue(color.blue - reduce)
        .withGreen(color.green - reduce)
        .withRed(color.red - reduce);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: color,
        // border: Border.all(color: _darkerColor, width: 1.0),
      ),
      child: Row(
        children: [
          if (this.icon != null)
            Icon(
              icon,
              color: Colors.white,
            ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              this.title,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
