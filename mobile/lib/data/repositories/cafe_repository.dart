import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/photo.dart';
import 'package:coffee_time/domain/repositories/cafe_repository.dart';
import 'package:uuid/uuid.dart';

class InMemoryCafeRepository implements CafeRepository {
  @override
  Future<List<CafeEntity>> getByLocation(LocationEntity location) {
    return Future.delayed(Duration(milliseconds: 500), () => _cafes);
  }

  static Uuid uuid = Uuid();
  static String photo_url =
      "https://static8.fotoskoda.cz/data/cache/thumb_700-392-24-0-1/articles/2317/1542705898/fotosoutez_prostor_ntk_cafe_prostoru_uvod.jpg";

  static PhotoEntity _photo() => PhotoEntity(url: photo_url);
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
