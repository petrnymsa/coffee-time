import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/tag.dart';
import '../../theme.dart';

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
        color: AppTheme.kTagColor,
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
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          : FaIcon(
              tag.icon,
              color: Colors.white,
              size: 16,
            ),
    );
  }
}
