import '../../core/either.dart';
import '../entities/tag.dart';
import '../failure.dart';

abstract class TagRepository {
  Future<Either<List<Tag>, Failure>> getAll();
  Future<Either<Tag, NotFound>> getById(String id);
}
