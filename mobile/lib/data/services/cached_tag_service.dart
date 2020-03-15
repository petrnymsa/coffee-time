import 'package:flutter/foundation.dart';

import '../../core/cached_value.dart';
import '../../core/time_provider.dart';
import '../models/tag.dart';
import '../models/tag_reputation.dart';
import 'tag_service.dart';

class CachedTagService implements TagService {
  final TagService _proxy;
  final TimeProvider timeProvider;

  CachedValue<List<TagModel>> _allTags;

  CachedTagService({
    @required TagService tagService,
    @required this.timeProvider,
  }) : _proxy = tagService {
    _allTags = CachedValue(
      _getAllTags,
      timeProvider: timeProvider,
      durability: Duration(minutes: 15),
    );
  }

  Future<List<TagModel>> _getAllTags() {
    return _proxy.getAll();
  }

  @override
  Future<List<TagModel>> getAll() {
    return _allTags.get();
  }

  @override
  Future<List<TagReputationModel>> getForCafe(String placeId) {
    return _proxy.getForCafe(placeId);
  }
}
