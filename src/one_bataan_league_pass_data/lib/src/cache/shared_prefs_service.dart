import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static SharedPreferences _preferences;

  static Future<SharedPreferences> get _pref async => _preferences ??= await SharedPreferences.getInstance();

  Future<void> setString(String key, String value) async => await _preferences.setString(key, value);

  Future<String> getString(String key) async => (await _pref).getString(key);

  Future<bool> getBool(String key) async => (await _pref).getBool(key);

  Future<void> setBool(String key, bool value) async => (await _pref).setBool(key, value);

  Future<int> getInt(String key) async => (await _pref).getInt(key);

  Future<void> setInt(String key, int value) async => (await _pref).setInt(key, value);
}
