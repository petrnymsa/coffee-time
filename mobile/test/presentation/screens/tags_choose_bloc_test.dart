import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/screens/tags_choose/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final allTags = <Tag>[
    Tag(id: '1', title: 't1', icon: Icons.message),
    Tag(id: '2', title: 't2', icon: Icons.message),
    Tag(id: '3', title: 't3', icon: Icons.message)
  ];

  blocTest(
    'choose tag when empty',
    build: () async => TagsChooseBloc(sourceTags: allTags),
    act: (TagsChooseBloc bloc) async => bloc.add(ChooseTag(tag: allTags[0])),
    expect: [
      Loaded(availableTags: allTags, chosenTags: [allTags[0]])
    ],
  );

  //todo sort??
  blocTest(
    'choose tag already chosen',
    build: () async =>
        TagsChooseBloc(sourceTags: allTags, alreadyChosenTags: [allTags[0]]),
    act: (TagsChooseBloc bloc) async => bloc.add(ChooseTag(tag: allTags[0])),
    expect: [Loaded(availableTags: allTags, chosenTags: [])],
  );
}
