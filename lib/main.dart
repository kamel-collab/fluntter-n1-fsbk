// lib/main.dart

import 'package:first/blocs/transactions/transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'utils/app_themes.dart';

// screens
import 'features/auth/pages/login_screen.dart';
import 'features/home/pages/home_screen.dart';

// blocs
import 'package:first/blocs/header/header_bloc.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        BlocProvider<TransactionsBloc>(create: (_) => TransactionsBloc()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MultiBlocProvider(
      providers: [
        // 🔁 Fournir le HeaderBloc globalement à toute l'application
        BlocProvider<HeaderBloc>(create: (_) => HeaderBloc()),
        // 📍 Tu pourras ajouter d'autres blocs ici plus tard si besoin
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Bank App",

        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeProvider.themeMode,

        initialRoute: LoginScreen.routeName,
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
