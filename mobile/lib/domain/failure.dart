import 'package:flutter/foundation.dart';

part 'failure.freezed.dart';

@immutable
abstract class Failure with _$Failure {
  const factory Failure(String message) = CommonFailure;
  const factory Failure.notFound() = NotFound;
}
