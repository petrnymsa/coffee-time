import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ApiException extends Equatable implements Exception {
  final String body;
  final int statusCode;

  const ApiException({
    @required this.statusCode,
    @required this.body,
  });

  @override
  List<Object> get props => [body, statusCode];

  @override
  bool get stringify => true;
}

class GoogleApiException extends Equatable implements Exception {
  final String code;
  final String errorMessage;

  GoogleApiException({
    @required this.code,
    this.errorMessage,
  });

  @override
  List<Object> get props => [code, errorMessage];
}
