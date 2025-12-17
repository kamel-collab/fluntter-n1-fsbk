import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class ApiClient {
  final http.Client _client;
  String? _token;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  /// Injecter le token (après login)
  void setToken(String token) {
    _token = token;
  }

  /// Supprimer le token (logout plus tard)
  void clearToken() {
    _token = null;
  }

  Map<String, String> get _headers {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }

    return headers;
  }

  Future<dynamic> get(String path) async {
    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: _headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error ${response.statusCode}');
    }
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: _headers,
      body: jsonEncode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error ${response.statusCode}');
    }
  }

  /// 🔁 Transfert interne (utilise le Bearer token)
  Future<Map<String, dynamic>> transfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    String title = "Transfert",
  }) async {
    final response = await post('/api/transfer', {
      'from_account_id': fromAccountId,
      'to_account_id': toAccountId,
      'amount': amount,
      'title': title,
    });

    return response as Map<String, dynamic>;
  }
}
