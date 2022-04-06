import 'package:flutter/material.dart';
import 'package:storytrapflutter/Widgets/StoryScreenWidgets/storyscreen_data.dart';
import 'package:storytrapflutter/home_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:disposable_cached_images/disposable_cached_images.dart';

// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:storytrapflutter/helper_files/stored_stories.dart';
// import 'package:storytrapflutter/helper_files/boxes.dart';
// import 'package:storytrapflutter/Widgets/StoryScreenWidgets/story_screen_data.dart';
import 'package:storytrapflutter/helper_files/read_story_manager.dart';
// import 'dart:developer' as dev;

class HorizontalList extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String name;
  final List<Stories> stories;
  final VoidCallback settingParentState;
  final customCacheManager = CacheManager(
    Config('CacheKey', stalePeriod: Duration(days: 30)),
  );

  HorizontalList(
      {required this.screenWidth,
      required this.screenHeight,
      required this.name,
      required this.stories,
      required this.settingParentState});

  // void storeStory(Stories story) {
  //   final StoredStory storedStory = StoredStory(
  //       storyid: story.id, index: 1, coverImage: story.coverImage.coverImage);
  //   Box box = Boxes.getReadStories();
  //   final list = box.values.toList().cast<StoredStoryList>();
  //   // box.deleteAt(0);
  //   // return;
  //   // list.add(StoredStoryList(stories: [storedStory]));
  //   dev.debugger();
  //   if (list.isNotEmpty) {
  //     bool found = false;
  //     int index = -1;
  //     for (int i = 0; i < list[0].stories.length; i++) {
  //       if (list[0].stories[i].storyid == storedStory.storyid) {
  //         found = true;
  //         index = i;
  //       }
  //     }
  //     if (found) {
  //       list[0].stories.removeAt(index);
  //       list[0].stories.add(storedStory);
  //     } else {
  //       list[0].stories.add(storedStory);
  //     }
  //   } else {
  //     list.add(StoredStoryList(stories: [storedStory]));
  //   }

  //   // list.stories.add(storedStory);

  //   print(list.length);
  //   for (int i = 0; i < list.length; i++) {
  //     print(list[i]);
  //     print(list[i].stories.length);
  //     for (var item in list[i].stories) {
  //       print(item.storyid);
  //     }
  //   }
  //   // list ??= [];
  //   // list.add(storedStory);
  //   box.put('StoriesList', list[0]);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              child: const Text(
                "See All",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/CatogryScreen",
                    arguments: CatogryScreenData(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        name: name,
                        stories: stories,
                        settingParentState: settingParentState));
              },
            )
          ],
        ),
        SizedBox(
          width: screenWidth,
          // screenWidth,
          height: screenHeight * 0.45,
          // screenHeight * 0.19
          child: Container(
            child: ListView.builder(
                itemCount: stories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // dev.debugger();
                      // print(stories[index].indexToScrollTo);
                      final story = StoryScreenData(
                          story: stories[index],
                          indexTOForwardTo: stories[index].indexToScrollTo);
                      if ((stories[index].indexToScrollTo ?? 1) < 2) {
                        print("story added");
                        ReadStoryManager.storeStory(stories[index]);
                      }

                      Navigator.of(context)
                          .pushNamed(
                            '/StoryScreen',
                            arguments: story,
                          )
                          .then((_) => settingParentState());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DisposableCachedImage.network(
                        fit: BoxFit.fill,
                        imageUrl: stories[index].coverImage.coverImage,
                        width: screenWidth * 0.15,
                        isDynamicHeight: true,
                        // progressIndicatorBuilder:
                        //     (context, url, downloadProgress) => Container(
                        //   color: Colors.black12,
                        // ),
                        key: UniqueKey(),
                        // cacheManager: customCacheManager,
                        // CircularProgressIndicator(
                        //     value: downloadProgress.progress),
                        // errorWidget: (context, url, error) =>
                        //     const Icon(Icons.error),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
