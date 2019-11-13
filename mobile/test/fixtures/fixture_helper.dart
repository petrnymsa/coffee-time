import 'dart:io';

import 'package:coffee_time/data/models/cafe.dart';
import 'package:coffee_time/data/models/cafe_detail.dart';
import 'package:coffee_time/data/models/comment.dart';
import 'package:coffee_time/data/models/contact.dart';
import 'package:coffee_time/data/models/location.dart';
import 'package:coffee_time/data/models/photo.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';

String readFixture(String name) =>
    File('test/fixtures/$name').readAsStringSync();

CafeModel exampleCafeModel() => CafeModel(
      id: "7157b595-d704-457f-8aae-539dd928bd0d",
      name: "Hodkiewicz, Brekke and Harvey Cafe",
      address: "24 Elka Lane",
      openNow: true,
      location: LocationModel(lat: 46.946681, lng: 142.0144982),
      photos: [
        PhotoModel(
          url:
              "https://media.cvut.cz/sites/media/files/styles/full_preview/public/content/photos/c7d30a0b-bc5e-47f7-9ad6-5dbd43150159/ab243c8c-2719-4986-b869-d83256692e17.jpg",
          height: 456,
          width: 684,
        ),
      ],
      rating: 3.5,
      isFavorite: true,
      tags: [],
    );

CafeDetailModel exampleCafeDetailModel() => CafeDetailModel(
    id: "7157b595-d704-457f-8aae-539dd928bd0d",
    name: "Hodkiewicz, Brekke and Harvey Cafe",
    address: "24 Elka Lane",
    openNow: true,
    location: LocationModel(lat: 46.946681, lng: 142.0144982),
    photos: [
      PhotoModel(
        url: "https://media.cvut.cz/10.jpg",
        height: 456,
        width: 684,
      ),
      PhotoModel(
        url: "https://media.cvut.cz/1.jpg",
        height: 439,
        width: 700,
      ),
    ],
    rating: 3.5,
    isFavorite: true,
    tags: [],
    contact: ContactModel(
      address: '24 Elka Lane',
      phone: '291-921-0831',
      website: 'http://cafeprostoru.cz',
    ),
    cafeUrl: "https://goo.gl/maps/gLopcuff9KpZ9NYS8",
    comments: [
      CommentModel(
          user: "Cob Peasee",
          rating: 4,
          posted: DateTime(2019, 6, 19),
          content: "disintermediate real-time infomediaries",
          avatar: "https://robohash.org/eosetfuga.bmp?size=50x50&set=set1"),
      CommentModel(
          user: "Sharlene Lisle",
          rating: 5,
          posted: DateTime(2018, 11, 24),
          content: "architect innovative mindshare",
          avatar:
              "https://robohash.org/autemmaioreset.png?size=50x50&set=set1"),
    ]);
