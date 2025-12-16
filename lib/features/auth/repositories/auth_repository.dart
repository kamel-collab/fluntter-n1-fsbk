import '../../../core/network/api_client.dart';

class AuthRepository {
  final ApiClient api;

  AuthRepository({required this.api});

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await api.post('/api/login', {
      'email': email,
      'password': password,
    });

    final token = response['token'] as String;
    print('Token reçu: $token');
    // Injecter le token dans l’ApiClient
    api.setToken(token);

    return token;
  }
}
