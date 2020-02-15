import 'package:meta/meta.dart';

import '../../core/either.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/tag_reputation.dart';
import '../../domain/exceptions/api.dart';
import '../../domain/failure.dart';
import '../../domain/repositories/tags_repository.dart';
import '../services/tag_service.dart';

//ignore_for_file: avoid_catches_without_on_clauses
class TagRepositoryImpl implements TagRepository {
  static const String serviceFailedMessage = 'Service call failed';

  final TagService tagService;

  List<Tag> _cachedTags;

  TagRepositoryImpl({@required this.tagService});

  Future<List<Tag>> _getAllTags() async {
    //todo add cache store, use Facade pattern - ideally about 10 minutes
    final tagModels = await tagService.getAll();
    final tags = tagModels.map((x) => x.toEntity()).toList();
    _cachedTags = tags;
    return tags;
  }

  @override
  Future<Either<List<Tag>, Failure>> getAll() async {
    try {
      final tags = await _getAllTags();

      return Left(tags);
    } on ApiException catch (e) {
      return Right(ServiceFailure(serviceFailedMessage, inner: e));
    } catch (e) {
      return Right(CommonFailure(e));
    }
  }

  @override
  Future<Either<List<TagReputation>, Failure>> getForCafe(
      String placeId) async {
    try {
      if (_cachedTags == null) {
        await _getAllTags();
      }

      final reputations = await tagService.getForCafe(placeId);

      final result = reputations.map((r) {
        final tag = _cachedTags.firstWhere((t) => t.id == r.id);
        return r.toEntity(tag);
      }).toList();

      return Left(result);
    } on ApiException catch (e) {
      return Right(ServiceFailure(serviceFailedMessage, inner: e));
    } catch (e) {
      return Right(CommonFailure(e));
    }
  }

  @override
  Future<Either<Tag, Failure>> getById(String id) async {
    try {
      if (_cachedTags == null) {
        await _getAllTags();
      }

      final tag = _cachedTags.firstWhere((t) => t.id == id, orElse: () => null);

      if (tag == null) {
        return Right(NotFound());
      }

      return Left(tag);
    } on ApiException catch (e) {
      return Right(ServiceFailure(serviceFailedMessage, inner: e));
    } catch (e) {
      return Right(CommonFailure(e));
    }
  }
}
