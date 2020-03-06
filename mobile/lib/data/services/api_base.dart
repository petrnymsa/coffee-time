import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../core/app_logger.dart';
import '../../core/http_client_factory.dart';
import '../../domain/exceptions/exceptions.dart';

abstract class ApiBase {
  static const String apiBaseUrl =
      "https://europe-west1-coffeetime-1571221579778.cloudfunctions.net/api";

  final HttpClientFactory clientFactory;

  final Logger _logger = getLogger('Api');

  ApiBase({@required this.clientFactory});

  Future<http.Response> getRequest(String url) async {
    _logger.i('GET request: $url');
    //todo add auth
    final client = clientFactory.create();
    // final client = http.Client();
    http.Response response;
    try {
      response = await client.get(url);
      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    } finally {
      client.close();
    }

    if (response.statusCode != 200) {
      throw ApiException(statusCode: response.statusCode, body: response.body);
    }
    return response;
  }

  Future<Map<String, dynamic>> placesGetRequest(String url) async {
    final response = await getRequest(url);

    final data = json.decode(response.body);
    final status = data['status'];

    if (status != 'OK' && status != 'ZERO_RESULTS') {
      throw GoogleApiException(
          code: status, errorMessage: data['error_message']);
    }

    return data;
  }
}
