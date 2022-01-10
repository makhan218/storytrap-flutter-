import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:storytrapflutter/home_data.dart';

class StoryScreenData {
  Stories story;
  int? indexTOForwardTo;
  StoryScreenData({required this.story, this.indexTOForwardTo});
}

class CatogryScreenData {
  final double screenWidth;
  final double screenHeight;
  final String name;
  final List<Stories> stories;
  final VoidCallback settingParentState;
  CatogryScreenData(
      {required this.screenWidth,
      required this.screenHeight,
      required this.name,
      required this.stories,
      required this.settingParentState});
}
