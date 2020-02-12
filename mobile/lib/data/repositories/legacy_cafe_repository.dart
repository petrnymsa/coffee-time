import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/entities/contact.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/photo.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/entities/tag_reputation.dart';
import 'package:coffee_time/domain/repositories/cafe_repository.dart';
import 'package:uuid/uuid.dart';

class InMemoryCafeRepository implements CafeRepository {
  static InMemoryCafeRepository _instance;

  static InMemoryCafeRepository get instance {
    if (_instance == null) _instance = InMemoryCafeRepository();

    return _instance;
  }

  @override
  Future<List<Cafe>> getByLocation(Location location,
      {Filter filter = Filter.defaultFilter}) {
    return Future.delayed(Duration(milliseconds: 1), () async {
      if (!initialized) {
        //await init();
      }
      const radius = 6; // km

      final result = cafes.where((cafe) {
        final distance = location.distance(cafe.location);
        if (distance < radius) {
          if (filter != null && !filter.apply(cafe)) return false;

          return true;
        }
        return false;
      }).toList();

      if (filter != null) {
        result.sort((a, b) {
          if (filter.ordering == FilterOrdering.distance) {
            double distA = location.distance(a.location);
            double distB = location.distance(b.location);
            if (distA > distB)
              return 1;
            else if (distA < distB) return -1;

            return 0;
            //return (distA - distB).toInt();
          }

          if (a.rating > b.rating)
            return -1;
          else if (a.rating < b.rating) return 1;

          return 0;
        });
      }

      return result;
    });
  }

  @override
  Future<CafeDetail> getDetail(String id) {
    if (!initialized) init();
    return Future.delayed(Duration(milliseconds: 1),
        () => details.firstWhere((x) => x.placeId == id, orElse: () => null));
  }

  @override
  Future<List<Cafe>> getBySearch(String search,
      {Filter filter = Filter.defaultFilter}) {
    return Future.delayed(
        Duration(milliseconds: 100),
        () => cafes.where((c) {
              if (c.address.toLowerCase().contains(search.toLowerCase())) {
                if (filter != null && !filter.apply(c)) return false;

                return true;
              }
              return false;
            }).toList());
  }

  @override
  Future<List<Cafe>> getFavorites() {
    return Future.delayed(Duration(milliseconds: 1),
        () => cafes.where((c) => c.isFavorite).toList());
  }

  @override
  Future<List<Tag>> getAllTags() {
    return Future.delayed(Duration(milliseconds: 1), () => tags);
  }

  // @override
  // Future<bool> toggleFavorite(Cafe entity) {
  //   return Future.delayed(Duration(milliseconds: 1), () {
  //     var i = cafes.indexWhere((e) => e.placeId == entity.placeId);
  //     cafes[i] = cafes[i].copyWith(isFavorite: entity.isFavorite);
  //     i = details.indexWhere((e) => e.placeId == entity.placeId);
  //     details[i] = details[i].copyWith(isFavorite: entity.isFavorite);

  //     return true;
  //   });
  // }

  Future addTags(Cafe entity, List<TagReputation> tags) async {
    return Future.delayed(Duration(milliseconds: 1), () {
      var i = cafes.indexWhere((e) => e.placeId == entity.placeId);
      cafes[i] = cafes[i].copyWith(tags: [...entity.tags, ...tags]);
      i = details.indexWhere((e) => e.placeId == entity.placeId);
      details[i] = details[i].copyWith(tags: [...entity.tags, ...tags]);
    });
  }

  Future init() async {
    initialized = true;
    cafes = _predefinedCafes;
    cafes.addAll([]);

    for (final pd in _cafeDetails.keys) {
      details.add(_cafeDetails[pd]);
    }
    details.addAll([]);

    addresses = details.map((d) => d.contact.address).toSet().toList();
  }

  bool initialized = false;
  List<Cafe> cafes = [];
  List<CafeDetail> details = [];
  List<String> addresses = [];
  List<Tag> tags = [];

  static Uuid uuid = Uuid();

