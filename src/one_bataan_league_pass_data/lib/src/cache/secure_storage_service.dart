import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageService {
  Future<void> delete(String key);

  Future<String> get(String key);

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
