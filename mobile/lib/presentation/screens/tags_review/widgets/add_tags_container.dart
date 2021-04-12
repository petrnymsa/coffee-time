import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/tag.dart';
import '../../../../generated/i18n.dart';
import '../../../shared/shared_widgets.dart';
import '../bloc/bloc.dart';

class AddTagsContainer extends StatelessWidget {
  final List<Tag> addedTags;
  final List<Tag> notAddedYet;

  final Function onAddTags;

  const AddTagsContainer({
    Key key,
    @required this.addedTags,
    @required this.notAddedYet,
    @required this.onAddTags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      if (addedTags.length > 0) ..._buildTagsToAdd(context, addedTags),
      if (notAddedYet.length > 0)
        RaisedButton.icon(
          label: Text(I18n.of(context).reviews_add),
          icon: FaIcon(FontAwesomeIcons.plus),
          onPressed: onAddTags,
        ),
    ]);
  }

  Widget _buildTag(BuildContext context, Tag tag) {
    return TagInput(
      tag: tag,
      onDeleted: () =>
          context.read<TagsReviewBloc>().add(RemovedAdded(tagToRemove: tag)),
      onPressed: () =>
          context.read<TagsReviewBloc>().add(RemovedAdded(tagToRemove: tag)),
    );
  }

  List<Widget> _buildTagsToAdd(BuildContext context, List<Tag> addedTags) {
    return <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            I18n.of(context).reviews_chosenTags,
            style: Theme.of(context).textTheme.subhead,
          ),
          FlatButton.icon(
            label: Text(I18n.of(context).reviews_clearTags),
            icon: const FaIcon(Icons.clear_all),
            onPressed: () => _onClearAdded(context),
          )
        ],
      ),
      const Divider(),
      Wrap(
        alignment: WrapAlignment.start,
        spacing: 6.0,
        runSpacing: 0.0,
        children: addedTags.map((t) => _buildTag(context, t)).toList(),
      ),
      const SizedBox(height: 4),
    ];
  }

  void _onClearAdded(BuildContext context) {
    context.read<TagsReviewBloc>().add(ClearAdded());
  }
}
