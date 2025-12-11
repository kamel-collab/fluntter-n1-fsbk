import 'package:flutter/material.dart';
import '../widgets/header_section.dart';
import '../widgets/transactions_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bank App")),

      // La colonne organise l'écran en 2 grandes zones :
      // 1️⃣ HeaderSection (taille fixe)
      // 2️⃣ TransactionsSection (qui doit prendre tout l’espace restant)
      body: Column(
        children: [
          // SECTION 1 : un widget normal qui prend seulement la place dont il a besoin
          const HeaderSection(),

          // ⭐ MINI LEÇON : Expanded
          //
          // Expanded dit à Flutter :
          // 👉 "Donne à ce widget TOUT l’espace disponible restant dans la colonne."
          //
          // Pourquoi ici ?
          // - HeaderSection a une hauteur naturelle (ex: 120px)
          // - Il reste alors toute une zone en bas pour les transactions
          //
          // Sans Expanded :
          // ❌ ListView / contenu scrollable provoquerait une erreur :
          //    “Vertical viewport was given unbounded height”
          //
          // Avec Expanded :
          // ✅ Flutter comprend qu’il doit étirer TransactionsSection
          //    pour occuper l’espace restant de l'écran.
          //
          // En pratique, Expanded est OBLIGATOIRE pour afficher un contenu
          // scrollable dans une Column.
          Expanded(child: TransactionsSection()),
        ],
      ),
    );
  }
}
