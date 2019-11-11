import 'package:flutter/foundation.dart';

enum ProviderState {
  busy,
  error,
  idle,
}

abstract class ProviderError {}

class WithoutError extends ProviderError {}

abstract class BaseProvider<TError extends ProviderError> with ChangeNotifier {
  ProviderState _state;

  TError _error;

  ProviderState get state => _state;

  TError get error => _error;

  void _setState(ProviderState state) {
    print('change state to $_state');
    _state = state;
    notifyListeners();
  }

  @protected
  void setBusy() => _setState(ProviderState.busy);

  @protected
  void setIdle() => _setState(ProviderState.idle);

  @protected
  void setError(TError error) {
    _error = error;
    _setState(ProviderState.error);
  }
}
