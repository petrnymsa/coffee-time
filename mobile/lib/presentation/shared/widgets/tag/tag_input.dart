import 'package:coffee_time/domain/entities/tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TagInput extends StatelessWidget {
  final Tag tag;
  final Function onDeleted;
  final Function onPressed;

  const TagInput({Key key, this.tag, this.onDeleted, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputChip(
      padding: const EdgeInsets.all(0.0),
      labelPadding: const EdgeInsets.all(0),
      label: Text(tag.title),
      avatar: Icon(
        tag.icon,
        size: 14,
      ),
      deleteIcon: Icon(FontAwesomeIcons.times, size: 12),
      onDeleted: onDeleted,
      onPressed: onPressed,
    );
  }
}
