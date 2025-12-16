import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionStorage {
  static const _keyToken = 'auth_token';

  final FlutterSecureStorage _storage;

  SessionStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  /// Sauvegarder le token
  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  /// Lire le token
  Future<String?> readToken() async {
    return await _storage.read(key: _keyToken);
  }

  /// Supprimer le token (logout)
  Future<void> clearToken() async {
    await _storage.delete(key: _keyToken);
  }
}
