import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

//ignore: one_member_abstracts
abstract class FavoriteService {
  Future<List<String>> getFavorites(String userId);
  Future<void> setFavorite(String userId, String placeId);
}

class FavoriteLocalService implements FavoriteService {
  List<String> _getData(SharedPreferences preferences, String id) {
    final data = preferences.getString(id);

    if (data != null) {
      return (json.decode(data) as List<dynamic>).cast<String>();
    }

    return [];
  }

  @override
  Future<List<String>> getFavorites(String userId) async {
    final preferences = await SharedPreferences.getInstance();
    return _getData(preferences, userId);
  }

  @override
  Future<void> setFavorite(String userId, String placeId) async {
    final preferences = await SharedPreferences.getInstance();

    final data = _getData(preferences, userId);

    if (data.isEmpty) {
      preferences.setString(userId, json.encode([placeId]));
      return;
    }

    final result = data.firstWhere((x) => x == placeId, orElse: () => null);

    if (result != null) {
      data.remove(result);
    } else {
      data.add(placeId);
    }

    await preferences.setString(userId, json.encode(data));
  }
}
