import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/entities/tag_reputation.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/cafe.dart';
import 'package:coffee_time/domain/entities/cafe.dart' as CafeEntity;

enum CafeListMode { Location, Search }

class CafeListProvider<WithoutError> extends BaseProvider {
  InMemoryCafeRepository _cafeRepository = InMemoryCafeRepository.instance;

  List<Cafe> _cafes;
  List<Cafe> get cafes => _cafes;

  Filter _currentFilter = Filter.defaultFilter;

  Filter get currentFilter => _currentFilter;

  List<Cafe> _favoriteCafes;
  List<Cafe> get favoriteCafes => _favoriteCafes;

  CafeListMode _mode;
  CafeListMode get mode => _mode;

  Location _currentLocation;
  Location get currentLocation => _currentLocation;

  String _searchQuery;
  String get searchQuery => _searchQuery;

  Location _defaultLocation = Location(50.105306, 14.389719);

  CafeListProvider() {
    _currentLocation = _defaultLocation;
    _mode = CafeListMode.Location;
  }

  void setLocation(Location location) {
    _currentLocation = location;
    notifyListeners();
  }

  void resetLocation() {
    _currentLocation = _defaultLocation;
    notifyListeners();
  }

  Future refresh() async {
    if (_mode == CafeListMode.Location)
      await refreshByLocation();
    else
      await refreshBySearch(_searchQuery);

    await refreshFavorites();
  }

  Future refreshByLocation() async {
    _mode = CafeListMode.Location;
    setBusy();
    final List<CafeEntity.Cafe> _cafeEntities = await _cafeRepository
        .getByLocation(currentLocation, filter: _currentFilter);
    _cafes = _cafeEntities.map((e) => Cafe(e)).toList();
    setReady();
  }

  Future refreshBySearch(String search) async {
    setBusy();
    _mode = CafeListMode.Search;
    _searchQuery = search;
    final _cafeEntities =
        await _cafeRepository.getBySearch(search, filter: _currentFilter);
    _cafes = _cafeEntities.map((e) => Cafe(e)).toList();
    setReady();
  }

  Future refreshFavorites() async {
    setBusy();
    final favList = await _cafeRepository.getFavorites();
    _favoriteCafes = favList
        .map((f) => Cafe(f))
        .toList(); //cafes.where((f) => f.entity.isFavorite).toList();
    setReady();
  }

  void toggleFavorite(Cafe entity) async {
    entity.toggleFavorite();
    refresh();
  }

  Future addTags(CafeDetail detail, List<TagReputation> chosenTags) async {
    await _cafeRepository.addTags(detail, chosenTags);
    refresh();
  }

  void updateFilter(Filter filter) async {
    _currentFilter = filter;
    await refresh();
    notifyListeners();
  }

  double getDistance(CafeEntity.Cafe cafeEntity) {
    return currentLocation.distance(cafeEntity.location);
  }
}
