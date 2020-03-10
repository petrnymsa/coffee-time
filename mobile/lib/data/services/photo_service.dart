import 'api_base.dart';

//ignore: one_member_abstracts
abstract class PhotoService {
  String getBasePhotoUrl(String photoReference);
}

class PhotoServiceImpl implements PhotoService {
  @override
  String getBasePhotoUrl(String photoReference) =>
      "${ApiBase.apiBaseUrl}/photo/$photoReference";
}
