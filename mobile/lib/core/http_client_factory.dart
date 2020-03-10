import 'package:http/http.dart';

//ignore_for_file: one_member_abstracts
abstract class HttpClientFactory {
  Client create();
}

class HttpClientFactoryImpl implements HttpClientFactory {
  @override
  Client create() => Client();
}
