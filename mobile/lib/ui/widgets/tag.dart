import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  Tag(this.title, {this.icon, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: color,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
