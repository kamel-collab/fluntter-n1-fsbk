// lib/main.dart

import 'package:first/blocs/counter/counter_bloc.dart';
import 'package:first/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'utils/app_themes.dart';

// screens
import 'features/auth/pages/login_screen.dart';
import 'features/home/pages/home_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        // Ajoute ici d’autres BlocProvider si tu en as
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //  final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bank App",

      /* theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,

      themeMode: themeProvider.themeMode,*/
      initialRoute: CounterScreen.routeName,
      routes: {
        CounterScreen.routeName: (context) => CounterScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
