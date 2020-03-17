import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../generated/i18n.dart';
import '../../../shared/shared_widgets.dart';
import '../../tags_choose/bloc/bloc.dart';
import '../../tags_choose/screen.dart';
import '../bloc/bloc.dart';

class TagsContainer extends StatelessWidget {
  final FilterBlocState state;
  const TagsContainer({
    Key key,
    @required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SectionHeader(
            icon: FontAwesomeIcons.tags,
            title: I18n.of(context).filter_tags_title,
          ),
          const SizedBox(height: 6.0),
          Text(I18n.of(context).filter_tags_info),
          if (state.addedTags != null) ..._buildTagsToAdd(context),
          if (state.notAddedTags.length > 0)
            RaisedButton.icon(
              label: Text(I18n.of(context).filter_tags_chooseTags),
              icon: Icon(FontAwesomeIcons.plus),
              onPressed: () async {
                final addedTags =
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              child: TagsChooseScreen(),
                              create: (context) => TagsChooseBloc(
                                  sourceTags: state.notAddedTags),
                            )));
                if (addedTags != null) {
                  context.bloc<FilterBloc>().add(AddTags(tags: addedTags));
                }
              },
            ),
        ],
      ),
    );
  }

  List<Widget> _buildTagsToAdd(BuildContext context) {
    return <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            I18n.of(context).filter_tags_chosenTags,
            style: Theme.of(context).textTheme.subhead,
          ),
          FlatButton.icon(
            label: Text(I18n.of(context).filter_tags_clear),
            icon: Icon(Icons.clear_all),
            onPressed: () => context.bloc<FilterBloc>().add(ClearTags()),
          )
        ],
      ),
      Divider(),
      Wrap(
        alignment: WrapAlignment.start,
        spacing: 6.0,
        runSpacing: 0.0,
        children: state.addedTags
            .map(
              (t) => TagInput(
                tag: t,
                onDeleted: () =>
                    context.bloc<FilterBloc>().add(RemoveTag(tagId: t.id)),
                onPressed: () =>
                    context.bloc<FilterBloc>().add(RemoveTag(tagId: t.id)),
              ),
            )
            .toList(),
      ),
      const SizedBox(height: 4),
    ];
  }
}
