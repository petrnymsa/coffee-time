import 'package:coffee_time/data/services/cafe_service.dart';
import 'package:coffee_time/data/services/cafe_service_memory.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/location.dart';

abstract class CafeRepository {
  Future<List<CafeEntity>> getByLocation(LocationEntity location);
}

class InMemoryCafeRepository implements CafeRepository {
  final CafeService _cafeService = InMemoryCafeService(); //todo get_it()

  @override
  Future<List<CafeEntity>> getByLocation(LocationEntity location) {
    return _cafeService.getNearBy(location); //todo handle exception, etc.
  }
}
