import 'package:storytrapflutter/helper_files/stored_stories.dart';
import 'package:storytrapflutter/helper_files/boxes.dart';
import 'package:storytrapflutter/home_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'dart:developer' as dev;

class ReadStoryManager {
  static StoriesByCategories fetchReadStories() {
    Box box = Boxes.getReadStories();
    final list = box.values.toList().cast<StoredStoryList>();
    if (list.isEmpty) {
      return StoriesByCategories(id: -1, name: "Continue Reading", stories: []);
    }
    final storedStories = list[0].stories;
    List<Stories> stories = [];
    for (int i = 0; i < storedStories.length; i++) {
      stories.add(Stories(
          id: storedStories[i].storyid,
          title: "From Local",
          coverImage: StoryCoverImage(
              coverImage: storedStories[i].coverImage,
              backGroundImage: storedStories[i].backgroundImage ?? "",
              featuredImage: ''),
          categoryId: -1,
          authorName: "local data",
          tags: [],
          indexToScrollTo: storedStories[i].index));
      // dev.debugger();
      // print(storedStories[i].index);
      // print("fetch stories called");
    }
    stories = stories.reversed.toList();
    StoriesByCategories catogry =
        StoriesByCategories(id: -1, name: "Continue Reading", stories: stories);
    return catogry;
  }

  static bool areStoriesRead() {
    Box box = Boxes.getReadStories();
    final list = box.values.toList().cast<StoredStoryList>();
    if (list.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static void deleteStoredStoryBox() {
    Box box = Boxes.getReadStories();
    box.deleteAt(0);
    return;
  }

  static void updateIndex(int storyID, indexStory) {
    // dev.debugger();
    // print(indexStory);
    // print(storyID);
    Box box = Boxes.getReadStories();
    final list = box.values.toList().cast<StoredStoryList>();
    if (list.isNotEmpty) {
      bool found = false;
      int index = -1;
      for (int i = 0; i < list[0].stories.length; i++) {
        if (list[0].stories[i].storyid == storyID) {
          found = true;
          index = i;
        }
      }
      if (found) {
        list[0].stories[index].index = indexStory;
      }
    }
  }

  static void removeStory(int storyID) {
    // dev.debugger();
    // print(indexStory);
    // print(storyID);
    Box box = Boxes.getReadStories();
    final list = box.values.toList().cast<StoredStoryList>();
    if (list.isNotEmpty) {
      bool found = false;
      int index = -1;
      for (int i = 0; i < list[0].stories.length; i++) {
        if (list[0].stories[i].storyid == storyID) {
          found = true;
          index = i;
        }
      }
      if (found) {
        list[0].stories.removeAt(index);
      }
    }
  }

  static void storeStory(Stories story) {
    final StoredStory storedStory = StoredStory(
        storyid: story.id,
        index: 1,
        coverImage: story.coverImage.coverImage,
        backgroundImage: story.coverImage.backGroundImage);
    Box box = Boxes.getReadStories();
    final list = box.values.toList().cast<StoredStoryList>();
    // box.deleteAt(0);
    // return;
    // list.add(StoredStoryList(stories: [storedStory]));

    if (list.isNotEmpty) {
      bool found = false;
      int index = -1;
      for (int i = 0; i < list[0].stories.length; i++) {
        if (list[0].stories[i].storyid == storedStory.storyid) {
          found = true;
          index = i;
        }
      }
      if (found) {
        list[0].stories.removeAt(index);
        list[0].stories.add(storedStory);
      } else {
        list[0].stories.add(storedStory);
      }
    } else {
      list.add(StoredStoryList(stories: [storedStory]));
    }

    // list.stories.add(storedStory);

    // print(list.length);
    // for (int i = 0; i < list.length; i++) {
    //   print(list[i]);
    //   print(list[i].stories.length);
    //   for (var item in list[i].stories) {
    //     print(item.storyid);
    //   }
    // }
    // list ??= [];
    // list.add(storedStory);
    box.put('StoriesList', list[0]);
  }
}
