import 'package:hive_flutter/hive_flutter.dart';
import './stored_stories.dart';

class Boxes {
  static Box<StoredStoryList> getReadStories() =>
      Hive.box<StoredStoryList>("StoriesList");
}
