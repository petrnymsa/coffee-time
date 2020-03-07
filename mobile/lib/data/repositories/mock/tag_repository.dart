import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/either.dart';
import '../../../domain/entities/tag.dart';
import '../../../domain/entities/tag_reputation.dart';
import '../../../domain/failure.dart';
import '../../../domain/repositories/tags_repository.dart';

import 'tags_data_source.dart';

class MockedTagRepository implements TagRepository {
  @override
  Future<Either<List<Tag>, Failure>> getAll() {
    return Future.value(Left(tags));
  }

  @override
  Future<Either<Tag, Failure>> getById(String id) {
    final tag = tags.firstWhere((x) => x.id == id, orElse: () => null);

    return Future.value(Left(tag));
  }

  @override
  Future<Either<List<TagReputation>, Failure>> getForCafe(String placeId) {
    return Future.value(Left(forCafe(placeId)));
  }
}
