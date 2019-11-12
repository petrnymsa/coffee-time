import 'dart:math';

import 'package:coffee_time/domain/entities/comment.dart';
import 'package:uuid/uuid.dart';

class MockData {
  static Uuid uuid = Uuid();
  static Random random = Random();
  List<CommentEntity> getRandomComments(int max) {
    if (max >= comments.length) max = comments.length - 1;
    comments.shuffle();
    return comments.take(random.nextInt(max) + 1).toList();
  }

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
