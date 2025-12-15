// lib/blocs/header/header_bloc.dart

import 'package:bloc/bloc.dart';
import 'header_event.dart';
import 'header_state.dart';
import 'package:first/features/home/models/account.dart';

class HeaderBloc extends Bloc<HeaderEvent, HeaderState> {
  HeaderBloc()
    : super(
        HeaderState(
          currentPage: 0,
          isHidden: false,
          accounts: const [
            Account(
              label: "CPTES CHEQUES PERS.FRANSABANK",
              solde: 2589.50,
              veille: 3189.50,
            ),
            Account(label: "COMPTE ÉPARGNE", solde: 12000.00, veille: 11800.00),
            Account(
              label: "COMPTE PROFESSIONNEL",
              solde: 460000.75,
              veille: 459800.20,
            ),
          ],
        ),
      ) {
    // Quand l’indice change
    on<HeaderCurrentPageChanged>((event, emit) {
      emit(state.copyWith(currentPage: event.newIndex));
    });
    // Quand on alterne la visibilité
    on<HeaderToggleHidden>((event, emit) {
      emit(state.copyWith(isHidden: !state.isHidden));
    });
  }
}
