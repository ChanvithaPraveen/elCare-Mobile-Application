import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Get integer value
/// Argument [key]
dynamic getInt(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    int? _res = prefs.getInt("$key");
    return _res;
}

/// Get string value
/// Argument [key]
dynamic getString(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? _res = prefs.getString("$key");
    return _res;
}


/// Get list or object
/// Use import 'dart:convert'; for jsonEncode
/// Argument [key]
dynamic getJson(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String jsonString = prefs.getString("$key")??"";
    var _res = jsonDecode(jsonString);
    return _res;
}
