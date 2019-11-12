import 'package:flutter/foundation.dart';

enum ProviderState {
  busy,
  error,
  ready,
}

abstract class ProviderError {}

class WithoutError extends ProviderError {}

abstract class BaseProvider<TError extends ProviderError> with ChangeNotifier {
  ProviderState _state;

  TError _error;

  ProviderState get state => _state;

  TError get error => _error;

  void _setState(ProviderState state) {
    _state = state;
    notifyListeners();
  }

  @protected
  void setBusy() => _setState(ProviderState.busy);

  @protected
  void setReady() => _setState(ProviderState.ready);

  @protected
  void setError(TError error) {
    _error = error;
    _setState(ProviderState.error);
  }
}
