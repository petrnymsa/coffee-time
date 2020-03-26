import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_time/domain/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/services/location_service.dart';
import 'package:coffee_time/presentation/core/blocs/favorites/favorites_bloc.dart';
import 'package:coffee_time/presentation/screens/cafe_list/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockCafeRepository extends Mock implements CafeRepository {}

class MockLocationService extends Mock implements LocationService {}

class MockFavoritesBloc extends Mock implements FavoritesBloc {}

void main() {
  CafeRepository cafeRepository;
  LocationService locationService;

  setUp(() {
    noLogger();

    cafeRepository = MockCafeRepository();
    locationService = MockLocationService();
  });

  Future<CafeListBloc> createBloc() => Future.value(CafeListBloc(
      cafeRepository: cafeRepository,
      locationService: locationService,
      favoritesBloc: MockFavoritesBloc()));

  blocTest(
    'Initial state should be Loading',
    build: createBloc,
    skip: 0,
    expect: [Loading()],
  );

  //todo tests
}
