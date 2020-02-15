import '../../core/either.dart';
import '../entities/tag.dart';
import '../entities/tag_reputation.dart';
import '../failure.dart';

abstract class TagRepository {
  Future<Either<List<Tag>, Failure>> getAll();
  Future<Either<Tag, Failure>> getById(String id);
  Future<Either<List<TagReputation>, Failure>> getForCafe(String placeId);
}
