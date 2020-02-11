import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:flutter/foundation.dart';

class TagEditProvider with ChangeNotifier {
  InMemoryCafeRepository _cafeRepository = InMemoryCafeRepository.instance;

  List<Tag> _addedTags = [];

  Map<String, bool> _reviews = {};

  Map<String, bool> get reviews => _reviews;
  List<Tag> get addedTags => _addedTags;
  List<Tag> entityTags;

  TagEditProvider(this.entityTags);

  List<Tag> _allTags = [];

  List<Tag> get notAddedTagsYet {
    final List<Tag> res = [];
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

  void updateReview(Tag tag, bool review) {
    _reviews[tag.title] = review;
    notifyListeners();
  }

  void addTags(List<Tag> tags) {
    _addedTags = [..._addedTags, ...tags];
    notifyListeners();
  }

  void removeTag(Tag tag) {
    _addedTags.remove(tag);
    notifyListeners();
  }

  void clearTags() {
    _addedTags.clear();
    notifyListeners();
  }

  bool reviewOfTag(Tag tag) {
    return _reviews[tag.title];
  }
}
