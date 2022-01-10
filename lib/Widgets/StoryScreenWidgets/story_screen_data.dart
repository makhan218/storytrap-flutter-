import 'dart:convert';

import 'package:flutter/material.dart';

class StoryContentMain {
  late List<StoryContent> storyContent;
  late int storyContentCount;
  late int storyContentPageCount;
  late int page;

  StoryContentMain(
      {required this.storyContent,
      required this.storyContentCount,
      required this.storyContentPageCount,
      required this.page});

  StoryContentMain.fromJson(Map<String, dynamic> json) {
    if (json['storyContent'] != null) {
      storyContent = [];
      //  new List<StoryContent>();
      json['storyContent'].forEach((v) {
        storyContent.add(StoryContent.fromJson(v));
      });
    }
    storyContentCount = json['storyContentCount'];
    storyContentPageCount = json['storyContentPageCount'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storyContent'] = storyContent.map((v) => v.toJson()).toList();
    data['storyContentCount'] = storyContentCount;
    data['storyContentPageCount'] = storyContentPageCount;
    data['page'] = page;
    return data;
  }
}

class StoryContent {
  late int id;
  late String? type;
  late String? contactName;
  late String? text;
  late bool? sender;
  late String? path;
  late String? contactNameColour;
  late String? contactBubbleColour;
  late String? contactTextColour;
  late String? textColour;
  late int storyId;

  StoryContent(
      {required this.id,
      required this.type,
      required this.contactName,
      required this.text,
      required this.sender,
      required this.path,
      required this.contactNameColour,
      required this.contactBubbleColour,
      required this.contactTextColour,
      required this.storyId,
      required this.textColour});

  StoryContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    contactName = json['contactName'];
    text = json['text'];
    sender = json['sender'];
    path = json['path'];
    if (path != null) {
      var temp = jsonDecode(json['path']);
      path = temp['path'];
      path = path?.replaceAll("https://story-trap-media.s3.amazonaws.com",
          "https://ddof5phgx78dy.cloudfront.net");
    }
    contactNameColour = json['contactNameColour'];
    contactBubbleColour = json['contactBubbleColour'];
    contactTextColour = json['contactTextColour'];
    storyId = json['StoryId'];
    textColour = json['textColour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['contactName'] = contactName;
    data['text'] = text;
    data['sender'] = sender;
    data['path'] = path;
    data['contactNameColour'] = contactNameColour;
    data['contactBubbleColour'] = contactBubbleColour;
    data['contactTextColour'] = contactTextColour;
    data['StoryId'] = storyId;
    data['textColour'] = textColour;
    return data;
  }
}
