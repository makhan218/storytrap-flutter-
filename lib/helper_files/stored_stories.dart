import 'package:hive/hive.dart';
import 'package:storytrapflutter/Widgets/StoryScreenWidgets/story_screen_data.dart';

part 'stored_stories.g.dart';

@HiveType(typeId: 1)
class StoredStory extends HiveObject {
  StoredStory(
      {required this.storyid,
      required this.index,
      required this.coverImage,
      required this.backgroundImage});

  @HiveField(0)
  int storyid;

  @HiveField(1)
  int index;

  // @HiveField(2)
  // List<StoredStory> stored_stories_list;

  @HiveField(3)
  String coverImage;
  @HiveField(4)
  String? backgroundImage;
}

@HiveType(typeId: 2)
class StoredStoryList extends HiveObject {
  StoredStoryList({
    required this.stories,
  });

  @HiveField(0)
  List<StoredStory> stories;
}
