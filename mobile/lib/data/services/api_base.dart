import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../core/app_config.dart';
import '../../core/app_logger.dart';
import '../../core/firebase/authentication.dart';
import '../../core/http_client_factory.dart';
import '../../domain/exceptions/exceptions.dart';

abstract class ApiBase {
  final FirebaseAuthProvider authProvider;
  final AppConfig appConfig;
  final HttpClientFactory clientFactory;

  final Logger _logger = getLogger('Api');

  ApiBase({
    @required this.appConfig,
    @required this.clientFactory,
    @required this.authProvider,
  });

  Future<Map<String, String>> _getRequestHeader() async {
    final token = await authProvider.getAuthToken();
    return <String, String>{HttpHeaders.authorizationHeader: 'Bearer $token'};
  }

  Future<http.Response> getRequest(String url) async {
    _logger.i('GET request: $url');
    final client = clientFactory.create();
    http.Response response;
    try {
      final headers = await _getRequestHeader();
      response = await client.get(url, headers: headers);
      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    } finally {
      client.close();
    }

    if (response.statusCode >= 400) {
      throw ApiException(statusCode: response.statusCode, body: response.body);
    }
    return response;
  }

  Future<http.Response> postRequest(String url, String body) async {
    _logger.i('POST request: $url');
    final client = clientFactory.create();
    http.Response response;
    try {
      final token = await authProvider.getAuthToken();
      response = await client.post(url, body: body, headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.authorizationHeader: 'Bearer $token'
      });
      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    } finally {
      client.close();
    }

    if (response.statusCode >= 400) {
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
