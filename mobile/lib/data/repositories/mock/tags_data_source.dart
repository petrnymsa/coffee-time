import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/entities/tag.dart';
import '../../../domain/entities/tag_reputation.dart';

class MockTagReputationModel {
  final String id;
  final int likes;
  final int dislikes;

  MockTagReputationModel(this.id, this.likes, this.dislikes);
}

class MockTagsDataSource {
  final List<Tag> tags = [
    Tag(id: '1', icon: FontAwesomeIcons.beer, title: 'beer'),
    Tag(id: '2', icon: FontAwesomeIcons.wineBottle, title: 'wine'),
    Tag(id: '3', icon: FontAwesomeIcons.wifi, title: 'wifi'),
    Tag(id: '4', icon: FontAwesomeIcons.dog, title: 'dog friendly'),
  ];

  final Map<String, List<MockTagReputationModel>> cafeTags = {
    '1': [
      MockTagReputationModel('1', 1, 0),
      MockTagReputationModel('3', 4, 1),
    ],
    '2': [
      MockTagReputationModel('2', 1, 0),
      MockTagReputationModel('3', 4, 1),
    ],
    '3': [
      MockTagReputationModel('4', 2, 1),
      MockTagReputationModel('1', 2, 1),
      MockTagReputationModel('3', 1, 1),
    ],
  };

  List<TagReputation> forCafe(String id) {
    final map = cafeTags[id];

    final result = map
        .map((x) => TagReputation(
            id: x.id,
            likes: x.likes,
            dislikes: x.dislikes,
            tag: tags.firstWhere((t) => t.id == x.id, orElse: () => null)))
        .toList();

    return result;
  }
}