  static List<Cafe> _predefinedCafes = [
    Cafe(
      placeId: "1",
      name: 'Archicafé',
      address: 'Thákurova 9',
      rating: 4.7,
      photos: [
        PhotoEntity(
            url:
                "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/ab243c8c-2719-4986-b869-d83256692e17.jpg"),
      ],
      openNow: true,
      location: Location(50.104917, 14.389526),
      //  tags: mock.mapTags(['wifi', 'outside', 'food']),
    ),
    Cafe(
      placeId: "2",
      name: 'Cafe Prostoru_',
      address: 'Technická 270/6',
      rating: 4.3,
      photos: [
        PhotoEntity(
            url:
                "https://static8.fotoskoda.cz/data/cache/thumb_700-392-24-0-1/articles/2317/1542705898/fotosoutez_prostor_ntk_cafe_prostoru_uvod.jpg"),
      ],
      openNow: true,
      location: Location(50.103946, 14.390296),
      //tags: mock.mapTags(['wifi', 'outside', 'food', 'beer']),
    ),
    Cafe(
      placeId: "3",
      name: 'Estella CAFÉ',
      address: 'Nám. Interbrigády',
      rating: 3.2,
      photos: [
        PhotoEntity(
            url:
                "https://media-cdn.tripadvisor.com/media/photo-s/14/98/8f/1e/interier.jpg"),
      ],
      openNow: false,
      location: Location(50.105598, 14.395324),
      //tags: mock.mapTags(['wifi']),
    ),
    Cafe(
      placeId: "4",
      name: 'U lišaka',
      address: 'Nám. Interbrigády',
      rating: 3.2,
      photos: [
        PhotoEntity(
            url:
                "https://media-cdn.tripadvisor.com/media/photo-s/14/98/8f/1e/interier.jpg"),
      ],
      openNow: true,
      location: Location(50.107598, 14.3425324),
      //tags: mock.mapTags(['beer', 'parking', 'children']),
    ),
  ];

  Map<String, CafeDetail> _cafeDetails = {
    "1": CafeDetail.fromCafe(
      _predefinedCafes[0],
      contact: Contact(
        address: _predefinedCafes[0].address,
        formattedPhone: '111 222 333',
      ),
      reviews: [],
      cafeUrl: 'https://goo.gl/maps/gLopcuff9KpZ9NYS8',
      additionalPhotos: [
        PhotoEntity(
            url:
                "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/c3860f08-c013-48cd-bdf2-7819843ad579.jpg"),
        PhotoEntity(
            url:
                "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/a6099310-6f4e-447e-b7a7-e8c073d3b0ea.jpg"),
      ],
    ),
    "2": CafeDetail.fromCafe(_predefinedCafes[1],
        contact: Contact(
          address: _predefinedCafes[1].address,
          formattedPhone: '111 222 333',
          website: 'https://cafe.prostoru.cz',
        ),
        reviews: [],
        cafeUrl: 'https://goo.gl/maps/gLopcuff9KpZ9NYS8',
        additionalPhotos: [
          PhotoEntity(
              url:
                  "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/c3860f08-c013-48cd-bdf2-7819843ad579.jpg"),
          PhotoEntity(
              url:
                  "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/a6099310-6f4e-447e-b7a7-e8c073d3b0ea.jpg"),
        ]),
    "3": CafeDetail.fromCafe(_predefinedCafes[2],
        contact: Contact(
          address: _predefinedCafes[2].address,
          formattedPhone: '111 222 333',
        ),
        reviews: [],
        cafeUrl: 'https://goo.gl/maps/gLopcuff9KpZ9NYS8',
        additionalPhotos: [
          PhotoEntity(
              url:
                  "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/c3860f08-c013-48cd-bdf2-7819843ad579.jpg"),
          PhotoEntity(
              url:
                  "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/a6099310-6f4e-447e-b7a7-e8c073d3b0ea.jpg"),
        ]),
    "4": CafeDetail.fromCafe(_predefinedCafes[3],
        contact: Contact(
          address: _predefinedCafes[3].address,
          formattedPhone: '111 222 333',
        ),
        reviews: [],
        cafeUrl: 'https://goo.gl/maps/gLopcuff9KpZ9NYS8',
        additionalPhotos: [
          PhotoEntity(
              url:
                  "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/c3860f08-c013-48cd-bdf2-7819843ad579.jpg"),
          PhotoEntity(
              url:
                  "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/a6099310-6f4e-447e-b7a7-e8c073d3b0ea.jpg"),
        ]),
  };

  @override
  Future<List<Cafe>> getNearby(Location location, {Filter filter}) {
    // TODO: implement getNearby
    return null;
  }

  @override
  Future<List<Cafe>> search(String search, {Filter filter}) {
    // TODO: implement search
    return null;
  }

  @override
  Future<Cafe> toggleFavorite(Cafe cafe) {
    // TODO: implement toggleFavorite
    return null;
  }
}
