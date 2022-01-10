import 'package:flutter/material.dart';
import 'package:storytrapflutter/Widgets/StoryScreenWidgets/storyscreen_data.dart';
import 'Screens/story_screen.dart';
import './main.dart';
import 'Screens/feedback_screen.dart';
import 'home_data.dart';
import 'Screens/detail_image_screen.dart';
import 'package:storytrapflutter/Screens/catogry_detail_screen.dart';
import 'package:storytrapflutter/Widgets/StoryScreenWidgets/story_screen_data.dart';

class RouteGenerator extends StatelessWidget {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: 'title',
                ));
      case "/StoryScreen":
        return MaterialPageRoute(
            builder: (_) => StoryScrenn(
                  story: (arg as StoryScreenData).story,
                  indexToScrollTo: (arg as StoryScreenData).indexTOForwardTo,
                  // backgroundImage: arg[1] as String,
                ));
      case "/DetailScreenImage":
        return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => DetailImageScreen(imageUrl: arg as String));
      case "/FeedbackScreen":
        return MaterialPageRoute(builder: (_) => const FeedbackScreen());
      case "/CatogryScreen":
        return MaterialPageRoute(
            builder: (_) => CatogryDetailScreen(
                  catogryData: arg as CatogryScreenData,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: "title",
                ));
    }
  }

  const RouteGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
