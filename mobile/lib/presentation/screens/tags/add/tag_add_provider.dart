import 'package:coffee_time/domain/entities/tag.dart';
import 'package:flutter/foundation.dart';

class TagAddProvider with ChangeNotifier {
  List<TagEntity> chosenTags = [];
  List<TagEntity> availableTags;

  TagAddProvider(this.availableTags);

  void update(TagEntity tag) {
    if (chosenTags.contains(tag))
      chosenTags.remove(tag);
    else
      chosenTags.add(tag);
    notifyListeners();
  }
}
