import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tag.dart';
import 'tags_choose_event.dart';
import 'tags_choose_state.dart';

class TagsChooseBloc extends Bloc<TagsChooseBlocEvent, TagsChooseBlocState> {
  final List<Tag> sourceTags;
  final List<Tag> alreadyChosenTags;

  TagsChooseBloc({@required this.sourceTags, this.alreadyChosenTags});

  @override
  TagsChooseBlocState get initialState => Loaded(
        availableTags: sourceTags,
        chosenTags: alreadyChosenTags ?? [],
      );

  @override
  Stream<TagsChooseBlocState> mapEventToState(
      TagsChooseBlocEvent event) async* {
    if (event is ChooseTag) {
      // final wasPresent = state.chosenTags.remove(event.tag);
      // //todo sort?
      // if (wasPresent) {
      //   final availableTags = [...state.availableTags, event.tag];
      //   availableTags.sort((a, b) => a.id.compareTo(b.id));
      //   yield Loaded(
      //       availableTags: availableTags, chosenTags: state.chosenTags);
      // } else {
      //   state.availableTags.remove(event.tag);
      //   final chosenTags = [...state.chosenTags, event.tag];
      //   chosenTags.sort((a, b) => a.id.compareTo(b.id));
      //   yield Loaded(
      //       availableTags: state.availableTags, chosenTags: chosenTags);
      // }

      if (state.chosenTags.contains(event.tag)) {
        yield state.copyWith(
          chosenTags:
              state.chosenTags.where((x) => x.id != event.tag.id).toList(),
        );
      } else {
        final chosen = [...state.chosenTags, event.tag];
        chosen.sort((a, b) => a.id.compareTo(b.id));
        yield state.copyWith(chosenTags: chosen);
      }
    }
  }
}
