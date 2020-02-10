import 'package:coffee_time/domain/entities/tag.dart';
import 'package:flutter/foundation.dart';

class TagAddProvider with ChangeNotifier {
  List<Tag> chosenTags = [];
  List<Tag> availableTags;

  TagAddProvider(this.availableTags);

  void update(Tag tag) {
    if (chosenTags.contains(tag))
      chosenTags.remove(tag);
    else
      chosenTags.add(tag);
    notifyListeners();
  }
}
