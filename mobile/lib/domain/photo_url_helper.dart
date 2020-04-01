import '../core/utils/query_string_builder.dart';

String createPhotoUrl(String baseUrl, {int maxWidth, int maxHeight}) {
  if (baseUrl == null) return null;

  if (maxWidth == null && maxHeight == null) {
    throw ArgumentError('MaxWidth or MaxHeight must be provided');
  }

  final queryBuilder = QueryStringBuilder();

  if (maxWidth != null) {
    maxWidth = maxWidth.clamp(1, 1600);
    queryBuilder.add('maxwidth', maxWidth);
  }
  if (maxHeight != null) {
    maxHeight = maxHeight.clamp(1, 1600);
    queryBuilder.add('maxheight', maxHeight);
  }

  if (queryBuilder.isNotEmpty) baseUrl += '?${queryBuilder.build()}';

  return baseUrl;
}

Map<String, String> createPhotoHttpHeader(String token) =>
    {'Authorization': 'Bearer $token'};
