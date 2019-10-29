import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final IconData icon;
  final String title;

  Tag(this.title, {this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Row(
        children: [
          if (this.icon != null) Icon(icon),
          Text(this.title, style: TextStyle(fontSize: 12))
        ],
      ),
    );
  }
}
