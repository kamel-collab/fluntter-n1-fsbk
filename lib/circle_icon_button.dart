import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;

  /*
    VoidCallback onTap :
    --------------------
    - Un "callback" est une fonction passée en paramètre pour être exécutée plus tard.
    - Ici, onTap représente l’action à effectuer quand l'utilisateur clique sur le bouton.
    - Cela rend le widget réutilisable : on peut choisir ce qui se passe selon le contexte.
      Exemple : ouvrir un menu, afficher une notification, changer de page, etc.
  */
  final VoidCallback onTap;

  const CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /*
        onTap :
        -------
        Déclenche le callback fourni en paramètre.
        => C’est ce qui exécute l’action réelle du bouton.
      */
      onTap: onTap,

      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
