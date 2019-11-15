import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/cafe.dart';

import '../home_provider.dart';

class CafeListProvider extends BaseProvider<WithoutError> {
  InMemoryCafeRepository _cafeRepository = InMemoryCafeRepository.instance;

  List<Cafe> _cafes;
  List<Cafe> get cafes => _cafes;

  HomeFilterMode _mode;
  HomeFilterMode get mode => _mode;

  String _searchQuery;
  String get searchQuery => _searchQuery;

  CafeListProvider() {
    _mode = HomeFilterMode.Location;
  }

  void refresh() {
    if (_mode == HomeFilterMode.Location)
      refreshByLocation();
    else
      refreshBySearch(_searchQuery);
  }

  void refreshByLocation() async {
    _mode = HomeFilterMode.Location;
    setBusy();
    final _cafeEntities = await _cafeRepository.getByLocation(null);
    _cafes = _cafeEntities.map((e) => Cafe(e)).toList();
    setReady();
  }

  void refreshBySearch(String search) async {
    setBusy();
    _mode = HomeFilterMode.Search;
    _searchQuery = search;
    final _cafeEntities = await _cafeRepository.getBySearch(search);
    _cafes = _cafeEntities.map((e) => Cafe(e)).toList();
    setReady();
  }
}
