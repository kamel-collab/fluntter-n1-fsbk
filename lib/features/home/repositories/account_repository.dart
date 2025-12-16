import '../../../core/network/api_client.dart';
import '../models/account.dart';

class AccountRepository {
  final ApiClient api;

  AccountRepository({required this.api});
  Future<List<Account>> fetchAccounts() async {
    final response = await api.get('/api/public/accounts');

    final List list = response is List ? response : response['data'] as List;

    return list.map<Account>((json) {
      return Account(
        label: json['label'],
        solde: (json['solde'] as num).toDouble(),
        veille: (json['veille'] as num).toDouble(),
      );
    }).toList();
  }
}
