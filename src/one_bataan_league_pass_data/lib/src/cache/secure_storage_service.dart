import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = FlutterSecureStorage();

  Future<void> delete(String key) => _storage.delete(key: key);

  Future<String> get(String key) => _storage.read(key: key);

  Future<void> set(String key, String value) => _storage.write(key: key, value: value);
}
