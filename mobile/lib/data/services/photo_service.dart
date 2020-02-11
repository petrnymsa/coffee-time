import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/data/services/api_base.dart';
import 'package:logger/logger.dart';

abstract class PhotoService {
  String getPhotoUrl(String photoReference, {int maxWidth, int maxHeight});
}

class PhotoServiceImpl extends ApiBase implements PhotoService {
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
