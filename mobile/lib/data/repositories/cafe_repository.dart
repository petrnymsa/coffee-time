import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/entities/comment.dart';
import 'package:coffee_time/domain/entities/contact.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/photo.dart';
import 'package:coffee_time/domain/repositories/cafe_repository.dart';
import 'package:uuid/uuid.dart';

import 'mock.dart';

class InMemoryCafeRepository implements CafeRepository {
  @override
  Future<List<CafeEntity>> getByLocation(LocationEntity location) {
    return Future.delayed(Duration(milliseconds: 500), () => _cafes);
  }

  @override
  Future<CafeDetailEntity> getDetail(String id) {
    return Future.delayed(Duration(milliseconds: 200), () => _cafeDetails[id]);
  }

  static Uuid uuid = Uuid();

  static PhotoEntity _photo(String url) => PhotoEntity(url: url);
  static LocationEntity _location() => LocationEntity(17.56, 20.53);

  static MockData mock = MockData();

  static List<CafeEntity> _cafes = [
    CafeEntity(
        id: "1",
        name: 'Archicafé',
        address: 'Thákurova 9',
        rating: 4.7,
        photos: [
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/ab243c8c-2719-4986-b869-d83256692e17.jpg"),
        ],
        openNow: true,
        location: _location(),
        tags: []),
    CafeEntity(
        id: "2",
        name: 'Cafe Prostoru_',
        address: 'Technická 270/6',
        rating: 4.3,
        photos: [
          _photo(
              "https://static8.fotoskoda.cz/data/cache/thumb_700-392-24-0-1/articles/2317/1542705898/fotosoutez_prostor_ntk_cafe_prostoru_uvod.jpg"),
        ],
        openNow: true,
        location: _location(),
        tags: []),
    CafeEntity(
        id: "3",
        name: 'Estella CAFÉ',
        address: 'Nám. Interbrigády',
        rating: 3.2,
        photos: [
          _photo(
              "https://media-cdn.tripadvisor.com/media/photo-s/14/98/8f/1e/interier.jpg"),
        ],
        openNow: true,
        location: _location(),
        tags: []),
  ];

  Map<String, CafeDetailEntity> _cafeDetails = {
    "1": CafeDetailEntity.fromCafe(_cafes[0],
        contact: ContactEntity(
          address: _cafes[0].address,
          phone: '111 222 333',
        ),
        comments: mock.getRandomComments(3),
        additionalPhotos: [
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/c3860f08-c013-48cd-bdf2-7819843ad579.jpg"),
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/a6099310-6f4e-447e-b7a7-e8c073d3b0ea.jpg"),
        ]),
    "2": CafeDetailEntity.fromCafe(_cafes[1],
        contact: ContactEntity(
          address: _cafes[0].address,
          phone: '111 222 333',
          website: 'https://cafe.prostoru.cz',
        ),
        comments: mock.getRandomComments(3),
        additionalPhotos: [
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/c3860f08-c013-48cd-bdf2-7819843ad579.jpg"),
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/a6099310-6f4e-447e-b7a7-e8c073d3b0ea.jpg"),
        ]),
    "3": CafeDetailEntity.fromCafe(_cafes[2],
        contact: ContactEntity(
          address: _cafes[0].address,
          phone: '111 222 333',
        ),
        comments: mock.getRandomComments(3),
        additionalPhotos: [
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/c3860f08-c013-48cd-bdf2-7819843ad579.jpg"),
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/a6099310-6f4e-447e-b7a7-e8c073d3b0ea.jpg"),
        ]),
  };
}
