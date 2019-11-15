import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/cafe.dart';

enum HomeFilterMode { Location, Search }

//todo split this to CafeListTab provider, MapProvider and TabProvider
class HomeProvider<WithoutError> extends BaseProvider {
  InMemoryCafeRepository _cafeRepository = InMemoryCafeRepository.instance;

  List<Cafe> _cafes;
  List<Cafe> get cafes => _cafes;

  HomeFilterMode _mode;
  HomeFilterMode get mode => _mode;

  String _searchQuery;
  String get searchQuery => _searchQuery;

  HomeProvider() {
    refreshByLocation();
    _mode = HomeFilterMode.Location;
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
