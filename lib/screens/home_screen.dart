import 'package:first/components/profil.dart';
import 'package:first/components/zone_one.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exercice Stateless")),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () {
                print("ok");
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Card Item$index"),
              ),
            ),
          );
        },
      ),
    );
  }
}
