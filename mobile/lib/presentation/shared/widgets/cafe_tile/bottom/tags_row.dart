import 'package:flutter/material.dart';

import '../../../../../domain/entities/tag_reputation.dart';
import '../../../shared_widgets.dart';

class TagsRow extends StatelessWidget {
  final List<TagReputation> tags;

  const TagsRow({
    Key key,
    @required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, top: 8.0),
      child: Row(
        children: tags
            .map((t) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TagContainer(
                    tag: t.tag,
                    onlyIcon: true,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
