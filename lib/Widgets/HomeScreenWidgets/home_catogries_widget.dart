import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storytrapflutter/navigation_drawer.dart';
import './horizontal_list.dart';
import 'package:storytrapflutter/route_generator.dart';
import 'package:http/http.dart';
import 'package:storytrapflutter/home_data.dart';
import 'package:storytrapflutter/helper_files/read_story_manager.dart';

class HomeCatogriesWidget extends StatefulWidget {
  List<StoriesByCategories> catogries;
  bool dataRecieved;
  double maxHeight;
  double maxWidth;
  // const HomeCatogriesWidget({Key? key}) : super(key: key);

  HomeCatogriesWidget(
      {required this.catogries,
      required this.dataRecieved,
      required this.maxHeight,
      required this.maxWidth});

  @override
  _HomeCatogriesWidgetState createState() => _HomeCatogriesWidgetState();
}

class _HomeCatogriesWidgetState extends State<HomeCatogriesWidget> {
  List<StoriesByCategories> catogries = [];
  double maxWidth = 0.0;
  double maxHeight = 0.0;
  bool dataRecieved = false;

  @override
  void initState() {
    super.initState();

    catogries = widget.catogries;
    maxWidth = widget.maxWidth;
    maxHeight = widget.maxHeight;
    dataRecieved = widget.dataRecieved;
  }

  void settingState() {
    setState(() {
      dataRecieved = true;
    });
  }

  List<HorizontalList> populateList() {
    List<HorizontalList> catoryWidgetList = [];
    if (!dataRecieved) {
      return catoryWidgetList;
    }
    if (ReadStoryManager.areStoriesRead()) {
      final continueReadingCatogry = ReadStoryManager.fetchReadStories();
      // dev.debugger();
      // print(continueReadingCatogry.stories.length);
      catoryWidgetList.add(HorizontalList(
        screenWidth: maxWidth,
        screenHeight: maxHeight,
        name: continueReadingCatogry.name,
        stories: continueReadingCatogry.stories,
        settingParentState: settingState,
      ));
    }
    // print(catoryWidgetList.length);
    for (int i = 0; i < catogries.length; i++) {
      catoryWidgetList.add(HorizontalList(
        screenHeight: maxHeight,
        screenWidth: maxWidth,
        name: catogries[i].name,
        stories: catogries[i].stories,
        settingParentState: settingState,
      ));
    }
    return catoryWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [...populateList()],
    );
  }
}
