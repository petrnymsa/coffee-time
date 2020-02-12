import '../../core/utils/query_string_builder.dart';
import 'api_base.dart';

//ignore: one_member_abstracts
abstract class PhotoService {
  String getPhotoUrl(String photoReference, {int maxWidth, int maxHeight});
}

class PhotoServiceImpl implements PhotoService {
  @override
  String getPhotoUrl(String photoReference, {int maxWidth, int maxHeight}) {
    if (maxWidth == null && maxHeight == null) {
      throw ArgumentError('MaxWidth or MaxHeight must be provided');
    }

    var url = "${ApiBase.apiBaseUrl}/photo/$photoReference";

    final queryBuilder = QueryStringBuilder();

    if (maxWidth != null) {
      maxWidth = maxWidth.clamp(1, 1600);
      queryBuilder.add('maxwidth', maxWidth);
    }
    if (maxHeight != null) {
      maxHeight = maxHeight.clamp(1, 1600);
      queryBuilder.add('maxheight', maxHeight);
    }

    if (queryBuilder.isNotEmpty) url += '?${queryBuilder.build()}';

    return url;
  }
}
