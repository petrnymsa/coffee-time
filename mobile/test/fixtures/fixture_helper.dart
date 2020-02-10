import 'dart:io';

import 'package:coffee_time/data/models/models.dart';
import 'package:coffee_time/data/models/tag_reputation.dart';
import 'package:flutter/cupertino.dart';

String fixture(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('test')) {
    dir = dir.replaceAll('test', '');
  }
  return File('$dir/test/fixtures/$name').readAsStringSync();
}

ReviewModel reviewExample() {
  return ReviewModel(
      authorName: 'John Doe',
      authorUrl: 'https://www.google.com/maps/contrib/10/reviews',
      language: 'cs',
      profilePhotoUrl: 'https://lh3.ggpht.com/-1fDyAWQ1M-4/photo.jpg',
      rating: 1,
      relativeTimeDescription: 'před 8 měsíci',
      text: 'Sample text',
      time: 1559130144);
}

OpeningHoursModel openingHoursExample() {
  //todo weekday
  return OpeningHoursModel(openNow: true, periods: [
    PeriodModel(
        close: DayTimeModel(day: 1, time: "0000"),
        open: DayTimeModel(day: 0, time: "0700")),
    PeriodModel(
        close: DayTimeModel(day: 2, time: "0000"),
        open: DayTimeModel(day: 1, time: "0700"))
  ]);
}

TagModel tagExample() {
  return TagModel(
    id: 'beer',
    title: 'beer',
    translations: {'cs': 'pivo'},
    icon: IconData(61692,
        fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter'),
  );
}

TagReputationModel tagReputationExample() {
  return TagReputationModel(id: 'beer', likes: 5, dislikes: 1);
}

CafeModel cafeExample() {
  return CafeModel(
    address: 'address',
    iconUrl: 'https://maps/71.png',
    name: 'Joe',
    openNow: true,
    photo: PhotoModel(height: 2160, width: 3840, reference: 'CmRaAAAA'),
    location: LocationModel(lat: 50.399608, lng: 16.0532),
    placeId: 'ChIJ4',
    rating: 4.5,
    tags: [tagReputationExample()],
  );
}

CafeModel cafeNoPhotoExample() {
  return CafeModel(
    address: 'address',
    iconUrl: 'https://maps/71.png',
    name: 'Joe',
    openNow: true,
    location: LocationModel(lat: 50.399608, lng: 16.0532),
    placeId: 'ChIJ4',
    rating: 4.5,
    tags: [tagReputationExample()],
  );
}

CafeDetailModel cafeDetailExample() {
  return CafeDetailModel(
    formattedPhoneNumber: '224 219 501',
    internationalPhoneNumber: '+420 224 219 501',
    openingHours: openingHoursExample(),
    reviews: [reviewExample(), reviewExample()],
    photos: [
      PhotoModel(height: 2160, width: 3840, reference: 'CmRaAAAA'),
      PhotoModel(height: 2160, width: 3840, reference: 'CmRaAAAA')
    ],
    url: 'https://maps.google.com',
    utcOffset: 60,
  );
}
