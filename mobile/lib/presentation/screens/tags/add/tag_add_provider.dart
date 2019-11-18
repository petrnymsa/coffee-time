import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:flutter/foundation.dart';

class TagAddProvider with ChangeNotifier {
  List<TagEntity> chosenTags = [];

  InMemoryCafeRepository _cafeRepository = InMemoryCafeRepository.instance;

  List<TagEntity> availableTags;

  TagAddProvider(this.availableTags);

  void init() async {
    // final all = await _cafeRepository.getAllTags();
    // print(all);
    // all.forEach((t) {
    //   if (!entityTags.contains(t)) _availableTags.add(t);
    // });
    // notifyListeners();
  }

  void update(TagEntity tag) {
    if (chosenTags.contains(tag))
      chosenTags.remove(tag);
    else
      chosenTags.add(tag);
    notifyListeners();
  }
}
