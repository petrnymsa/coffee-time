import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../core/utils/query_string_builder.dart';
import '../../domain/entities/location.dart';
import '../models/models.dart';
import 'api_base.dart';

abstract class CafeService {
  Future<List<CafeModel>> getNearBy(Location location,
      {@required String language,
      int radius = 2500,
      bool openNow,
      String pageToken});

  Future<List<CafeModel>> findByQuery(
    String query, {
    @required String language,
    Location location,
    int radius = 2500,
  });

  Future<CafeDetailModel> getDetail(String placeId,
      {@required String language});
}

class CafeServiceImpl extends ApiBase implements CafeService {
  CafeServiceImpl({@required http.Client client}) : super(client: client);

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
  Future<List<CafeModel>> getNearBy(Location location,
      {@required String language,
      int radius = 2500,
      bool openNow,
      String pageToken}) async {
    final queryString = QueryStringBuilder();
    queryString..add('location', location.toString())..add('radius', radius);

    if (openNow != null) {
      queryString.add('opennow', null);
    }

    if (pageToken != null) {
      queryString.add('pagetoken', pageToken);
    }

    final url = '${ApiBase.apiBaseUrl}/$language/nearby?${queryString.build()}';

    final data = await placesGetRequest(url);
    final List<dynamic> results = data['results'];
    //ignore: unnecessary_lambdas
    return results.map((x) => CafeModel.fromMap(x)).toList();
  }
}
