// lib/blocs/transactions/transactions_state.dart

import 'package:first/features/home/models/transaction.dart';

class TransactionsState {
  final List<TransactionModel> all;
  final TransactionType? selectedFilter;

  const TransactionsState({required this.all, required this.selectedFilter});

  List<TransactionModel> get filtered {
    if (selectedFilter == null) return all;
    return all.where((t) => t.type == selectedFilter).toList();
  }

  Map<String, List<TransactionModel>> get grouped {
    final Map<String, List<TransactionModel>> groups = {};
    for (var t in filtered) {
      groups.putIfAbsent(t.group, () => []);
      groups[t.group]!.add(t);
    }
    return groups;
  }

  TransactionsState copyWith({
    List<TransactionModel>? all,
    TransactionType? selectedFilter,
  }) {
    return TransactionsState(
      all: all ?? this.all,
      selectedFilter: selectedFilter,
    );
  }
}
