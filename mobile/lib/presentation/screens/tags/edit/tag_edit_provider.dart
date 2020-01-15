import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:flutter/foundation.dart';

class TagEditProvider with ChangeNotifier {
  InMemoryCafeRepository _cafeRepository = InMemoryCafeRepository.instance;

  List<TagEntity> _addedTags = [];

  Map<String, bool> _reviews = {};

  Map<String, bool> get reviews => _reviews;
  List<TagEntity> get addedTags => _addedTags;
  List<TagEntity> entityTags;

  TagEditProvider(this.entityTags);

  List<TagEntity> _allTags = [];

  List<TagEntity> get notAddedTagsYet {
    final List<TagEntity> res = [];
    _allTags.forEach((t) {
      if (!entityTags.contains(t) && !_addedTags.contains(t)) {
        res.add(t);
      }
    });
    return res;
  }

  void init() async {
    _allTags = await _cafeRepository.getAllTags();
    entityTags.forEach((t) => _reviews[t.title] = null);
    notifyListeners();
  }

  void updateReview(TagEntity tag, bool review) {
    _reviews[tag.title] = review;
    notifyListeners();
  }

  void addTags(List<TagEntity> tags) {
    _addedTags = [..._addedTags, ...tags];
    notifyListeners();
  }

  void removeTag(TagEntity tag) {
    _addedTags.remove(tag);
    notifyListeners();
  }

  void clearTags() {
    _addedTags.clear();
    notifyListeners();
  }

  bool reviewOfTag(TagEntity tag) {
    return _reviews[tag.title];
  }
}
