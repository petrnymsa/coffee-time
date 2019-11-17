import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/cafe.dart';

enum CafeListMode { Location, Search }

class CafeListProvider<WithoutError> extends BaseProvider {
  InMemoryCafeRepository _cafeRepository = InMemoryCafeRepository.instance;

  List<Cafe> _cafes;
  List<Cafe> get cafes => _cafes;

  List<Cafe> _favoriteCafes;
  List<Cafe> get favoriteCafes => _favoriteCafes;

  CafeListMode _mode;
  CafeListMode get mode => _mode;

  LocationEntity _currentLocation;
  LocationEntity get currentLocation => _currentLocation;

  String _searchQuery;
  String get searchQuery => _searchQuery;

  LocationEntity _defaultLocation = LocationEntity(50.105306, 14.389719);

  CafeListProvider() {
    _currentLocation = _defaultLocation;
    _mode = CafeListMode.Location;
  }

  void setLocation(LocationEntity location) {
    _currentLocation = location;
    notifyListeners();
  }

  void resetLocation() {
    _currentLocation = _defaultLocation;
    notifyListeners();
  }

  void refresh() {
    if (_mode == CafeListMode.Location)
      refreshByLocation();
    else
      refreshBySearch(_searchQuery);

    refreshFavorites();
  }

  void refreshByLocation() async {
    _mode = CafeListMode.Location;
    setBusy();
    final _cafeEntities = await _cafeRepository.getByLocation(currentLocation);
    _cafes = _cafeEntities.map((e) => Cafe(e)).toList();
    setReady();
  }

  void refreshBySearch(String search) async {
    setBusy();
    _mode = CafeListMode.Search;
    _searchQuery = search;
    final _cafeEntities = await _cafeRepository.getBySearch(search);
    _cafes = _cafeEntities.map((e) => Cafe(e)).toList();
    setReady();
  }

  void refreshFavorites() async {
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

  Future addTags(CafeDetailEntity detail, List<TagEntity> chosenTags) async {
    await _cafeRepository.addTags(detail, chosenTags);
    refresh();
  }
}
