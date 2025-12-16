import 'package:first/features/home/models/transaction.dart';

class TransactionsState {
  final List<TransactionModel> all;
  final TransactionType? selectedFilter;
  final bool isLoading;
  final String? error;

  const TransactionsState({
    required this.all,
    required this.selectedFilter,
    required this.isLoading,
    required this.error,
  });

  factory TransactionsState.initial() {
    return const TransactionsState(
      all: [],
      selectedFilter: null,
      isLoading: false,
      error: null,
    );
  }

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
    bool? isLoading,
    String? error,
  }) {
    return TransactionsState(
      all: all ?? this.all,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
