import 'package:flutter/material.dart';
import 'package:storytrapflutter/Widgets/StoryScreenWidgets/storyscreen_data.dart';
import 'package:storytrapflutter/home_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:storytrapflutter/helper_files/read_story_manager.dart';
import 'package:disposable_cached_images/disposable_cached_images.dart';

class CatogryDetailScreen extends StatelessWidget {
  final CatogryScreenData catogryData;
  final customCacheManager = CacheManager(
    Config('CacheKey', stalePeriod: Duration(days: 30)),
  );
  CatogryDetailScreen({required this.catogryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00707070),
      appBar: AppBar(
        title: Text(catogryData.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: buildGridView(),
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 3.5 / 5,
      ),
      itemCount: catogryData.stories.length,
      itemBuilder: (context, index) {
        return _itemBuilder(context: context, index: index);
      },
    );
  }

  Widget _itemBuilder({required BuildContext context, required int index}) {
    return GridTile(
        child: GestureDetector(
      onTap: () {
        final story = StoryScreenData(
            story: catogryData.stories[index],
            indexTOForwardTo: catogryData.stories[index].indexToScrollTo);
        if ((catogryData.stories[index].indexToScrollTo ?? 1) < 2) {
          print("story added");
          ReadStoryManager.storeStory(catogryData.stories[index]);
        }

        Navigator.of(context)
            .pushNamed(
              '/StoryScreen',
              arguments: story,
            )
            .then((_) => catogryData.settingParentState());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DisposableCachedImage.network(
          fit: BoxFit.cover,
          imageUrl: catogryData.stories[index].coverImage.coverImage,
          height: catogryData.screenHeight,
          // width: catogryData.screenWidth * 0.15,
          // progressIndicatorBuilder: (context, url, downloadProgress) =>
          //     Container(
          //   color: Colors.black12,
          // ),
          key: UniqueKey(),
          // cacheManager: customCacheManager,
          // CircularProgressIndicator(
          //     value: downloadProgress.progress),
          // errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    ));
  }
}
