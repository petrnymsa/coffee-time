import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/tag.dart';

class TagChoice extends StatelessWidget {
  final Tag tag;
  final bool selected;
  final Function(bool) onSelected;
  final EdgeInsets innerPadding;
  final EdgeInsets padding;

  const TagChoice(
      {Key key,
      this.tag,
      this.selected,
      this.onSelected,
      this.innerPadding = const EdgeInsets.all(10.0),
      this.padding =
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ChoiceChip(
          padding: innerPadding,
          label: Text(tag.title),
          selected: selected,
          avatar: selected
              ? Icon(
                  FontAwesomeIcons.check,
                  size: 16,
                )
              : Icon(tag.icon, size: 16),
          onSelected: onSelected),
    );
  }
}
