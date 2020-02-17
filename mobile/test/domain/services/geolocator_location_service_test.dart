import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/services/location_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';

class MockGeolocator extends Mock implements Geolocator {}

void main() {
  MockGeolocator geolocator;
  GeolocatorLocationService service;
  setUp(() {
    geolocator = MockGeolocator();
    service = GeolocatorLocationService(geolocator: geolocator);
  });

  group('getCurrentLocation', () {
    test('Should return provided location', () async {
      when(geolocator.getCurrentPosition())
          .thenAnswer((_) async => Position(latitude: 10, longitude: 10));

      final result = await service.getCurrentLocation();

      expect(result, Location(10, 10));
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
