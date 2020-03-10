import '../../../core/either.dart';
import '../../../domain/entities/cafe.dart';
import '../../../domain/entities/cafe_detail.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/filter.dart';
import '../../../domain/entities/location.dart';
import '../../../domain/entities/opening_hour.dart';
import '../../../domain/entities/photo.dart';
import '../../../domain/entities/review.dart';
import '../../../domain/entities/tag_reputation.dart';
import '../../../domain/entities/tag_update.dart';
import '../../../domain/failure.dart';
import '../../../domain/repositories/cafe_repository.dart';
import '../../../domain/repositories/nearby_result.dart';
import 'tags_data_source.dart';

class MockedCafeRepository implements CafeRepository {
  static final MockTagsDataSource dataSource = MockTagsDataSource();
  static List<Period> getPeriods() {
    var periods = <Period>[];

    for (var i = 0; i < 7; i++) {
      periods.add(Period(
          open: DayTime(day: i, time: "1100"),
          close: DayTime(day: i, time: "2300")));
    }

    return periods;
  }

  final List<Cafe> _cafes = [
    Cafe(
      placeId: '1',
      address: 'Kvikalkov',
      isFavorite: false,
      name: 'Best Cafe',
      openNow: true,
      rating: 4,
      tags: dataSource.forCafe('1'),
      photos: [],
    ),
    Cafe(
      placeId: '2',
      address: 'Prrraha',
      isFavorite: false,
      name: 'Greenway',
      openNow: true,
      rating: 4,
      tags: dataSource.forCafe('2'),
      photos: [],
    ),
    Cafe(
      placeId: '3',
      address: 'NY',
      isFavorite: false,
      name: 'Worst Cafe',
      openNow: false,
      rating: 1,
      tags: dataSource.forCafe('3'),
      photos: [],
    )
  ];

  final Map<String, CafeDetail> _details = {
    '1': CafeDetail(
        contact: Contact(
            website: 'www.someurl.com',
            formattedPhone: '111222333',
            internationalPhone: '111222333'),
        openingHours: OpeningHours(openNow: true, periods: getPeriods()),
        photos: <Photo>[],
        reviews: <Review>[],
        url: 'www.anotherurl.com',
        utcOffset: 0),
    '2': CafeDetail(
        contact: Contact(
            website: 'www.someurl.com',
            formattedPhone: '111222333',
            internationalPhone: '111222333'),
        openingHours: OpeningHours(openNow: true, periods: getPeriods()),
        photos: <Photo>[],
        reviews: <Review>[],
        url: 'www.anotherurl.com',
        utcOffset: 0),
    '3': CafeDetail(
        contact: Contact(
            website: 'www.someurl.com',
            formattedPhone: '111222333',
            internationalPhone: '111222333'),
        openingHours: OpeningHours(openNow: false, periods: getPeriods()),
        photos: <Photo>[],
        reviews: <Review>[],
        url: 'www.anotherurl.com',
        utcOffset: 0),
  };

  @override
  Future<Either<CafeDetail, Failure>> getDetail(String id) {
    final detail = _details[id];
    return Future.value(Left(detail));
  }

  @override
  Future<Either<List<Cafe>, Failure>> getFavorites() {
    final favorites = _cafes.where((x) => x.isFavorite).toList();
    return Future.value(Left(favorites));
  }

  @override
  Future<Either<NearbyResult, Failure>> getNearby(Location location,
      {Filter filter, String pageToken}) {
    return Future.value(Left(NearbyResult(cafes: _cafes, nextPageToken: null)));
  }

  @override
  Future<Either<List<Cafe>, Failure>> search(String search, {Filter filter}) {
    // TODO: implement search
    return null;
  }

  @override
  Future<Either<bool, Failure>> toggleFavorite(String id) {
    final index = _cafes.indexWhere((x) => x.placeId == id);
    final isFavorite = _cafes[index].isFavorite;
    _cafes[index] = _cafes[index].copyWith(isFavorite: !isFavorite);

    return Future.value(Left(!isFavorite));
  }

  @override
  Future<Either<List<TagReputation>, Failure>> updateTagsForCafe(
      String id, List<TagUpdate> updates) {
    // TODO: implement updateTagsForCafe
    return null;
  }
}
