import 'package:flutter/material.dart';

class TagContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool showTitle;
  TagContainer({this.title, this.icon, this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: const Color(0xFF63A69F), //todo hardcoded color
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: showTitle
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (this.icon != null)
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 16,
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
            )
          : Icon(
              icon,
              color: Colors.white,
            ),
    );
  }
}
