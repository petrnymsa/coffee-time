import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../core/app_logger.dart';
import '../../../di_container.dart';
import '../../../domain/entities/cafe.dart';
import '../../../domain/entities/tag_reputation.dart';
import '../../shared/shared_widgets.dart';
import '../tags_review/bloc/bloc.dart' as review_bloc;
import '../tags_review/screen.dart';
import 'bloc/detail_bloc.dart';
import 'bloc/detail_bloc_event.dart';
import 'bloc/detail_bloc_state.dart';
import 'widgets/widgets.dart';

class DetailScreen extends StatelessWidget {
  final Logger logger = getLogger('DetailScreen');

  DetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailBloc, DetailBlocState>(
        builder: (context, state) {
          return state.when(
            loading: () => CircularLoader(),
            failure: (message) => FailureMessage(message: message),
            loaded: (cafe, detail) => DetailContainer(
              logger: logger,
              cafe: cafe,
              detail: detail,
              onTagsEdit: () => _onTagsEditRequest(context, cafe),
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<DetailBloc, DetailBlocState>(
        builder: (context, state) => state.maybeWhen(
            loaded: (cafe, detail) => FavoriteButton(cafe: cafe),
            orElse: () => Container(width: 0.0, height: 0.0)),
      ),
    );
  }

  void _onTagsEditRequest(BuildContext context, Cafe cafe) async {
    final tagsToUpdate = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider<review_bloc.TagsReviewBloc>(
          child: TagsReviewScreen(),
          create: (context) => review_bloc.TagsReviewBloc(
              tagsToReview: cafe.tags.map((x) => x.tag).toList(),
              tagRepository: sl())
            ..add(review_bloc.Load()),
        ),
      ),
    );

    if (tagsToUpdate != null) {
      context
          .bloc<DetailBloc>()
          .add(UpdateTags(id: cafe.placeId, tags: tagsToUpdate));
    }
  }
}
