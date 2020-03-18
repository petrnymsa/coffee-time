import 'package:flutter/foundation.dart';

import 'time_provider.dart';

typedef ExpirationCallBack<T> = Future<T> Function();

class CachedValue<T> {
  T _value;
  DateTime _timeStored;
  final Duration durability;

  final ExpirationCallBack<T> onExpire;

  final TimeProvider timeProvider;

  CachedValue(
    this.onExpire, {
    @required this.timeProvider,
    this.durability = const Duration(minutes: 15),
  });

  Future<T> get() async {
    if (_value == null ||
        timeProvider.now().difference(_timeStored).inMilliseconds >
            durability.inMilliseconds) {
      _value = await onExpire();
      _timeStored = timeProvider.now();
    }

    return _value;
  }
}
