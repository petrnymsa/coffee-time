import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/data/services/api_base.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

abstract class PhotoService {
  String getPhotoUrl(String photoReference, {int maxWidth, int maxHeight});
}

class PhotoServiceImpl extends ApiBase implements PhotoService {
  PhotoServiceImpl({@required http.Client client}) : super(client: client);

  @override
  String getPhotoUrl(String photoReference, {int maxWidth, int maxHeight}) {
    if (maxWidth == null && maxHeight == null) {
      throw new ArgumentError('MaxWidth or MaxHeight must be provided');
    }

    var url = "${ApiBase.API_BASE_URL}/photo/$photoReference?";

    if (maxWidth != null) {
      maxWidth = maxWidth.clamp(1, 1600);
      url += 'maxwidth=$maxWidth&';
    }
    if (maxHeight != null) {
      maxHeight = maxHeight.clamp(1, 1600);
      url += 'maxheight=$maxHeight';
    }

    getLogger('PhotoService').i(url);
    return url;
  }
}
