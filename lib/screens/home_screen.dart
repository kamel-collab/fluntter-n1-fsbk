import 'package:first/components/profil.dart';
import 'package:first/components/zone_one.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exercice Stateless")),
      body: Column(children: [ZoneOne(), Profil(), ZoneOne()]),
    );
  }
}
