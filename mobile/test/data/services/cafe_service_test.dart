import 'dart:convert';
import 'dart:io';

import 'package:coffee_time/core/app_config.dart';
import 'package:coffee_time/core/firebase/authentication.dart';
import 'package:coffee_time/core/http_client_factory.dart';
import 'package:coffee_time/data/models/models.dart';
import 'package:coffee_time/data/models/tag_update.dart';
import 'package:coffee_time/data/services/cafe_service.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/tag_update.dart';
import 'package:coffee_time/domain/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockHttpClient extends Mock implements Client {}

class MockHttpClientFactory extends Mock implements HttpClientFactory {}

class MockAuthProvider extends Mock implements FirebaseAuthProvider {}

void main() {
  MockHttpClient mockHttpClient;
  CafeServiceImpl service;
  MockHttpClientFactory mockHttpClientFactory;
  MockAuthProvider mockAuthProvider;

  final baseUrl = 'http://www.test.com/api';
  final authHeader = {'authorization': 'Bearer token'};
  var appConfig = AppConfig(apiUrl: baseUrl);

  setUp(() {
    noLogger();

    mockHttpClient = MockHttpClient();
    mockHttpClientFactory = MockHttpClientFactory();
    mockAuthProvider = MockAuthProvider();
    service = CafeServiceImpl(
      clientFactory: mockHttpClientFactory,
      appConfig: appConfig,
      authProvider: mockAuthProvider,
    );

    when(mockHttpClientFactory.create()).thenReturn(mockHttpClient);
    when(mockAuthProvider.getAuthToken()).thenAnswer((_) async => 'token');
  });

  void mockHttpClientWithStatusCode200(String fixtureName, String status) {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => Response(apiResponseFixture(fixtureName, status), 200,
                headers: {
                  HttpHeaders.contentTypeHeader: ContentType.json.toString()
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

  void mockBasicHttp200WithStatus(String status) {
    mockHttpClientWithStatusCode200('cafe_basic_response.json', status);
  }

  void mockClientHttp400() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response('Bad request', 400));
  }

  group('getNearby(url)', () {
    test('With required parameters, proper URL is called', () async {
      mockNearbyHttp200WithStatus("OK");

      await service.getNearBy(Location(1, 1), language: 'en-US');

      verify(mockHttpClient.get('$baseUrl/en-US/nearby?location=1.0%2C1.0',
          headers: authHeader));
    });

    test('With opennow parameter proper URL is called', () async {
      mockNearbyHttp200WithStatus("OK");

      await service.getNearBy(Location(1, 1), language: 'en-US', openNow: true);

      verify(mockHttpClient.get(
          '$baseUrl/en-US/nearby?location=1.0%2C1.0&opennow',
          headers: authHeader));
    });

    test('With pagetoken parameter proper URL is called', () async {
      mockNearbyHttp200WithStatus("OK");

      await service.getNearBy(Location(1, 1),
          language: 'en-US', pageToken: 'abc');

      verify(mockHttpClient.get(
          '$baseUrl/en-US/nearby?location=1.0%2C1.0&pagetoken=abc',
          headers: authHeader));
    });

    test('With radius parameter proper URL is called', () async {
      mockNearbyHttp200WithStatus("OK");

      await service.getNearBy(Location(1, 1), language: 'en-US', radius: 2000);

      verify(mockHttpClient.get(
          '$baseUrl/en-US/nearby?location=1.0%2C1.0&radius=2000',
          headers: authHeader));
    });

    test('With all parameters proper URL is called', () async {
      mockNearbyHttp200WithStatus("OK");

      await service.getNearBy(Location(1, 1),
          language: 'en-US', openNow: true, pageToken: 'abc', radius: 2500);

      verify(mockHttpClient.get(
          '$baseUrl/en-US/nearby?location=1.0%2C1.0&opennow&pagetoken=abc&radius=2500',
          headers: authHeader));
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
    test('With required parameters, proper URL is called', () async {
      mockFindHttp200WithStatus("OK");

      await service.findByQuery('query', language: 'en-US');

      verify(mockHttpClient.get('$baseUrl/en-US/find?input=query',
          headers: authHeader));
    });

    test('With location and radius parameters proper URL is called', () async {
      mockFindHttp200WithStatus("OK");

      await service.findByQuery('query',
          language: 'en-US', location: Location(1, 1), radius: 2500);

      verify(mockHttpClient.get(
          '$baseUrl/en-US/find?input=query&location=1.0%2C1.0&radius=2500',
          headers: authHeader));
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
    test('With required parameters, proper URL is called', () async {
      mockDetailHttp200WithStatus("OK");

      await service.getDetail('abc', language: 'en-US');

      verify(
          mockHttpClient.get('$baseUrl/en-US/detail/abc', headers: authHeader));
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

  group('basic', () {
    test('With required parameters, proper URL is called', () async {
      mockBasicHttp200WithStatus("OK");

      await service.getBasicInfo('abc', language: 'en-US');

      verify(
          mockHttpClient.get('$baseUrl/en-US/basic/abc', headers: authHeader));
    });

    test('With required parameters and sucessfull request model is returned',
        () async {
      mockBasicHttp200WithStatus("OK");

      final result = await service.getBasicInfo('abc', language: 'en-US');

      expect(result, equals(cafeModelExample()));
    });

    test('Request returned other status than OK or ZERO_RESULTS', () {
      mockBasicHttp200WithStatus('INVALID_REQUEST');

      final action = service.getBasicInfo;

      expect(action('abc', language: 'en-US'),
          throwsA(isInstanceOf<GoogleApiException>()));
    });

    test('Request returned other status code than 200', () async {
      mockClientHttp400();

      final action = service.getBasicInfo;

      expect(action('abc', language: 'en-US'),
          throwsA(isInstanceOf<ApiException>()));
    });
  });

  group('updateTagsFroCafe', () {
    test('Proper url is called', () async {
      when(
        mockHttpClient.post(any,
            body: anyNamed('body'), headers: anyNamed('headers')),
      ).thenAnswer((_) async => Future.value(Response("", 204)));

      await service.updateTagsForCafe('abc', []);

      verify(mockHttpClient
          .post("$baseUrl/tags/abc", body: anyNamed('body'), headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        'authorization': 'Bearer token'
      }));
    });

    test('Proper url is called and proper json paased', () async {
      when(
        mockHttpClient.post(any,
            body: anyNamed('body'), headers: anyNamed('headers')),
      ).thenAnswer((_) async => Future.value(Response("", 204)));

      final model = TagUpdateModel(id: '123', change: TagUpdateKind.like);
      await service.updateTagsForCafe('abc', [model]);

      final expectedUrl = "$baseUrl/tags/abc";
      final expectedBody = jsonEncode([model]);

      verify(mockHttpClient.post(expectedUrl, body: expectedBody, headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        'authorization': 'Bearer token'
      }));
    });
  });
}
