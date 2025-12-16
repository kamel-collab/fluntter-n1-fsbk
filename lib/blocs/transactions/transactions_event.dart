import 'package:first/features/home/models/transaction.dart';

abstract class TransactionsEvent {}

class TransactionsLoadRequested extends TransactionsEvent {
  final int accountId;
  TransactionsLoadRequested(this.accountId);
}

class TransactionsFilterChanged extends TransactionsEvent {
  final TransactionType? filter;
  TransactionsFilterChanged(this.filter);
}
