import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persist local data using the platform's keychain.
abstract class SecureStorageService {
  /// Deletes a value associated with [key].
  Future<void> delete(String key);

  /// Gets a value associated with [key].
  Future<String> get(String key);

  /// Sets a value associated with [key].
  /// 
  /// If an existing already exists, it will replace the current associated value with [value].
  Future<void> set(String key, String value);
}

class FlutterSecureStorageService implements SecureStorageService {
  static final _storage = FlutterSecureStorage();

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<String> get(String key) => _storage.read(key: key);

  @override
  Future<void> set(String key, String value) => _storage.write(key: key, value: value);
}
