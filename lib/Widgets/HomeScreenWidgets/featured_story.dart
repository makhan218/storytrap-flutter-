import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:storytrapflutter/home_data.dart';
import 'package:storytrapflutter/Widgets/StoryScreenWidgets/storyscreen_data.dart';
import 'package:storytrapflutter/helper_files/read_story_manager.dart';
import 'dart:developer' as dev;

class FeaturedStoryWidget extends StatelessWidget {
  final Stories featuredStory;
  double width;
  double height;
  String url;
  final VoidCallback settingParentState;
  final customCacheManager = CacheManager(
    Config('CacheKey', stalePeriod: Duration(days: 30)),
  );

  FeaturedStoryWidget(
      {required this.width,
      required this.height,
      required this.url,
      required this.featuredStory,
      required this.settingParentState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(34, 90, 34, 10),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: GestureDetector(
                child: CachedNetworkImage(
                  imageUrl: url,
                  width: width,
                  height: height * 0.3,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                    color: Colors.black12,
                  ),
                  key: UniqueKey(),
                  cacheManager: customCacheManager,

                  // CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                onTap: () {
                  // print(stories[index].indexToScrollTo);
                  // dev.debugger();
                  final story = StoryScreenData(
                      story: featuredStory,
                      indexTOForwardTo: featuredStory.indexToScrollTo);
                  if ((featuredStory.indexToScrollTo ?? 1) < 2) {
                    print("story added");
                    ReadStoryManager.storeStory(featuredStory);
                  }

                  Navigator.of(context)
                      .pushNamed(
                        '/StoryScreen',
                        arguments: story,
                      )
                      .then((_) => settingParentState());
                },
              ))
        ],
      ),
    );
  }
}
