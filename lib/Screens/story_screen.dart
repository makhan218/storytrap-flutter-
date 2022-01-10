import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:storytrapflutter/Widgets/StoryScreenWidgets/left_message_image.dart';
import 'package:storytrapflutter/Widgets/StoryScreenWidgets/story_screen_data.dart';
import 'dart:developer' as dev;
import '../Widgets/StoryScreenWidgets/right_message_text.dart';
import '../Widgets/StoryScreenWidgets/left_message_text.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:storytrapflutter/home_data.dart';
import '../Widgets/StoryScreenWidgets/right_message_image.dart';
import '../Widgets/StoryScreenWidgets/contextual_message.dart';
import 'package:storytrapflutter/helper_files/read_story_manager.dart';

class StoryScrenn extends StatefulWidget {
  Stories story;
  int? indexToScrollTo;
  // String backgroundImage;
  // const StoryScrenn({Key? key}) : super(key: key);
  StoryScrenn({required this.story, this.indexToScrollTo});

  @override
  State<StoryScrenn> createState() => _StoryScrennState();
}

class _StoryScrennState extends State<StoryScrenn>
    with TickerProviderStateMixin {
  // Items in the list
  List<StoryContent> _items = [];
  late List<StoryContent> storyContent;
  late Stories story;
  int? indexToScrollTo;
  final _controller = ScrollController();
  StoryContentMain storyContentMain = StoryContentMain(
      storyContent: [],
      storyContentCount: 0,
      storyContentPageCount: -1,
      page: -1);

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 50),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.fastOutSlowIn,
  );

  // String get backgroundImage => widget.backgroundImage;

  @override
  void initState() {
    super.initState();
    story = widget.story;
    indexToScrollTo = widget.indexToScrollTo;
    fetchStoryContent(storyID: story.id);
  }

  void fetchStoryContent({required int storyID}) async {
    if (story.id < 1) {
      return;
    }
    try {
      final response = await get(Uri.parse(
          "https://api.storytrap.com/storycontents/story/$storyID?page=0&pageSize=500"));
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      // print(jsonData);

      storyContentMain = StoryContentMain.fromJson(jsonData);
      storyContent = storyContentMain.storyContent;
      // dev.debugger();
      if (indexToScrollTo != null &&
          (indexToScrollTo ?? 1) < storyContent.length) {
        for (int i = 0; i < (indexToScrollTo ?? 1); i++) {
          // _items.add(storyContent[i]);
          _addItem(i);
        }
      }
      Future.delayed(Duration(milliseconds: 500), () {
        _controller.animateTo(_controller.position.maxScrollExtent,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      });
    } catch (err) {
      print(err);
    }
  }

  // The key of the list
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final customCacheManager = CacheManager(
    Config('CacheKey', stalePeriod: Duration(days: 30)),
  );

  // Add a new item to the list
  // This is trigger when the floating button is pressed
  void _addItem(int tappedIndex) {
    // dev.debugger();
    ReadStoryManager.updateIndex(story.id, tappedIndex);
    if (_items.length >= storyContent.length) {
      ReadStoryManager.removeStory(story.id);
      print("Story no $story.id removed");
      return;
    }
    _items.add(storyContent[_items.length]);
    _key.currentState!
        .insertItem(_items.length - 1, duration: Duration(milliseconds: 200));
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    if (storyContent[index].type == "Message") {
      if (storyContent[index].sender ?? false) {
        return RightMessageText(
          animation: animation,
          context: context,
          index: index,
          parent: animation,
          tapHandler: _addItem,
          message: storyContent[index].text ?? "no text",
          name: storyContent[index].contactName ?? "no Name",
          bubbleColor: storyContent[index].contactBubbleColour ?? '#ffffff',
          nameTextColor: storyContent[index].contactNameColour ?? "#ffffff",
          contentTextColor: storyContent[index].contactTextColour ?? "#aabbcc",
        );
      } else {
        return LeftMessageText(
          animation: animation,
          context: context,
          index: index,
          parent: animation,
          tapHandler: _addItem,
          message: storyContent[index].text ?? "no text",
          name: storyContent[index].contactName ?? "no Name",
          bubbleColor: storyContent[index].contactBubbleColour ?? '#ffffff',
          nameTextColor: storyContent[index].contactNameColour ?? "#ffffff",
          contentTextColor: storyContent[index].contactTextColour ?? "#aabbcc",
        );
      }
    } else if (storyContent[index].type == "Picture") {
      if (storyContent[index].sender ?? false) {
        return RightMessageImage(
            nameColor: storyContent[index].contactNameColour ?? "",
            name: storyContent[index].contactName ?? "",
            imageURL: storyContent[index].path ?? '');
      } else {
        return LeftMessageImage(
            nameColor: storyContent[index].contactNameColour ?? "",
            name: storyContent[index].contactName ?? "",
            imageURL: storyContent[index].path ?? '');
      }
    } else if (storyContent[index].type == "Contextual") {
      return ContextualMessage(
          text: storyContent[index].text ?? " text ",
          textColor: storyContent[index].textColour ?? "");
    } else {
      return RightMessageText(
        animation: animation,
        context: context,
        index: index,
        parent: animation,
        tapHandler: _addItem,
        message: "no text",
        name: "no Name",
        bubbleColor: storyContent[index].contactBubbleColour ?? '#ffffff',
        nameTextColor: storyContent[index].contactNameColour ?? "#ffffff",
        contentTextColor: storyContent[index].contactTextColour ?? "#aabbcc",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0x00707070),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(story.coverImage.backGroundImage,
                cacheManager: customCacheManager),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          child: AnimatedList(
            controller: _controller,
            key: _key,
            initialItemCount: 0,
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 150, bottom: 300),
            itemBuilder: (_, index, animation) {
              return _buildItem(_, index, animation);
            },
          ),
          onTap: () {
            _addItem(_items.length);
          },
        ),
      ),
      // floatingActionButton:
      //     FloatingActionButton(onPressed: _addItem, child: Icon(Icons.add)),
    );
  }
}


// Remove an item
  // This is trigger when the trash icon associated with an item is tapped
  // void _removeItem(int index) {
  //   _key.currentState!.removeItem(index, (_, animation) {
  //     return SizeTransition(
  //       sizeFactor: animation,
  //       child: Card(
  //         margin: EdgeInsets.all(10),
  //         elevation: 10,
  //         color: Colors.purple,
  //         child: ListTile(
  //           contentPadding: EdgeInsets.all(15),
  //           title: Text("Goodbye", style: TextStyle(fontSize: 24)),
  //         ),
  //       ),
  //     );
  //     ;
  //   }, duration: Duration(seconds: 1));

  //   _items.removeAt(index);
  // }
