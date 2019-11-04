import 'package:coffee_time/models/cafe.dart';
import 'package:coffee_time/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

abstract class CafeRepository {
  Future<List<Cafe>> get();
}

class InMemoryCafeRepository implements CafeRepository {
  @override
  Future<List<Cafe>> get() {
    Tag _tagWifi =
        Tag(title: 'Wifi', icon: Icons.wifi, color: Colors.lightGreen);
    Tag _tagSitOutside = Tag(title: 'Venkovní posezení', icon: Icons.wb_sunny);
    Tag _tagBeer =
        Tag(title: 'Pivo', icon: FontAwesomeIcons.beer, color: Colors.amber);
    final uuid = Uuid();

    return Future.delayed(
        Duration(milliseconds: 200),
        () => <Cafe>[
              Cafe(
                  id: uuid.v4(),
                  title: 'Archicafé',
                  address: 'Thákurova 9',
                  distance: 500,
                  rating: 4.7,
                  mainPhotoUrl:
                      "https://static8.fotoskoda.cz/data/cache/thumb_700-392-24-0-1/articles/2317/1542705898/fotosoutez_prostor_ntk_cafe_prostoru_uvod.jpg",
                  closing: DateTime.utc(2019, 10, 30, 16, 00),
                  tags: [_tagSitOutside]),
              Cafe(
                  id: uuid.v4(),
                  title: 'Cafe Prostoru_',
                  address: 'Technická 270/6',
                  distance: 800,
                  rating: 4.3,
                  closing: DateTime.utc(2019, 10, 30, 22, 00),
                  mainPhotoUrl:
                      "https://static8.fotoskoda.cz/data/cache/thumb_700-392-24-0-1/articles/2317/1542705898/fotosoutez_prostor_ntk_cafe_prostoru_uvod.jpg",
                  tags: [
                    _tagWifi,
                    _tagSitOutside,
                    _tagBeer,
                    _tagBeer,
                    _tagBeer,
                    _tagBeer,
                    _tagBeer,
                    _tagBeer
                  ]),
              Cafe(
                  id: uuid.v4(),
                  title: 'Estella CAFÉ',
                  address: 'Nám. Interbrigády',
                  distance: 480,
                  rating: 3.2,
                  mainPhotoUrl:
                      "https://static8.fotoskoda.cz/data/cache/thumb_700-392-24-0-1/articles/2317/1542705898/fotosoutez_prostor_ntk_cafe_prostoru_uvod.jpg",
                  closing: DateTime.utc(2019, 10, 30, 19, 00),
                  tags: []),
            ]);
  }
}
