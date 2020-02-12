class QueryStringBuilder {
  Map<String, dynamic> _map = {};

  bool get isNotEmpty => _map.isNotEmpty;

  QueryStringBuilder add(String key, dynamic value) {
    _map[key] = value;
    return this;
  }

  String build({bool clear = true}) {
    if (_map.isEmpty) return '';

    final params = [];
    _map.forEach((k, v) {
      if (v != null) {
        params.add('$k=${Uri.encodeComponent(v.toString())}');
      } else {
        params.add(k);
      }
    });

    if (clear) _map = {};

    return params.join('&');
  }
}
