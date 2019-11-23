import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TagsContainer extends StatelessWidget {
  final List<TagEntity> tags;

  final Function onEdit;
  const TagsContainer({Key key, @required this.tags, this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionHeader(
          icon: FontAwesomeIcons.tags,
          title: 'Štítky',
        ),
        if (tags.isEmpty)
          Padding(
            padding: EdgeInsets.all(4.0),
            child: Text('Žádné štítky nepřidány.'),
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
                  .map((tag) => TagContainer(title: tag.title, icon: tag.icon))
                  .toList(),
            ),
          ),
        FlatButton.icon(
          label: Text(
            'Navrhnout změnu',
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
