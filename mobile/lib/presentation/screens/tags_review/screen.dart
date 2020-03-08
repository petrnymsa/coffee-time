import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/app_logger.dart';
import '../../../domain/entities/tag.dart';
import '../../shared/shared_widgets.dart';
import '../tags_choose/bloc/bloc.dart';
import '../tags_choose/screen.dart';
import 'bloc/bloc.dart';
import 'model/tag_review.dart';
import 'widgets/widgets.dart';

class TagsReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navrhnout změnu')),
      body: BlocBuilder<TagsReviewBloc, TagsReviewBlocState>(
          builder: (context, state) => state.when(
                loading: () => CircularLoader(),
                loaded: (addedTags, tagsToReview, notAddedYet) => Container(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        HeaderInfo(),
                        ReviewsTable(
                          tagsToReview: tagsToReview,
                          onTagReview: (tagId, reviewKind) =>
                              _onTagReview(context, tagId, reviewKind),
                        ),
                        // * add more
                        if (addedTags.length > 0)
                          ..._buildTagsToAdd(context, addedTags),
                        if (notAddedYet.length > 0)
                          RaisedButton.icon(
                            label: Text('Přidat štítky'),
                            icon: Icon(FontAwesomeIcons.plus),
                            onPressed: () async {
                              final addedTags =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider<TagsChooseBloc>(
                                    child: TagsChooseScreen(),
                                    create: (context) =>
                                        TagsChooseBloc(sourceTags: notAddedYet),
                                  ),
                                ),
                              );

                              getLogger('TagsReview')
                                  .i('addedTags = $addedTags');

                              context
                                  .bloc<TagsReviewBloc>()
                                  .add(AddTags(tagsToAdd: addedTags));
                            },
                          ),
                        FullWidthButton(
                          text: 'Potvrdit',
                          color: Colors.green,
                          icon: Icon(FontAwesomeIcons.check),
                          onPressed: () async {
                            final updates =
                                context.bloc<TagsReviewBloc>().getUpdates();
                            Navigator.of(context).pop(updates);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  void _onTagReview(
      BuildContext context, String tagId, TagReviewKind reviewKind) {
    context
        .bloc<TagsReviewBloc>()
        .add(ReviewTag(id: tagId, review: reviewKind));
  }

  Widget _buildTag(BuildContext context, Tag tag) {
    return TagInput(
      tag: tag,
      onDeleted: () =>
          context.bloc<TagsReviewBloc>().add(RemovedAdded(tagToRemove: tag)),
      onPressed: () =>
          context.bloc<TagsReviewBloc>().add(RemovedAdded(tagToRemove: tag)),
    );
  }

  List<Widget> _buildTagsToAdd(BuildContext context, List<Tag> addedTags) {
    return <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Štítky k přidání',
            style: Theme.of(context).textTheme.subhead,
          ),
          FlatButton.icon(
            label: Text('Vyčistit'),
            icon: Icon(Icons.clear_all),
            onPressed: () {},
          )
        ],
      ),
      Divider(),
      Wrap(
        alignment: WrapAlignment.start,
        spacing: 6.0,
        runSpacing: 0.0,
        children: addedTags.map((t) => _buildTag(context, t)).toList(),
      ),
      const SizedBox(
        height: 4,
      ),
    ];
  }
}
