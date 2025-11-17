import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20), // widget à rechercher
      color: Colors.teal.withOpacity(0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person, size: 80, color: Colors.teal),

          const SizedBox(height: 15),
          const Text(
            "Bonjour, utilisateur !",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.favorite, color: Colors.red),
              SizedBox(width: 5),
              Text("123 Likes"),

              SizedBox(width: 10),

              Icon(Icons.message, color: Colors.blue),
              SizedBox(width: 5),
              Text("45 Messages"),
            ],
          ),

          const SizedBox(height: 20),
          const Divider(thickness: 1),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              print("Bouton cliqué !");
            },
            child: const Text("Clique ici"),
          ),
        ],
      ),
    );
  }
}
