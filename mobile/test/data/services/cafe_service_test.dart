import 'dart:io';

import 'package:coffee_time/core/http_client_factory.dart';
import 'package:coffee_time/data/models/models.dart';
import 'package:coffee_time/data/services/api_base.dart';
import 'package:coffee_time/data/services/cafe_service.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockHttpClient extends Mock implements Client {}

class MockHttpClientFactory extends Mock implements HttpClientFactory {}

void main() {
  MockHttpClient mockHttpClient;
  CafeServiceImpl service;
  MockHttpClientFactory mockHttpClientFactory;

  setUp(() {
    noLogger();

    mockHttpClient = MockHttpClient();
    mockHttpClientFactory = MockHttpClientFactory();
    service = CafeServiceImpl(clientFactory: mockHttpClientFactory);

    when(mockHttpClientFactory.create()).thenReturn(mockHttpClient);
  });

  void mockHttpClientWithStatusCode200(String fixtureName, String status) {
    when(mockHttpClient.get(any)).thenAnswer((_) async => Response(
            apiResponseFixture(fixtureName, status), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        }));
  }

  void mockNearbyHttp200WithStatus(String status) {
    mockHttpClientWithStatusCode200('cafe_nearby_response.json', status);
  }

  void mockFindHttp200WithStatus(String status) {
    mockHttpClientWithStatusCode200('cafe_find_response.json', status);
  }

  void mockDetailHttp200WithStatus(String status) {
    mockHttpClientWithStatusCode200('cafe_detail_response.json', status);
  }

  void mockClientHttp400() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => Response('Bad request', 400));
  }

  group('getNearby(url)', () {
    test('With required parameters, proper URL is called', () {
      mockNearbyHttp200WithStatus("OK");

      service.getNearBy(Location(1, 1), language: 'en-US');

      verify(mockHttpClient.get(
          '${ApiBase.apiBaseUrl}/en-US/nearby?location=1.0%2C1.0&radius=2500'));
    });

    test('With opennow parameter proper URL is called', () {
      mockNearbyHttp200WithStatus("OK");

      service.getNearBy(Location(1, 1), language: 'en-US', openNow: true);

      verify(mockHttpClient.get(
          '${ApiBase.apiBaseUrl}/en-US/nearby?location=1.0%2C1.0&radius=2500&opennow'));
    });

    test('With pagetoken parameter proper URL is called', () {
      mockNearbyHttp200WithStatus("OK");

      service.getNearBy(Location(1, 1), language: 'en-US', pageToken: 'abc');

      verify(mockHttpClient.get(
          '${ApiBase.apiBaseUrl}/en-US/nearby?location=1.0%2C1.0&radius=2500&pagetoken=abc'));
    });

    test('With all parameters proper URL is called', () {
      mockNearbyHttp200WithStatus("OK");

      service.getNearBy(Location(1, 1),
          language: 'en-US', openNow: true, pageToken: 'abc');

      verify(mockHttpClient.get(
          '${ApiBase.apiBaseUrl}/en-US/nearby?location=1.0%2C1.0&radius=2500&opennow&pagetoken=abc'));
    });
  });

  group('getNearby(requests)', () {
    test('With required parameters and sucessfull request model is returned',
        () async {
      mockNearbyHttp200WithStatus("OK");

      final result = await service.getNearBy(Location(1, 1), language: 'en-US');

      expect(result, equals(NearbyResultModel(cafes: [cafeModelExample()])));
    });

    test('Request returned other status than OK or ZERO_RESULTS', () {
      mockNearbyHttp200WithStatus('INVALID_REQUEST');

      final action = service.getNearBy;

      expect(action(Location(1, 1), language: 'en-US'),
          throwsA(isInstanceOf<GoogleApiException>()));
    });

    test('Request returned other status code than 200', () async {
      mockClientHttp400();

      final action = service.getNearBy;

      expect(action(Location(1, 1), language: 'en-US'),
          throwsA(isInstanceOf<ApiException>()));
    });
  });

  group('find(url)', () {
    test('With required parameters, proper URL is called', () {
      mockFindHttp200WithStatus("OK");

      service.findByQuery('query', language: 'en-US');

      verify(
          mockHttpClient.get('${ApiBase.apiBaseUrl}/en-US/find?input=query'));
    });

    test('With location and radius parameters proper URL is called', () {
      mockFindHttp200WithStatus("OK");

      service.findByQuery('query',
          language: 'en-US', location: Location(1, 1), radius: 2500);

      verify(mockHttpClient.get(
          '${ApiBase.apiBaseUrl}/en-US/find?input=query&location=1.0%2C1.0&radius=2500'));
    });
  });

  group('find(requests)', () {
    test('With required parameters and sucessfull request model is returned',
        () async {
      mockFindHttp200WithStatus("OK");

      final result = await service.findByQuery('query', language: 'en-US');

      expect(result, equals([cafeModelExample()]));
    });

    test('Request returned other status than OK or ZERO_RESULTS', () {
      mockNearbyHttp200WithStatus('INVALID_REQUEST');

      final action = service.findByQuery;

      expect(action('query', language: 'en-US'),
          throwsA(isInstanceOf<GoogleApiException>()));
    });

    test('Request returned other status code than 200', () async {
      mockClientHttp400();

      final action = service.findByQuery;

      expect(action('query', language: 'en-US'),
          throwsA(isInstanceOf<ApiException>()));
    });
  });

  group('detail', () {
    test('With required parameters, proper URL is called', () {
      mockDetailHttp200WithStatus("OK");

      service.getDetail('abc', language: 'en-US');

      verify(mockHttpClient.get('${ApiBase.apiBaseUrl}/en-US/detail/abc'));
    });

    test('With required parameters and sucessfull request model is returned',
        () async {
      mockDetailHttp200WithStatus("OK");

      final result = await service.getDetail('abc', language: 'en-US');

      expect(result, equals(cafeModelDetailExample()));
    });

    test('Request returned other status than OK or ZERO_RESULTS', () {
      mockNearbyHttp200WithStatus('INVALID_REQUEST');

      final action = service.getDetail;

      expect(action('abc', language: 'en-US'),
          throwsA(isInstanceOf<GoogleApiException>()));
    });

    test('Request returned other status code than 200', () async {
      mockClientHttp400();

      final action = service.getDetail;

      expect(action('abc', language: 'en-US'),
          throwsA(isInstanceOf<ApiException>()));
    });
  });
}
