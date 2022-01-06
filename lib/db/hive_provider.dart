import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveProvider {
  static initHive() async {
    await Hive.initFlutter();
  }

  static openBox() async {
    await Hive.openBox(box_auth);
  }

  static const box_auth = "auth";
  static const key_is_logged_in = "is_logged_in";
  static const key_username = "user_name";


  static bool get isLoggedIn =>
      Hive.box(box_auth).get(key_is_logged_in, defaultValue: false);

  static set isLoggedIn(bool id) =>
      Hive.box(box_auth).put(key_is_logged_in, id);


  static String get username =>
      Hive.box(box_auth).get(key_username, defaultValue: "");

  static set username(String name) =>
      Hive.box(box_auth).put(key_username, name);


  static Future<void> setUserLoggedOut() async {
    await Hive.box(box_auth).clear();
  }

}
