import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../core/app_logger.dart';
import '../../domain/exceptions/exceptions.dart';

abstract class ApiBase {
  static const String apiBaseUrl =
      "https://europe-west1-coffeetime-1571221579778.cloudfunctions.net/api";

  final http.Client client;

  final Logger _logger = getLogger('Api');

  ApiBase({@required this.client});

  Future<http.Response> getRequest(String url) async {
    _logger.i('GET request: $url');
    //todo add auth
    final response = await client.get(url);

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
