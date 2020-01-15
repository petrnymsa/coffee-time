import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/entities/location.dart';

abstract class CafeService {
  Future<List<CafeEntity>> getNearBy(LocationEntity location);
  Future<CafeDetailEntity> getDetail(String cafeId);
}
