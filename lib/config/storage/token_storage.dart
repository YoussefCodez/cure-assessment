import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TokenStorage {
  final FlutterSecureStorage _secureStorage;
  static const String _tokenKey = 'auth_token';

  const TokenStorage(this._secureStorage);

  Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(key: _tokenKey, value: token);
    } catch (e) {
      throw Exception('Failed to save token to secure storage: ${e.toString()}');
    }
  }

  Future<String?> getToken() async {
    try {
      return await _secureStorage.read(key: _tokenKey);
    } catch (e) {
      throw Exception('Failed to retrieve token from secure storage: ${e.toString()}');
    }
  }

  Future<void> clearToken() async {
    try {
      await _secureStorage.delete(key: _tokenKey);
    } catch (e) {
      throw Exception('Failed to clear token from secure storage: ${e.toString()}');
    }
  }

  Future<bool> hasToken() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check token existence: ${e.toString()}');
    }
  }
}
