// lib/blocs/header/header_state.dart

import 'package:first/features/home/models/account.dart';

class HeaderState {
  final int currentPage;
  final bool isHidden;
  final List<Account> accounts;

  const HeaderState({
    required this.currentPage,
    required this.isHidden,
    required this.accounts,
  });

  HeaderState copyWith({
    int? currentPage,
    bool? isHidden,
    List<Account>? accounts,
  }) {
    return HeaderState(
      currentPage: currentPage ?? this.currentPage,
      isHidden: isHidden ?? this.isHidden,
      accounts: accounts ?? this.accounts,
    );
  }
}
