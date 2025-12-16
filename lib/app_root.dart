import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_state.dart';

import 'features/auth/pages/login_screen.dart';
import 'features/home/pages/home_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // ⏳ Bootstrap
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 🔐 Auth OK
        if (state.isAuthenticated) {
          return const HomeScreen();
        }

        // 🔓 Pas connecté
        return const LoginScreen();
      },
    );
  }
}
