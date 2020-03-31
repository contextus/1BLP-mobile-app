import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefsService {
  Future<void> setString(String key, String value);

  Future<String> getString(String key);

  Future<bool> getBool(String key);

  Future<void> setBool(String key, bool value);

  Future<int> getInt(String key);

  Future<void> setInt(String key, int value);
}

class FlutterSharedPrefsService implements SharedPrefsService {
  static SharedPreferences _preferences;

  static Future<SharedPreferences> get _pref async => _preferences ??= await SharedPreferences.getInstance();

  @override
  Future<void> setString(String key, String value) async => await _preferences.setString(key, value);

  @override
  Future<String> getString(String key) async => (await _pref).getString(key);

  @override
  Future<bool> getBool(String key) async => (await _pref).getBool(key);

  @override
  Future<void> setBool(String key, bool value) async => (await _pref).setBool(key, value);

  @override
  Future<int> getInt(String key) async => (await _pref).getInt(key);

  @override
  Future<void> setInt(String key, int value) async => (await _pref).setInt(key, value);
}
