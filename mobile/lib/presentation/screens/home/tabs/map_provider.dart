// import 'package:coffee_time/data/repositories/cafe_repository.dart';
// import 'package:coffee_time/domain/entities/cafe.dart';
// import 'package:coffee_time/domain/entities/location.dart';
// import 'package:coffee_time/presentation/core/base_provider.dart';
// import 'package:coffee_time/presentation/models/cafe.dart';

// //todo split this to CafeListTab provider, MapProvider and TabProvider
// class MapProvider<WithoutError> extends BaseProvider {
//   InMemoryCafeRepository _cafeRepository = InMemoryCafeRepository.instance;

//   List<Cafe> _cafes;
//   List<Cafe> get cafes => _cafes;

//   LocationEntity _currentLocation;
//   LocationEntity get currentLocation => _currentLocation;

//   String _searchQuery;
//   String get searchQuery => _searchQuery;

//   MapProvider(LocationEntity location) {
//     _currentLocation = location ?? LocationEntity(50.105306, 14.389719);
//   }

//   void refresh() {
//     refreshByLocation();
//   }

//   void refreshByLocation() async {
//     setBusy();
//     final _cafeEntities = await _cafeRepository.getByLocation(currentLocation);
//     _cafes = _cafeEntities.map((e) => Cafe(e)).toList();
//     setReady();
//   }
// }
