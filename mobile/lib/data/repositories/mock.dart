import 'dart:convert';
import 'dart:math';

import 'package:coffee_time/data/models/cafe.dart';
import 'package:coffee_time/domain/entities/comment.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:coffee_time/core/utils/asset_loader.dart' as asset_loader;

class MockData {
  static Uuid uuid = Uuid();
  static Random random = Random();

  Future<List<CafeModel>> readCafeData() async {
    final cafeData = await asset_loader.loadAsset('assets/mock/cafe.json');
    final cafeDataJson = json.decode(cafeData);

    final List<CafeModel> cafes = [];
    for (final cf in cafeDataJson) {
      cafes.add(CafeModel.fromJson(cf));
    }
    return cafes;
  }

  List<CommentEntity> getRandomComments(int max) {
    if (max >= comments.length) max = comments.length - 1;
    comments.shuffle();
    return comments.take(random.nextInt(max) + 1).toList();
  }

  List<TagEntity> mapTags(List<String> keys) {
    final List<TagEntity> tags = [];
    for (final key in keys) {
      tags.add(_tags[key]);
    }
    return tags;
  }

  Map<String, TagEntity> _tags = {
    'wifi': TagEntity(title: 'WiFi', icon: Icons.wifi),
    'beer': TagEntity(title: 'Pivo', icon: FontAwesomeIcons.beer),
    'outside': TagEntity(title: 'Venkovní sezení', icon: FontAwesomeIcons.sun),
    'parking': TagEntity(title: 'Parkování', icon: FontAwesomeIcons.parking),
    'handicap': TagEntity(title: 'Handicap', icon: FontAwesomeIcons.wheelchair),
    'card':
        TagEntity(title: 'Platba kartou', icon: FontAwesomeIcons.creditCard),
    'children':
        TagEntity(title: 'Dětský koutek', icon: FontAwesomeIcons.fortAwesome),
    'dog': TagEntity(title: 'Dog friendly', icon: FontAwesomeIcons.dog),
    'food': TagEntity(title: 'Občerstvení', icon: FontAwesomeIcons.hamburger),
  };

  List<CommentEntity> comments = [
    CommentEntity(
      id: uuid.v4(),
      content: 'Skělé. Zajdeme znovu',
      rating: 5,
      user: 'Jane',
      posted: DateTime.now().add(Duration(days: 250)),
    ),
    CommentEntity(
      id: uuid.v4(),
      content: 'Kafe a prostředí příjemné, pomalejší obsluha',
      rating: 4,
      user: 'Jan Novák',
      posted: DateTime.now().add(Duration(days: 100)),
    ),
    CommentEntity(
      id: uuid.v4(),
      content: 'Denní dávka coffeinu pro přežití dalšího dne.',
      rating: 5,
      user: 'Student FITu',
      posted: DateTime.now().add(Duration(days: 80)),
    ),
    CommentEntity(
      id: uuid.v4(),
      content: 'Doporučuji',
      rating: 4,
      user: 'Karel Tříska',
      posted: DateTime.now().add(Duration(days: 120)),
    ),
    CommentEntity(
      id: uuid.v4(),
      content: 'Nic extra',
      rating: 3,
      user: 'Anet666',
      posted: DateTime.now().add(Duration(days: 40)),
    ),
    CommentEntity(
      id: uuid.v4(),
      content: 'Ok',
      rating: 4,
      user: 'Carlos',
      posted: DateTime.now().add(Duration(days: 8)),
    ),
    CommentEntity(
      id: uuid.v4(),
      content: 'Nespresso, what else? Doporočuji',
      rating: 5,
      user: '',
      posted: DateTime.now().add(Duration(days: 250)),
    ),
    CommentEntity(
      id: uuid.v4(),
      content: 'Skělé. Zajdeme znovu',
      rating: 5,
      user: 'Kafemlejnek123',
      posted: DateTime.now().add(Duration(days: 90)),
    ),
  ];
}
