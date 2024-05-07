import 'package:shared_preferences/shared_preferences.dart';

class Pomo {
  static SharedPreferences? pomo;

  static Future<(List, bool)> poooo() async {
    pomo = await SharedPreferences.getInstance();
    return ([], false);
  }
}
