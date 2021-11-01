import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final userKeyName = 'RhinoSoft-kerten-owu@user';
final countryKeyName = 'RhinoSoft-kerten-owu@country';
final cityKeyName = 'RhinoSoft-kerten-owu@city';
final presetKeyName = 'RhinoSoft-kerten-owu@preset';
final languageKeyName = 'RhinoSoft-kerten-owu@language';
final cartKeyName = 'RhinoSoft-kerten-owu@cart';
final categoryListKey = 'RhinoSoft-kerten-owu@categoriesList';
final productListKey = 'RhinoSoft-kerten-owu@productList';

class StorageProvider {
  get(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var value = prefs.getString(key);
    return prefs.containsKey(key) ? json.decode(value!) : null;
  }

  getList(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var value = prefs.getStringList(key);
    return prefs.containsKey(key) ? value : null;
  }

  set(key, value) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String object = jsonEncode(value);
    prefs.setString(key, object);
  }

  setList(key, value) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, json.encode(value));
  }

  clear(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }

  /// #### This get's the language stored on device from previous app use, used like this:
  /// ``` String language = StorageProvider().getLanguage();```
  /// ##### ~Huthaifa
  Future<String> getLanguage() async {
    var value = await get(languageKeyName);
    if (value != null) {
      return value;
    }
    return "en";
  }

  /// #### This get's the language stored on device from previous app use, used like this:
  /// ``` StorageProvider().setLanguage("en"); // or "ar"```
  /// ##### ~Huthaifa
  setLanguage(String language) {
    set(languageKeyName, language);
  }
}
