import '../../../core/network/api_client.dart';
import '../../../core/auth/session_storage.dart';

class AuthRepository {
  final ApiClient api;
  final SessionStorage sessionStorage;

  AuthRepository({required this.api, required this.sessionStorage});

  Future<void> login({required String email, required String password}) async {
    final response = await api.post('/api/login', {
      'email': email,
      'password': password,
    });

    final token = response['token'] as String;

    // 1️⃣ Injecter le token en mémoire
    api.setToken(token);

    // 2️⃣ Sauvegarder le token de façon sécurisée
    await sessionStorage.saveToken(token);
  }

  Future<void> logout() async {
    api.clearToken();
    await sessionStorage.clearToken();
  }

  /// Utilisé au démarrage de l'app
  Future<bool> restoreSession() async {
    final token = await sessionStorage.readToken();

    if (token == null) return false;

    // 1️⃣ Injecter le token
    api.setToken(token);

    try {
      // 2️⃣ Vérifier si le token est encore valide
      await api.get('/api/accounts');

      // ✅ Token valide
      return true;
    } catch (e) {
      // ❌ Token invalide / expiré / révoqué
      api.clearToken();
      await sessionStorage.clearToken();
      return false;
    }
  }
}
