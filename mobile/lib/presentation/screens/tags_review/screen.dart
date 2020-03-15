import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/entities/tag.dart';
import '../../../generated/i18n.dart';
import '../../shared/shared_widgets.dart';
import '../tags_choose/bloc/bloc.dart';
import '../tags_choose/screen.dart';
import 'bloc/bloc.dart';
import 'model/tag_review.dart';
import 'widgets/widgets.dart';

class TagsReviewScreen extends StatelessWidget {
  void _onTagReview(
      BuildContext context, String tagId, TagReviewKind reviewKind) {
    context
        .bloc<TagsReviewBloc>()
        .add(ReviewTag(id: tagId, review: reviewKind));
  }

  void _onAddTags(BuildContext context, List<Tag> notAddedYet) async {
    final addedTags = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<TagsChooseBloc>(
          child: TagsChooseScreen(),
          create: (context) =>
              //todo get from DI
              TagsChooseBloc(sourceTags: notAddedYet),
        ),
      ),
    );

    if (addedTags != null) {
      context.bloc<TagsReviewBloc>().add(AddTags(tagsToAdd: addedTags));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(I18n.of(context).reviews_title)),
      body: BlocBuilder<TagsReviewBloc, TagsReviewBlocState>(
        builder: (context, state) => state.when(
          loading: () => CircularLoader(),
          loaded: (addedTags, tagsToReview, notAddedYet) => Container(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (tagsToReview.isNotEmpty)
                    ReviewsContainer(
                      tagsToReview: tagsToReview,
                      onTagReview: (tagId, reviewKind) =>
                          _onTagReview(context, tagId, reviewKind),
                    ),
                  AddTagsContainer(
                    addedTags: addedTags,
                    notAddedYet: notAddedYet,
                    onAddTags: () => _onAddTags(context, notAddedYet),
                  ),
                  FullWidthButton(
                    text: I18n.of(context).confirm,
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
        ),
      ),
    );
  }
}
