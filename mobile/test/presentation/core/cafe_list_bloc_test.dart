import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_time/core/either.dart';
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

  CafeListBloc createBloc() => CafeListBloc(
      cafeRepository: cafeRepository, locationService: locationService);

  blocTest(
    'Initial state should be Loading',
    build: createBloc,
    expect: [Loading()],
  );

  group('LoadNearby', () {
    blocTest(
      'Emits Loading and Loaded when is successful',
      build: () {
        when(cafeRepository.getNearby(any, filter: anyNamed('filter')))
            .thenAnswer(
          (_) async => Left(NearbyResult(cafes: [cafeEntityExample()])),
        );
        return createBloc();
      },
      act: (bloc) => bloc.add(LoadNearby(Location(1, 1))),
      expect: [
        Loading(),
        Loaded(cafes: [cafeEntityExample()])
      ],
    );

    // // todo handle concrete NetworkFailure
    blocTest(
      'Emits Loading and Failure when error',
      build: () {
        when(cafeRepository.getNearby(any, filter: anyNamed('filter')))
            .thenAnswer((_) async => Right(CommonFailure('Network failure')));
        return createBloc();
      },
      act: (bloc) => bloc.add(LoadNearby(Location(1, 1))),
      expect: [Loading(), CafeListState.failure('Network failure')],
    );
  });
}
