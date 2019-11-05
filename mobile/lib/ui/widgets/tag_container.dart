import 'package:flutter/material.dart';

class TagContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  TagContainer({this.title, this.icon, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: const Color(0xFF63A69F),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
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
