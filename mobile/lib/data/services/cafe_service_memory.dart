import 'package:coffee_time/data/services/cafe_service.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/photo.dart';
import 'package:uuid/uuid.dart';

class InMemoryCafeService implements CafeService {
  @override
  Future<CafeDetailEntity> getDetail(String cafeId) {
    // TODO: implement getDetail
    throw Exception('getDetail not implemented yet');
  }

  @override
  Future<List<CafeEntity>> getNearBy(LocationEntity location) {
    //todo implement 'find by location'
    return Future.delayed(Duration(milliseconds: 600), () {
      return _cafes;
    });
  }

  static Uuid uuid = Uuid();

  static PhotoEntity _photo() => PhotoEntity(reference: uuid.v4());
  static LocationEntity _location() => LocationEntity(17.56, 20.53);

  List<CafeEntity> _cafes = [
    CafeEntity(
        id: uuid.v4(),
        name: 'Archicafé',
        address: 'Thákurova 9',
        rating: 4.7,
        photo: _photo(),
        openNow: true,
        location: _location(),
        tags: []),
    CafeEntity(
        id: uuid.v4(),
        name: 'Cafe Prostoru_',
        address: 'Technická 270/6',
        rating: 4.3,
        photo: _photo(),
        openNow: true,
        location: _location(),
        tags: []),
    CafeEntity(
        id: uuid.v4(),
        name: 'Estella CAFÉ',
        address: 'Nám. Interbrigády',
        rating: 3.2,
        photo: _photo(),
        openNow: true,
        location: _location(),
        tags: []),
  ];
}
