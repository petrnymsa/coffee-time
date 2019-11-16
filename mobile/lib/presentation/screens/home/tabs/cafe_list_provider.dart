// import 'package:coffee_time/data/repositories/cafe_repository.dart';
// import 'package:coffee_time/domain/entities/cafe.dart';
// import 'package:coffee_time/domain/entities/location.dart';
// import 'package:coffee_time/presentation/core/base_provider.dart';
// import 'package:coffee_time/presentation/models/cafe.dart';

// enum CafeListMode { Location, Search }

// //todo split this to CafeListTab provider, MapProvider and TabProvider
// class CafeListProvider<WithoutError> extends BaseProvider {
//   InMemoryCafeRepository _cafeRepository = InMemoryCafeRepository.instance;

//   List<Cafe> _cafes;
//   List<Cafe> get cafes => _cafes;

//   CafeListMode _mode;
//   CafeListMode get mode => _mode;

//   LocationEntity _currentLocation;
//   LocationEntity get currentLocation => _currentLocation;

//   String _searchQuery;
//   String get searchQuery => _searchQuery;

//   CafeListProvider() {
//     _currentLocation = LocationEntity(50.105306, 14.389719);
//     _mode = CafeListMode.Location;
//   }

//   void refresh() {
//     if (_mode == CafeListMode.Location)
//       refreshByLocation();
//     else
//       refreshBySearch(_searchQuery);
//   }

//   void refreshByLocation() async {
//     _mode = CafeListMode.Location;
//     setBusy();
//     final _cafeEntities = await _cafeRepository.getByLocation(currentLocation);
//     _cafes = _cafeEntities.map((e) => Cafe(e)).toList();
//     setReady();
//   }

//   void refreshBySearch(String search) async {
//     setBusy();
//     _mode = CafeListMode.Search;
//     _searchQuery = search;
//     final _cafeEntities = await _cafeRepository.getBySearch(search);
//     _cafes = _cafeEntities.map((e) => Cafe(e)).toList();
//     setReady();
//   }
// }
