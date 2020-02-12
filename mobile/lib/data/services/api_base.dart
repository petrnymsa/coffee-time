import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class ApiException implements Exception {
  final String body;
  final int statusCode;

  const ApiException({
    @required this.statusCode,
    @required this.body,
  });
}

class GoogleApiException implements Exception {
  final String code;
  final String errorMessage;

  GoogleApiException({
    @required this.code,
    this.errorMessage,
  });
}

abstract class ApiBase {
  static const String apiBaseUrl =
      "https://europe-west1-coffeetime-1571221579778.cloudfunctions.net/api";

  final http.Client client;

  ApiBase({@required this.client});

  Future<http.Response> getRequest(String url) async {
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
