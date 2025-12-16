import '../../../core/network/api_client.dart';
import '../models/transaction.dart';

class TransactionRepository {
  final ApiClient api;

  TransactionRepository({required this.api});

  Future<List<TransactionModel>> fetchTransactions({
    required int accountId,
  }) async {
    final response = await api.get(
      '/api/public/accounts/$accountId/transactions',
    );

    final List list = response is List ? response : response['data'] as List;

    return list.map<TransactionModel>((json) {
      return TransactionModel(
        title: json['title'],
        date: json['date'],
        amount: (json['amount'] as num).toDouble(),
        type: json['type'] == 'revenu'
            ? TransactionType.revenu
            : TransactionType.depense,
        group: json['group'],
      );
    }).toList();
  }
}
