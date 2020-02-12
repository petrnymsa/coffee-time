import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../models/models.dart';
import 'api_base.dart';

abstract class TagService {
  Future<List<TagModel>> getAll();
  Future<List<TagReputationModel>> getForCafe(String placeId);
  //todo add update method
}

class TagServiceImpl extends ApiBase implements TagService {
  TagServiceImpl({@required http.Client client}) : super(client: client);

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
