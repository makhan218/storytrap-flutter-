// import 'dart:js';

import 'package:flutter/material.dart';
import './route_generator.dart';
// import 'Widgets/HomeScreenWidgets/horizontal_list.dart';
// import 'Widgets/HomeScreenWidgets/featured_story.dart';
// import 'Screens/story_screen.dart';
import './route_generator.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.black,
        child: ListView(
          padding: padding,
          children: [
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(text: "text", icon: Icons.people, context: context),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text,
      required IconData icon,
      required BuildContext context}) {
    const color = Colors.white;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/FeedbackScreen',
        );
      },
    );
  }
}
