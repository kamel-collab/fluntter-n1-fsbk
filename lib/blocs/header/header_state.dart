import 'package:first/features/home/models/account.dart';

class HeaderState {
  final int currentPage;
  final bool isHidden;
  final List<Account> accounts;
  final bool isLoading;
  final String? error;

  const HeaderState({
    required this.currentPage,
    required this.isHidden,
    required this.accounts,
    required this.isLoading,
    required this.error,
  });

  factory HeaderState.initial() {
    return const HeaderState(
      currentPage: 0,
      isHidden: false,
      accounts: [],
      isLoading: false,
      error: null,
    );
  }

  HeaderState copyWith({
    int? currentPage,
    bool? isHidden,
    List<Account>? accounts,
    bool? isLoading,
    String? error,
  }) {
    return HeaderState(
      currentPage: currentPage ?? this.currentPage,
      isHidden: isHidden ?? this.isHidden,
      accounts: accounts ?? this.accounts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
