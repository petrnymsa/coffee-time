import 'package:coffee_time/data/repositories/legacy_cafe_repository.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/repositories/cafe_repository.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';

class DetailProvider extends BaseProvider<WithoutError> {
  final CafeRepository repository = InMemoryCafeRepository.instance;
  final String cafeId;

  CafeDetail _detailEntity;

  CafeDetail get detail => _detailEntity;

  DetailProvider({this.cafeId}) {
    setBusy();
    loadDetail();
  }

  loadDetail() async {
    setBusy();
    // _detailEntity = await repository.getDetail(cafeId);
    setReady();
  }

  toggleFavorite() async {
    await repository.toggleFavorite(
        _detailEntity.copyWith(isFavorite: !_detailEntity.isFavorite));
    // _detailEntity = await repository.getDetail(cafeId);
    notifyListeners();
  }
}
