import 'package:bloc/bloc.dart';
import 'package:first/features/auth/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthState.initial()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await repository.login(email: event.email, password: event.password);

      emit(state.copyWith(isAuthenticated: true, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Identifiants invalides'));
    }
  }

  void _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthState.initial());
  }
}
