import 'package:coffee_time/data/services/api_base.dart';
import 'package:coffee_time/data/services/tag_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  MockHttpClient httpClient;
  TagServiceImpl tagService;

  setUp(() {
    httpClient = MockHttpClient();
    tagService = TagServiceImpl(client: httpClient);
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

    when(httpClient.get(any)).thenAnswer((_) async => response);
  }

  void setupHttpClientResponseBadRequest() {
    when(httpClient.get(any)).thenAnswer((_) async => Response('', 400));
  }

  group('getAll', () {
    test('Should call GET request on right url', () {
      setupHttpClientResponseOk();
      final url = '${ApiBase.API_BASE_URL}/tags';

      tagService.getAll();

      verify(httpClient.get(url)).called(1);
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
}
