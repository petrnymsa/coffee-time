import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/exceptions/exceptions.dart';
import 'package:coffee_time/domain/services/app_permission_provider.dart';
import 'package:coffee_time/domain/services/location_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../fixtures/fixture_helper.dart';

class MockGeolocator extends Mock implements Geolocator {}

class MockPermissionProvider extends Mock implements AppPermissionProvider {}

void main() {
  MockGeolocator geolocator;
  MockPermissionProvider permissionProvider;
  GeolocatorLocationService service;
  setUp(() {
    noLogger();
    geolocator = MockGeolocator();
    permissionProvider = MockPermissionProvider();
    service = GeolocatorLocationService(
        geolocator: geolocator, permissionProvider: permissionProvider);
  });

  group('getCurrentLocation', () {
    test('Should return provided location', () async {
      when(geolocator.getCurrentPosition())
          .thenAnswer((_) async => Position(latitude: 10, longitude: 10));
      when(geolocator.isLocationServiceEnabled()).thenAnswer((_) async => true);
      when(geolocator.checkGeolocationPermissionStatus())
          .thenAnswer((_) async => GeolocationStatus.granted);
      when(permissionProvider.request())
          .thenAnswer((_) async => PermissionStatus.granted);

      final result = await service.getCurrentLocation();

      expect(result, Location(10, 10));
    });

    test('When no permission, should throw Exception', () async {
      when(geolocator.isLocationServiceEnabled()).thenAnswer((_) async => true);
      when(geolocator.checkGeolocationPermissionStatus())
          .thenAnswer((_) async => GeolocationStatus.disabled);

      when(permissionProvider.request())
          .thenAnswer((_) async => PermissionStatus.denied);

      final action = service.getCurrentLocation;

      expect(action(),
          throwsA(NoLocationPermissionException(GeolocationStatus.disabled)));
    });

    test('When no gps, should throw Exception', () async {
      when(geolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => false);

      final action = service.getCurrentLocation;

      expect(action(), throwsA(isInstanceOf<NoLocationServiceException>()));
    });
  });

  group('distanceBetween', () {
    test('Should return distance', () async {
      when(geolocator.distanceBetween(10, 10, 20, 20))
          .thenAnswer((_) async => 10);

      final result =
          await service.distanceBetween(Location(10, 10), Location(20, 20));

      expect(result, 10);
    });
  });

  group('listen', () {
    test('should emits positions', () {
      final positions = [
        Position(longitude: 10, latitude: 10),
        Position(longitude: 20, latitude: 10),
        Position(longitude: 30, latitude: 10)
      ];

      when(geolocator.getPositionStream(any))
          .thenAnswer((_) => Stream.fromIterable(positions));

      final stream = service.getLocationStream();

      expect(
          stream,
          emitsInOrder(
            positions.map((x) => Location(x.latitude, x.longitude)),
          ));
    });
  });
}
