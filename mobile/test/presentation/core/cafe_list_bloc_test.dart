import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_time/domain/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/services/location_service.dart';
import 'package:coffee_time/presentation/core/blocs/filter/bloc.dart';
import 'package:coffee_time/presentation/screens/cafe_list/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockCafeRepository extends Mock implements CafeRepository {}

class MockLocationService extends Mock implements LocationService {}

class MockFilterBloc extends Mock implements FilterBloc {}

void main() {
  CafeRepository cafeRepository;
  LocationService locationService;

  setUp(() {
    noLogger();

    cafeRepository = MockCafeRepository();
    locationService = MockLocationService();
  });

  Future<CafeListBloc> createBloc() => Future.value(CafeListBloc(
      filterBloc: MockFilterBloc(),
      cafeRepository: cafeRepository,
      locationService: locationService));

  blocTest(
    'Initial state should be Loading',
    build: createBloc,
    skip: 0,
    expect: [Loading()],
  );

  //todo tests
}
