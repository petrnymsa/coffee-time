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
