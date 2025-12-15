// lib/blocs/transactions/transactions_event.dart

import 'package:first/features/home/models/transaction.dart';

abstract class TransactionsEvent {}

// Charger les transactions (API plus tard)
class TransactionsLoadRequested extends TransactionsEvent {}

// Changer le filtre (Tout / Revenus / Dépenses)
class TransactionsFilterChanged extends TransactionsEvent {
  final TransactionType? filter;
  TransactionsFilterChanged(this.filter);
}
