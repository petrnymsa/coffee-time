import 'package:meta/meta.dart';

part 'either.freezed.dart';

@immutable
abstract class Either<L, R> with _$Either<L, R> {
  const factory Either.left(L left) = Left<L, R>;
  const factory Either.right(R right) = Right<L, R>;
}
