import 'dart:convert';

import 'package:coffee_time/core/firebase/authentication.dart';
import 'package:meta/meta.dart';

import '../../core/app_config.dart';
import '../../core/http_client_factory.dart';
import '../models/models.dart';
import 'api_base.dart';

abstract class TagService {
  Future<List<TagModel>> getAll();
  Future<List<TagReputationModel>> getForCafe(String placeId);
}

class TagServiceImpl extends ApiBase implements TagService {
  TagServiceImpl({
    @required HttpClientFactory clientFactory,
    @required AppConfig appConfig,
    @required FirebaseAuthProvider authProvider,
  }) : super(
          clientFactory: clientFactory,
          appConfig: appConfig,
          authProvider: authProvider,
        );

  @override
  Future<List<TagModel>> getAll() async {
    final url = '${appConfig.apiUrl}/tags';
    final response = await getRequest(url);

    final List<dynamic> data = json.decode(response.body);
    //ignore: unnecessary_lambdas
    return data.map((x) => TagModel.fromJson(x)).toList();
  }

  @override
  Future<List<TagReputationModel>> getForCafe(String placeId) async {
    final url = '${appConfig.apiUrl}/tags/$placeId';
    final response = await getRequest(url);

    final List<dynamic> data = json.decode(response.body);
    //ignore: unnecessary_lambdas
    return data.map((x) => TagReputationModel.fromJson(x)).toList();
  }
}
