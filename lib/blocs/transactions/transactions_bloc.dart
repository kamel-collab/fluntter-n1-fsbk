import 'package:bloc/bloc.dart';
import 'transactions_event.dart';
import 'transactions_state.dart';
import '../../features/home/repositories/transaction_repository.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository repository;

  TransactionsBloc({required this.repository})
    : super(TransactionsState.initial()) {
    on<TransactionsLoadRequested>(_onLoad);

    on<TransactionsFilterChanged>(
      (event, emit) => emit(state.copyWith(selectedFilter: event.filter)),
    );
  }

  Future<void> _onLoad(
    TransactionsLoadRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final transactions = await repository.fetchTransactions(
        accountId: event.accountId,
      );

      emit(state.copyWith(all: transactions, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
