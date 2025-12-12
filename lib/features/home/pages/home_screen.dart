// lib/features/home/pages/home_screen.dart

import 'package:flutter/material.dart';
import '../widgets/header_section.dart';
import '../widgets/transactions_section.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderSection(),
            Expanded(child: TransactionsSection()),
          ],
        ),
      ),
    );
  }
}
