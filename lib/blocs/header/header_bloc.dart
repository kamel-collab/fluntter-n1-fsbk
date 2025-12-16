import 'package:bloc/bloc.dart';
import 'header_event.dart';
import 'header_state.dart';
import '../../features/home/repositories/account_repository.dart';

class HeaderBloc extends Bloc<HeaderEvent, HeaderState> {
  final AccountRepository repository;

  HeaderBloc({required this.repository}) : super(HeaderState.initial()) {
    on<HeaderLoadAccounts>(_onLoadAccounts);
    on<HeaderCurrentPageChanged>(
      (event, emit) => emit(state.copyWith(currentPage: event.newIndex)),
    );
    on<HeaderToggleHidden>(
      (event, emit) => emit(state.copyWith(isHidden: !state.isHidden)),
    );
  }

  Future<void> _onLoadAccounts(
    HeaderLoadAccounts event,
    Emitter<HeaderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final accounts = await repository.fetchAccounts();

      emit(
        state.copyWith(
          accounts: accounts,
          isLoading: false,
          currentPage: 0,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
