import 'package:shared_preferences/shared_preferences.dart';

/// Persist local data using the platform's shared preferences.
abstract class SharedPrefsService {
  /// Sets a [String] value with associated [key].
  Future<void> setString(String key, String value);

  /// Gets a [String] value with associated [key].
  Future<String> getString(String key);

  /// Gets a [bool] value with associated [key].
  Future<bool> getBool(String key);

  /// Sets a [bool] value with associated [key].
  Future<void> setBool(String key, bool value);

  /// Gets a [int] value with associated [key].
  Future<int> getInt(String key);

  /// Sets a [int] value with associated [key].
  Future<void> setInt(String key, int value);

  /// Removes a value with associated [key].
  Future<void> remove(String key);
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

  @override
  Future<void> remove(String key) async => (await _pref).remove(key);
}
