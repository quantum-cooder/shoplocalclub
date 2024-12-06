import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserApiToken {
  static const _storage = FlutterSecureStorage();

  static Future<void> storeToken(String token) async {
    await _storage.write(key: 'api_token', value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'api_token');
  }

  static Future<void> deleteToke() async {
    await _storage.delete(key: 'api_token');
  }
}
