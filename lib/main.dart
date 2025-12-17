// lib/main.dart

import 'package:first/app_root.dart';
import 'package:first/blocs/auth/auth_event.dart';
import 'package:first/core/auth/session_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'utils/app_themes.dart';

// network
import 'core/network/api_client.dart';

// repositories
import 'features/home/repositories/account_repository.dart';
import 'features/home/repositories/transaction_repository.dart';
import 'features/auth/repositories/auth_repository.dart';

// blocs
import 'blocs/auth/auth_bloc.dart';
import 'blocs/header/header_bloc.dart';
import 'blocs/transactions/transactions_bloc.dart';

// screens
import 'features/auth/pages/login_screen.dart';
import 'features/home/pages/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    // 🔌 Réseau
    final apiClient = ApiClient();

    // 🔐 Session
    final sessionStorage = SessionStorage();

    // 📦 Repositories
    final authRepository = AuthRepository(
      api: apiClient,
      sessionStorage: sessionStorage,
    );
    final accountRepository = AccountRepository(api: apiClient);
    final transactionRepository = TransactionRepository(api: apiClient);

    return Provider<ApiClient>.value(
      value: apiClient,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) =>
                AuthBloc(repository: authRepository)..add(AuthRestoreSession()),
          ),
          BlocProvider<HeaderBloc>(
            create: (_) => HeaderBloc(repository: accountRepository),
          ),
          BlocProvider<TransactionsBloc>(
            create: (_) => TransactionsBloc(repository: transactionRepository),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Bank App",
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeProvider.themeMode,
          home: const AppRoot(),
          routes: {
            LoginScreen.routeName: (_) => const LoginScreen(),
            HomeScreen.routeName: (_) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}
