import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:flutter/foundation.dart';

class FilterProvider with ChangeNotifier {
  CafeListProvider cafeListProvider;

  FilterEntity _filter;

  FilterEntity get filter => _filter;

  List<TagEntity> _allTags = [];

  FilterProvider(this.cafeListProvider);

  List<TagEntity> get notAddedTagsYet {
    final List<TagEntity> res = [];
    _allTags.forEach((t) {
      if (filter.tags == null ||
          filter.tags.length == 0 ||
          !_filter.tags.contains(t)) {
        res.add(t);
      }
    });
    print('all tags: $_allTags');
    print('filter tags: ${filter.tags}');
    print('not yet added: $res');
    return res;
  }

  void init() async {
    _filter = cafeListProvider.currentFilter;
    if (_filter.tags == null) _filter.copyWith(tags: []);
    _allTags = await InMemoryCafeRepository.instance.getAllTags();
    notifyListeners();
  }

  void updateChosenTag(TagEntity tag) {
    _updateFilterTags(tag);

    notifyListeners();
  }

  void updateChosenTags(List<TagEntity> tags) {
    tags.forEach((t) => _updateFilterTags(t));
    notifyListeners();
  }

  void changeOnlyNow(bool value) {
    _filter = _filter.copyWith(onlyOpen: value);
    notifyListeners();
  }

  void clearTags() {
    _filter = _filter.copyWith(tags: []);
    notifyListeners();
  }

  void save() {
    getLogger('Filter Provider').i('Saving filter: $_filter');
    cafeListProvider.updateFilter(
        _filter.copyWith(onlyOpen: _filter.onlyOpen, tags: _filter.tags));
    notifyListeners();
  }

  void _updateFilterTags(TagEntity tag) {
    if (_filter.tags.contains(tag))
      _filter.tags.remove(tag);
    else
      _filter = _filter.copyWith(tags: [..._filter.tags, tag]);
  }
}
