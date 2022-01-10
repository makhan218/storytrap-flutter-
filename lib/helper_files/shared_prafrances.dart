import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // ignore: unused_field
  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  // static Future setStoryIndex(int storyID, int storyIndex) async {
  //   _preferences.set
  // }
}
