import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_time/core/either.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/failure.dart';
import 'package:coffee_time/domain/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/repositories/nearby_result.dart';
import 'package:coffee_time/domain/services/location_service.dart';
import 'package:coffee_time/presentation/core/blocs/cafe_list/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockCafeRepository extends Mock implements CafeRepository {}

class MockLocationService extends Mock implements LocationService {}

void main() {
  CafeRepository cafeRepository;
  LocationService locationService;

  setUp(() {
    noLogger();

    cafeRepository = MockCafeRepository();
    locationService = MockLocationService();
  });

  Future<CafeListBloc> createBloc() => Future.value(CafeListBloc(
      cafeRepository: cafeRepository, locationService: locationService));

  blocTest(
    'Initial state should be Loading',
    build: createBloc,
    skip: 0,
    expect: [Loading()],
  );

  group('LoadNearby', () {
    blocTest(
      'Emits Loaded when is successful',
      build: () {
        when(cafeRepository.getNearby(any, filter: anyNamed('filter')))
            .thenAnswer(
          (_) async => Left(NearbyResult(cafes: [cafeEntityExample()])),
        );
        return createBloc();
      },
      act: (bloc) => bloc.add(LoadNearby(Location(1, 1), filter: Filter())),
      expect: [
        Loaded(cafes: [cafeEntityExample()], actualFilter: Filter())
      ],
    );

    blocTest(
      'Emits Loading and Failure when error',
      build: () {
        when(cafeRepository.getNearby(any, filter: anyNamed('filter')))
            .thenAnswer((_) async => Right(CommonFailure('Network failure')));
        return createBloc();
      },
      act: (bloc) => bloc.add(LoadNearby(Location(1, 1))),
      expect: [CafeListState.failure('Network failure')],
    );
  });
}
