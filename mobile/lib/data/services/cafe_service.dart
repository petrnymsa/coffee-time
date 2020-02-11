import 'package:coffee_time/data/models/models.dart';
import 'package:coffee_time/data/services/api_base.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

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
    var url = '${ApiBase.API_BASE_URL}/$language/find?input=$query';

    if (location != null) {
      url += '&location=$location&radius=$radius';
    }

    final data = await placesGetRequest(url);
    final List<dynamic> results = data['candidates'];

    return results.map((x) => CafeModel.fromMap(x)).toList();
  }

  @override
  Future<CafeDetailModel> getDetail(String placeId,
      {@required String language}) async {
    final url = '${ApiBase.API_BASE_URL}/$language/detail/$placeId';

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
    var url =
        '${ApiBase.API_BASE_URL}/$language/nearby?location=$location&radius=$radius';

    if (openNow != null) {
      url += "&opennow";
    }

    if (pageToken != null) {
      url += "&pageToken";
    }

    final data = await placesGetRequest(url);
    final List<dynamic> results = data['results'];

    return results.map((x) => CafeModel.fromMap(x)).toList();
  }
}
