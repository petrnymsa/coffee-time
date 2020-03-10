import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'failure.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  const factory Failure(Object inner) = CommonFailure;
  const factory Failure.notFound() = NotFound;
  const factory Failure.serviceFailure(String message, {Object inner}) =
      ServiceFailure;
}
