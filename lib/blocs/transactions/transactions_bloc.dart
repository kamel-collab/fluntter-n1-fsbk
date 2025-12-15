// lib/blocs/transactions/transactions_bloc.dart

import 'package:bloc/bloc.dart';
import 'transactions_event.dart';
import 'transactions_state.dart';
import 'package:first/features/home/models/transaction.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc()
    : super(
        const TransactionsState(
          selectedFilter: null,
          all: [
            TransactionModel(
              title: "Retrait CHQ GUI N 00000",
              date: "04 Juin 2025",
              amount: -10000,
              type: TransactionType.depense,
              group: "Aujourd’hui",
            ),
            TransactionModel(
              title: "Virement reçu",
              date: "04 Juin 2025",
              amount: 15000,
              type: TransactionType.revenu,
              group: "Aujourd’hui",
            ),
            TransactionModel(
              title: "Virement reçu AXA",
              date: "03 Juin 2025",
              amount: 5405.06,
              type: TransactionType.revenu,
              group: "Hier",
            ),
            TransactionModel(
              title: "Retrait CHQ GUI N 00000",
              date: "03 Juin 2025",
              amount: -10000,
              type: TransactionType.depense,
              group: "Lundi",
            ),
          ],
        ),
      ) {
    on<TransactionsFilterChanged>((event, emit) {
      emit(state.copyWith(selectedFilter: event.filter));
    });

    on<TransactionsLoadRequested>((event, emit) async {
      // 🔌 API plus tard
      emit(state);
    });
  }
}
