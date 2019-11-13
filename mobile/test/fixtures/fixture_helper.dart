import 'dart:io';

import 'package:coffee_time/data/models/cafe.dart';
import 'package:coffee_time/data/models/location.dart';
import 'package:coffee_time/data/models/photo.dart';

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
