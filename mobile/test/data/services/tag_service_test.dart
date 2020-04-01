import 'package:coffee_time/core/app_config.dart';
import 'package:coffee_time/core/firebase/authentication.dart';
import 'package:coffee_time/core/http_client_factory.dart';
import 'package:coffee_time/data/services/tag_service.dart';
import 'package:coffee_time/domain/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockHttpClient extends Mock implements Client {}

class MockHttpClientFactory extends Mock implements HttpClientFactory {}

class MockAuthProvider extends Mock implements FirebaseAuthProvider {}

void main() {
  MockHttpClient httpClient;
  TagServiceImpl tagService;
  MockHttpClientFactory mockHttpClientFactory;
  MockAuthProvider mockAuthProvider;

  var config = AppConfig(apiUrl: 'http://www.test.com/api');
  final authHeader = {'authorization': 'Bearer token'};

  setUp(() {
    noLogger();

    httpClient = MockHttpClient();
    mockHttpClientFactory = MockHttpClientFactory();
    mockAuthProvider = MockAuthProvider();
    tagService = TagServiceImpl(
        clientFactory: mockHttpClientFactory,
        appConfig: config,
        authProvider: mockAuthProvider);

    when(mockHttpClientFactory.create()).thenReturn(httpClient);
    when(mockAuthProvider.getAuthToken()).thenAnswer((_) async => 'token');
  });

  void setupHttpClientResponseOk({bool empty = false}) {
    Response response;

    if (empty) {
      response = Response('[]', 200);
    } else {
      final tagJson = fixture('tag.json');
      final json = '[$tagJson]';
      response = Response(json, 200);
    }

    when(httpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => response);
  }

  void setupHttpClientResponseBadRequest() {
    when(httpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response('', 400));
  }

  group('getAll', () {
    test('Should call GET request on right url', () async {
      setupHttpClientResponseOk();
      final url = '${config.apiUrl}/tags';

      await tagService.getAll();

      verify(httpClient.get(url, headers: authHeader)).called(1);
    });

    test('Succesfull GET request should return tags', () async {
      setupHttpClientResponseOk();

      final result = await tagService.getAll();

      expect(result, equals([tagExample()]));
    });

    test('Succesfull GET request but no results should return empty list',
        () async {
      setupHttpClientResponseOk(empty: true);

      final result = await tagService.getAll();

      expect(result, equals([]));
    });

    test('Bad GET request should raise exception', () async {
      setupHttpClientResponseBadRequest();

      final action = tagService.getAll;

      expect(action, throwsA(isInstanceOf<ApiException>()));
    });
  });

  //todo forCafe tests
}
