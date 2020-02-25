import 'package:http/http.dart';

abstract class HttpClientFactory {
  Client create();
}

class HttpClientFactoryImpl implements HttpClientFactory {
  @override
  Client create() => Client();
}
