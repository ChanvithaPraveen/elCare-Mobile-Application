import 'package:shared_preferences/shared_preferences.dart';

Future reset() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
}