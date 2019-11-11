import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/cafe.dart';

//todo split this to CafeListTab provider, MapProvider and TabProvider
class HomeProvider<WithoutError> extends BaseProvider {
  InMemoryCafeRepository _cafeRepository = InMemoryCafeRepository();

  List<Cafe> _cafes;

  List<Cafe> get cafes => _cafes;

  HomeProvider() {
    load();
  }

  void load() async {
    setBusy();
    final _cafeEntities = await _cafeRepository.getByLocation(null);
    _cafes = _cafeEntities.map((e) => Cafe(e)).toList();
    setIdle();
  }
}
