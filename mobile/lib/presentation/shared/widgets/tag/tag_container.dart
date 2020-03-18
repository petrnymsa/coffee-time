import 'package:flutter/material.dart';

import '../../../../domain/entities/tag.dart';

class TagContainer extends StatelessWidget {
  final Tag tag;
  final bool onlyIcon;
  final EdgeInsets padding;
  TagContainer({
    this.tag,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
    this.onlyIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF63A69F), //todo hardcoded color
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: !onlyIcon
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (tag.icon != null)
                  Icon(
                    tag.icon,
                    color: Colors.white,
                    size: 16,
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    tag.translatedTitle,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          : Icon(
              tag.icon,
              color: Colors.white,
              size: 16,
            ),
    );
  }
}
