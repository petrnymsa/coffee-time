import 'dart:convert';

import 'package:meta/meta.dart';

import '../../core/http_client_factory.dart';
import '../models/models.dart';
import 'api_base.dart';

abstract class TagService {
  Future<List<TagModel>> getAll();
  Future<List<TagReputationModel>> getForCafe(String placeId);
}

class TagServiceImpl extends ApiBase implements TagService {
  TagServiceImpl({@required HttpClientFactory clientFactory})
      : super(clientFactory: clientFactory);

  @override
  Future<List<TagModel>> getAll() async {
    final url = '${ApiBase.apiBaseUrl}/tags';
    final response = await getRequest(url);

    final List<dynamic> data = json.decode(response.body);
    //ignore: unnecessary_lambdas
    return data.map((x) => TagModel.fromMap(x)).toList();
  }

  @override
  Future<List<TagReputationModel>> getForCafe(String placeId) async {
    final url = '${ApiBase.apiBaseUrl}/tags/$placeId';
    final response = await getRequest(url);

    final List<dynamic> data = json.decode(response.body);
    //ignore: unnecessary_lambdas
    return data.map((x) => TagReputationModel.fromMap(x)).toList();
  }
}
