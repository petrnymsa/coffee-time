import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:flutter/cupertino.dart';

class Cafe with ChangeNotifier {
  CafeEntity _entity;

  Cafe(this._entity);

  CafeEntity get entity => _entity;

  void toggleFavorite() {
    _entity = _entity.copyWith(isFavorite: !_entity.isFavorite);
    //todo call to repository to update
    notifyListeners();
  }
}
