import 'package:first/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../providers/theme_provider.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/header/header_bloc.dart';
import '../../../blocs/header/header_event.dart';
import '../../../blocs/transactions/transactions_bloc.dart';
import '../../../blocs/transactions/transactions_event.dart';

import '../widgets/header_section.dart';
import '../widgets/transactions_section.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // ⏳ attendre que le widget soit monté
    Future.microtask(() {
      context.read<HeaderBloc>().add(HeaderLoadAccounts());
      context.read<TransactionsBloc>().add(TransactionsLoadRequested(1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bank App"),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: Column(
          children: [
            HeaderSection(),
            Expanded(child: TransactionsSection()),
          ],
        ),
      ),
    );
  }
}
