import 'package:first/header_section.dart';
import 'package:first/transactions_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      /*
        SafeArea :
        -----------
        Ce widget protège le contenu de l'écran contre :
          - l'encoche (notch)
          - la barre de statut (heure, réseau…)
          - les bords arrondis et zones dangereuses
        Il garantit que l'interface n'est jamais coupée ou cachée 
        par des éléments physiques du téléphone.
      */
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              HeaderSection(),
              SizedBox(height: 24),
              TransactionsSection(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),

      /*
        FloatingActionButton (FAB) :
        ----------------------------
        Bouton flottant affiché en bas à droite du Scaffold.
        Utilisé pour une action principale de l'écran.
        Ici, il s'agit d'un bouton rond bleu avec trois points (more_vert).
        Flutter le positionne automatiquement au-dessus du contenu,
        ce qui lui donne un effet "flottant".
      */
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF003B90),
        child: const Icon(Icons.more_vert),
        onPressed: () {
          // Action à déclencher lors du clic
        },
      ),
    );
  }
}
