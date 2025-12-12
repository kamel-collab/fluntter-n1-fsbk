// lib/screens/counter_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/counter_provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 👇 on obtient la valeur du compteur
    final counter = context.watch<CounterProvider>().counter;

    return Scaffold(
      appBar: AppBar(title: const Text("Compteur avec Provider")),
      body: Center(
        child: Text("$counter", style: const TextStyle(fontSize: 48)),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // 👇 on appelle la méthode increment
          context.read<CounterProvider>().increment();
        },
      ),
    );
  }
}
