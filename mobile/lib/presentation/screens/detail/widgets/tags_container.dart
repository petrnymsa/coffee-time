import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/tag_reputation.dart';
import '../../../shared/shared_widgets.dart';

class TagsContainer extends StatelessWidget {
  final List<TagReputation> tags;

  final Function onEdit;
  const TagsContainer({Key key, @required this.tags, this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionHeader(
          icon: FontAwesomeIcons.tags,
          title: 'Štítky', //todo translate
        ),
        if (tags.isEmpty)
          Padding(
            padding: EdgeInsets.all(4.0),
            child: Text('Žádné štítky nepřidány.'), //todo translate
          ),
        if (tags.isNotEmpty)
          SizedBox(
            height: 20.0,
          ),
        if (tags.isNotEmpty)
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              spacing: 5.0,
              runSpacing: 5.0,
              children: tags
                  .map((x) => TagContainer(
                        title: x.tag.title,
                        icon: x.tag.icon,
                      ))
                  .toList(),
            ),
          ),
        FlatButton.icon(
          label: Text(
            'Navrhnout změnu', //todo translate
            style: TextStyle(fontSize: 14),
          ),
          icon: Icon(
            FontAwesomeIcons.edit,
            size: 16,
          ),
          onPressed: onEdit,
        )
      ],
    );
  }
}
