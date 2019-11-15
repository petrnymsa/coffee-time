import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/cafe.dart';

class FavoritesProvider extends BaseProvider<WithoutError> {
  InMemoryCafeRepository _cafeRepository = InMemoryCafeRepository.instance;

  List<Cafe> _cafes;
  List<Cafe> get cafes => _cafes;

  void load() async {
    getLogger('Favorites provider').i('load()');
    setBusy();
    final _entities = await _cafeRepository.getFavorites();
    _cafes = _entities.map((e) => Cafe(e)).toList();
    setReady();
  }

  void removeFavorite(int index) {
    _cafes[index].toggleFavorite();
    _cafes.removeAt(index);
    setReady();
  }
}
