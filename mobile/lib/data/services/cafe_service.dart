import 'dart:convert';

import 'package:meta/meta.dart';

import '../../core/http_client_factory.dart';
import '../../core/utils/query_string_builder.dart';
import '../../domain/entities/location.dart';
import '../models/models.dart';
import '../models/tag_update.dart';
import 'api_base.dart';

abstract class CafeService {
  Future<NearbyResultModel> getNearBy(Location location,
      {@required String language, int radius, bool openNow, String pageToken});

  Future<List<CafeModel>> findByQuery(
    String query, {
    @required String language,
    Location location,
    int radius = 2500,
  });

  Future<CafeDetailModel> getDetail(String placeId,
      {@required String language});

  Future<CafeModel> getBasicInfo(String placeId, {@required String language});

  Future updateTagsForCafe(String placeId, List<TagUpdateModel> updates);
}

class CafeServiceImpl extends ApiBase implements CafeService {
  CafeServiceImpl({@required HttpClientFactory clientFactory})
      : super(clientFactory: clientFactory);

  @override
  Future<List<CafeModel>> findByQuery(
    String query, {
    @required String language,
    Location location,
    int radius = 2500,
  }) async {
    var queryString = QueryStringBuilder();
    queryString.add('input', query);

    if (location != null) {
      queryString..add('location', location.toString())..add('radius', radius);
    }

    final url = '${ApiBase.apiBaseUrl}/$language/find?${queryString.build()}';
    final data = await placesGetRequest(url);
    final List<dynamic> results = data['candidates'];
    //ignore: unnecessary_lambdas
    return results.map((x) => CafeModel.fromMap(x)).toList();
  }

  @override
  Future<CafeDetailModel> getDetail(String placeId,
      {@required String language}) async {
    final url = '${ApiBase.apiBaseUrl}/$language/detail/$placeId';

    final data = await placesGetRequest(url);
    final result = data['result'];

    return CafeDetailModel.fromMap(result);
  }

  @override
  Future<NearbyResultModel> getNearBy(Location location,
      {@required String language,
      int radius,
      bool openNow,
      String pageToken}) async {
    final queryString = QueryStringBuilder();
    queryString.add('location', location.toString());

    if (openNow != null && openNow == true) {
      queryString.add('opennow', null);
    }

    if (pageToken != null) {
      queryString.add('pagetoken', pageToken);
    }

    if (radius != null) {
      queryString.add('radius', radius);
    }

    final url = '${ApiBase.apiBaseUrl}/$language/nearby?${queryString.build()}';

    final data = await placesGetRequest(url);
    final List<dynamic> results = data['results'];
    //ignore: unnecessary_lambdas
    final cafes = results.map((x) => CafeModel.fromMap(x)).toList();

    return NearbyResultModel(
        cafes: cafes, nextPageToken: data['next_page_token']);
  }

  @override
  Future<CafeModel> getBasicInfo(String placeId,
      {@required String language}) async {
    final url = '${ApiBase.apiBaseUrl}/$language/basic/$placeId';

    final data = await placesGetRequest(url);
    final result = data['result'];

    return CafeModel.fromMap(result);
  }

  @override
  Future updateTagsForCafe(String placeId, List<TagUpdateModel> updates) async {
    final url = '${ApiBase.apiBaseUrl}/tags/$placeId';
    final body = jsonEncode(updates);
    await postRequest(url, body);
  }
}
