import 'package:flutter/foundation.dart';

import '../../core/app_config.dart';

//ignore: one_member_abstracts
abstract class PhotoService {
  String getBasePhotoUrl(String photoReference);
}

class PhotoServiceImpl implements PhotoService {
  final AppConfig appConfig;

  PhotoServiceImpl({
    @required this.appConfig,
  });

  @override
  String getBasePhotoUrl(String photoReference) =>
      "${appConfig.apiUrl}/photo/$photoReference";
}
