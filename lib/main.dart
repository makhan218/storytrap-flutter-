import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:storytrapflutter/helper_files/read_story_manager.dart';
import 'package:storytrapflutter/helper_files/stored_stories.dart';
// import 'package:storytrapflutter/navigation_drawer.dart';
// import 'Widgets/HomeScreenWidgets/horizontal_list.dart';
import 'Widgets/HomeScreenWidgets/featured_story.dart';
// import 'Screens/story_screen.dart';
import './route_generator.dart';
import './navigation_drawer.dart';
import './home_data.dart';
import 'package:http/http.dart';
import 'Widgets/HomeScreenWidgets/home_catogries_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'helper_files/stored_stories.dart';
import 'helper_files/shared_prafrances.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

late Box box;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StoredStoryListAdapter());
  Hive.registerAdapter(StoredStoryAdapter());
  box = await Hive.openBox<StoredStoryList>("StoriesList");
  await SharedPref.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // await analytics.logEvent(name: 'Test_Event', parameters: {
  //   'product_id': 1234,
  // });

  // ReadStoryManager.deleteStoredStoryBox();

  runApp(const MaterialApp(
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
    // home: StoryScrenn(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final homeStoriesURL =
      "https://api.storytrap.com/stories/homepage?storyLimit=12";
  String featuredImageurl =
      "https://story-trap-media.s3.amazonaws.com/public/stories/292/media/StoryTrapFT.jpg";
  HomeData homeData = HomeData(storiesByCategories: [], featuredStories: []);
  bool dataRevieved = false;
  bool dataLoadingError = true;

  void fetchStories() async {
    try {
      final response = await get(Uri.parse(homeStoriesURL));

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        homeData = HomeData.fromJson(jsonData);

        // print(homeData.featuredStories[0].coverImage.featuredImage);
        // FirebaseCrashlytics.instance.crash();
        dataRevieved = true;
        dataLoadingError = false;
      });

      // print(homeData);
    } catch (err) {
      setState(() {
        dataRevieved = true;
        dataLoadingError = true;
      });
      // ignore: avoid_print
      print(err);
    }
  }

  void SetState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // drawer: const NavigationDrawer(),
      backgroundColor: Color(0x707070),
      drawer: NavigationDrawer(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (!dataRevieved) {
          return const Center(
            child: SpinKitCubeGrid(
              color: Colors.white,
              size: 20,
            ),
          );
        }
        // dev.debugger();

        if (dataRevieved && dataLoadingError) {
          // Fluttertoast.showToast(
          //     msg: "Data Loading Error", fontSize: 20, textColor: Colors.white);
          return const Center(
            child: Text(
              "Error Loading data",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return SingleChildScrollView(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FeaturedStoryWidget(
                  featuredStory: homeData.featuredStories[0].convertToStories(),
                  height: constraints.maxHeight,
                  settingParentState: SetState,
                  url: dataRevieved
                      ? homeData.featuredStories[0].coverImage.featuredImage ??
                          ''
                      : featuredImageurl,
                  width: (constraints.maxWidth * 0.816),
                ),
                HomeCatogriesWidget(
                    catogries: homeData.storiesByCategories,
                    dataRecieved: dataRevieved,
                    maxHeight: constraints.maxWidth,
                    maxWidth: constraints.maxHeight)
              ],
            ),
          ),
        );
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
