import 'dart:math';

import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/data/models/cafe.dart';
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
  static InMemoryCafeRepository _instance;

  static InMemoryCafeRepository get instance {
    if (_instance == null) _instance = InMemoryCafeRepository();

    return _instance;
  }

  @override
  Future<List<CafeEntity>> getByLocation(LocationEntity location) {
    return Future.delayed(Duration(milliseconds: 1), () async {
      if (!initialized) {
        await init();
      }
      const radius = 5;

      return cafes.where((cafe) {
        final cl = cafe.location;
        final distance = getDistanceFromLatLonInKm(
            location.lat, location.lng, cl.lat, cl.lng);
        return distance < radius;
      }).toList();
    });
  }

  double getDistanceFromLatLonInKm(
      double lat1, double lon1, double lat2, double lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(deg) {
    return deg * (pi / 180);
  }

  @override
  Future<CafeDetailEntity> getDetail(String id) {
    if (!initialized) init();
    return Future.delayed(Duration(milliseconds: 1),
        () => details.firstWhere((x) => x.id == id, orElse: () => null));
  }

  @override
  Future<List<CafeEntity>> getBySearch(String search) {
    return Future.delayed(
        Duration(milliseconds: 100),
        () => cafes
            .where(
                (c) => c.address.toLowerCase().contains(search.toLowerCase()))
            .toList());
  }

  @override
  Future<List<CafeEntity>> getFavorites() {
    return Future.delayed(Duration(milliseconds: 1),
        () => cafes.where((c) => c.isFavorite).toList());
  }

  @override
  Future<bool> updateEntity(CafeEntity entity) {
    return Future.delayed(Duration(milliseconds: 1), () {
      var i = cafes.indexWhere((e) => e.id == entity.id);
      cafes[i] = cafes[i].copyWith(isFavorite: entity.isFavorite);
      i = details.indexWhere((e) => e.id == entity.id);
      details[i] = details[i].copyWith(isFavorite: entity.isFavorite);

      return true;
    });
  }

  Future init() async {
    initialized = true;
    cafes = _predefinedCafes;
    cafes.addAll(await mock.readCafeData());

    for (final pd in _cafeDetails.keys) {
      details.add(_cafeDetails[pd]);
    }
    final moreDetails = await mock.readCadeDetailData();
    details.addAll(moreDetails);

    addresses = details.map((d) => d.contact.address).toSet().toList();
  }

  bool initialized = false;
  List<CafeEntity> cafes = [];
  List<CafeDetailEntity> details = [];
  List<String> addresses = [];

  static Uuid uuid = Uuid();
  static PhotoEntity _photo(String url) => PhotoEntity(url: url);
  static LocationEntity _location() => LocationEntity(17.56, 20.53);

  static MockData mock = MockData();

  static List<CafeEntity> _predefinedCafes = [
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
        location: LocationEntity(50.104917, 14.389526),
        tags: mock.mapTags(['wifi', 'outside', 'food'])),
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
        location: LocationEntity(50.103946, 14.390296),
        tags: mock.mapTags(['wifi', 'outside', 'food', 'beer'])),
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
        location: LocationEntity(50.105598, 14.395324),
        tags: mock.mapTags(['wifi'])),
  ];

  Map<String, CafeDetailEntity> _cafeDetails = {
    "1": CafeDetailEntity.fromCafe(_predefinedCafes[0],
        contact: ContactEntity(
          address: _predefinedCafes[0].address,
          phone: '111 222 333',
        ),
        comments: mock.getRandomComments(3),
        cafeUrl: 'https://goo.gl/maps/gLopcuff9KpZ9NYS8',
        additionalPhotos: [
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/c3860f08-c013-48cd-bdf2-7819843ad579.jpg"),
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/a6099310-6f4e-447e-b7a7-e8c073d3b0ea.jpg"),
        ]),
    "2": CafeDetailEntity.fromCafe(_predefinedCafes[1],
        contact: ContactEntity(
          address: _predefinedCafes[0].address,
          phone: '111 222 333',
          website: 'https://cafe.prostoru.cz',
        ),
        comments: mock.getRandomComments(3),
        cafeUrl: 'https://goo.gl/maps/gLopcuff9KpZ9NYS8',
        additionalPhotos: [
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/c3860f08-c013-48cd-bdf2-7819843ad579.jpg"),
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/a6099310-6f4e-447e-b7a7-e8c073d3b0ea.jpg"),
        ]),
    "3": CafeDetailEntity.fromCafe(_predefinedCafes[2],
        contact: ContactEntity(
          address: _predefinedCafes[0].address,
          phone: '111 222 333',
        ),
        comments: mock.getRandomComments(3),
        cafeUrl: 'https://goo.gl/maps/gLopcuff9KpZ9NYS8',
        additionalPhotos: [
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/c3860f08-c013-48cd-bdf2-7819843ad579.jpg"),
          _photo(
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/a6099310-6f4e-447e-b7a7-e8c073d3b0ea.jpg"),
        ]),
  };
}
