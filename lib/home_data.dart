import 'dart:convert';

class HomeData {
  late List<StoriesByCategories> storiesByCategories;
  late List<FeaturedStory> featuredStories;

  HomeData({required storiesByCategories, required featuredStories});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['storiesByCategories'] != null) {
      storiesByCategories = [];

      // new List<StoriesByCategories>();
      json['storiesByCategories'].forEach((v) {
        storiesByCategories.add(StoriesByCategories.fromJson(v));
      });
    }

    if (json['featuredStory'] != null) {
      featuredStories = [];
      // List<FeaturedStory>();
      json['featuredStory'].forEach((v) {
        featuredStories.add(FeaturedStory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storiesByCategories'] =
        storiesByCategories.map((v) => v.toJson()).toList();

    data['featuredStory'] = featuredStories.map((v) => v.toJson()).toList();
    return data;
  }
}

class StoriesByCategories {
  int id = -1;
  String name = "initial";
  List<Stories> stories = [];

  StoriesByCategories(
      {required this.id, required this.name, required this.stories});

  StoriesByCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['Stories'] != null) {
      stories = [];
      // new List<Stories>();
      json['Stories'].forEach((v) {
        stories.add(Stories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['Stories'] = stories.map((v) => v.toJson()).toList();
    return data;
  }
}

class Stories {
  late int id;
  late String title;
  late StoryCoverImage coverImage;
  late int categoryId;
  late String authorName;
  int? indexToScrollTo;
  late List<Tags> tags;

  Stories(
      {required this.id,
      required this.title,
      required this.coverImage,
      required this.categoryId,
      required this.authorName,
      required this.tags,
      this.indexToScrollTo});

  Stories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    coverImage = (json['coverImage'] != null
        ? StoryCoverImage.fromJson(jsonDecode(json['coverImage']))
        : null)!;
    // json['coverImage'];
    categoryId = json['CategoryId'];
    authorName = json['authorName'];
    if (json['Tags'] != null) {
      tags = [];
      // new List<Tags>();
      json['Tags'].forEach((v) {
        tags.add(Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['coverImage'] = coverImage.toJson();
    data['CategoryId'] = categoryId;
    data['authorName'] = authorName;
    data['Tags'] = tags.map((v) => v.toJson()).toList();
    return data;
  }
}

class Tags {
  late String name;

  Tags({required this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class FeaturedStories {
  late List<FeaturedStory> featuredStory;

  FeaturedStories({required this.featuredStory});

  FeaturedStories.fromJson(Map<String, dynamic> json) {
    // print(json);
    if (json['featuredStory'] != null) {
      featuredStory = [];
      // new List<FeaturedStory>();
      json['featuredStory'].forEach((v) {
        featuredStory.add(FeaturedStory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['featuredStory'] = featuredStory.map((v) => v.toJson()).toList();
    return data;
  }
}

class FeaturedStory {
  late int id;
  late String title;
  late StoryCoverImage coverImage;
  late String publishedAt;
  late int categoryId;
  late String authorName;
  late List<Tags> tags;

  FeaturedStory(
      {required this.id,
      required this.title,
      required this.coverImage,
      required this.publishedAt,
      required this.categoryId,
      required this.authorName,
      required this.tags});

  FeaturedStory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    // print(jsonDecode(json['coverImage']));

    coverImage = (json['coverImage'] != null
        ? StoryCoverImage.fromJson(jsonDecode(json['coverImage']))
        : null)!;
    publishedAt = json['publishedAt'];
    categoryId = json['CategoryId'];
    authorName = json['authorName'];
    if (json['Tags'] != null) {
      tags = [];

      // new List<Tags>();
      json['Tags'].forEach((v) {
        tags.add(Tags.fromJson(v));
      });
    }
  }

  Stories convertToStories() {
    return Stories(
        id: id,
        title: title,
        coverImage: coverImage,
        categoryId: categoryId,
        authorName: authorName,
        tags: tags);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['coverImage'] = coverImage.toJson();
    data['publishedAt'] = publishedAt;
    data['CategoryId'] = categoryId;
    data['authorName'] = authorName;
    data['Tags'] = tags.map((v) => v.toJson()).toList();
    return data;
  }
}

class CoverImage {
  late String coverImage;
  late String featuredImage;
  late String backGroundImage;

  CoverImage(
      {required this.coverImage,
      required this.featuredImage,
      required this.backGroundImage});

  CoverImage.fromJson(Map<String, dynamic> json) {
    coverImage = json['coverImage'];
    coverImage = coverImage.replaceAll(
        "https://story-trap-media.s3.amazonaws.com",
        "https://ddof5phgx78dy.cloudfront.net");
    featuredImage = json['featuredImage'];
    featuredImage = featuredImage.replaceAll(
        "https://story-trap-media.s3.amazonaws.com",
        "https://ddof5phgx78dy.cloudfront.net");
    backGroundImage = json['backGroundImage'];
    backGroundImage = backGroundImage.replaceAll(
        "https://story-trap-media.s3.amazonaws.com",
        "https://ddof5phgx78dy.cloudfront.net");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coverImage'] = coverImage;
    data['featuredImage'] = featuredImage;
    data['backGroundImage'] = backGroundImage;
    return data;
  }
}

class StoryCoverImage {
  late String coverImage;
  String? featuredImage = '';
  late String backGroundImage;

  StoryCoverImage(
      {required this.coverImage,
      required this.featuredImage,
      required this.backGroundImage});

  StoryCoverImage.fromJson(Map<String, dynamic> json) {
    coverImage = json['coverImage'];
    coverImage = coverImage.replaceAll(
        "https://story-trap-media.s3.amazonaws.com",
        "https://ddof5phgx78dy.cloudfront.net");
    featuredImage = json['featuredImage'];
    featuredImage = featuredImage?.replaceAll(
        "https://story-trap-media.s3.amazonaws.com",
        "https://ddof5phgx78dy.cloudfront.net");
    backGroundImage = json['backGroundImage'];
    backGroundImage = backGroundImage.replaceAll(
        "https://story-trap-media.s3.amazonaws.com",
        "https://ddof5phgx78dy.cloudfront.net");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coverImage'] = coverImage;
    data['featuredImage'] = featuredImage;
    data['backGroundImage'] = backGroundImage;
    return data;
  }
}
