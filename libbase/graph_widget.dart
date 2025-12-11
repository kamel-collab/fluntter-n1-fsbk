import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/*
  AccountGraph :
  --------------
  Ce widget affiche un VRAI graphique de tendance grâce au package fl_chart.
  Le graph est utilisé en arrière-plan du header pour donner une sensation
  de suivi d’activité bancaire.

  fl_chart est un package Flutter spécialisé pour les graphiques :
  - line charts (courbes)
  - bar charts
  - pie charts
  - sparkline
  - animations intégrées
  - haute personnalisation

  Ici on utilise uniquement un LineChart (courbe lissée).
*/
class AccountGraph extends StatelessWidget {
  const AccountGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      /*
        LineChartData :
        ---------------
        C’est le "cœur" de la configuration du graphique.
        Il contrôle :
        - les limites du graph (minX, maxX, minY, maxY)
        - l’affichage des axes
        - la grille
        - les bordures
        - les courbes (lineBarsData)
      */
      LineChartData(
        minX: 0, // coordonnée X minimum
        maxX: 6, // coordonnée X maximum
        minY: 0, // coordonnée Y minimum
        maxY: 6, // coordonnée Y maximum
        /*
          gridData :
          ----------
          Active/désactive les lignes horizontales et verticales de fond.
          Ici : désactivé pour un look propre et minimaliste.
        */
        gridData: FlGridData(show: false),

        /*
          titlesData :
          -----------
          Gère les labels (textes) sur les axes X et Y.
          Ici : désactivé, car on ne veut pas afficher les chiffres.
        */
        titlesData: FlTitlesData(show: false),

        /*
          borderData :
          ------------
          Bordures autour du graphique.
          Désactivées pour que la courbe soit "libre".
        */
        borderData: FlBorderData(show: false),

        /*
          lineBarsData :
          --------------
          Liste des courbes à afficher.
          Ici : une seule courbe "LineChartBarData".
        */
        lineBarsData: [
          LineChartBarData(
            /*
              spots :
              -------
              Liste de points (X, Y).
              Chaque FlSpot représente un point du graph.
              Ce sont les FAKE DATA pour l'exemple.
            */
            spots: [
              FlSpot(0, 1),
              FlSpot(1, 3),
              FlSpot(2, 1),
              FlSpot(3, 4),
              FlSpot(4, 3),
              FlSpot(5, 8),
              FlSpot(6, 4),
            ],

            /*
              isCurved :
              ----------
              true = la courbe est lissée (effet arrondi)
              false = courbe en segments droits
            */
            isCurved: true,

            /*
              color :
              -------
              Couleur de la ligne.
              On utilise du blanc à faible opacité pour rester discret.
            */
            color: Colors.white.withOpacity(0.45),

            /*
              barWidth :
              ----------
              Épaisseur de la ligne.
            */
            barWidth: 3,

            /*
              dotData :
              ---------
              Affichage des points (ronds) sur la courbe.
              Ils sont désactivés pour un rendu plus propre.
            */
            dotData: FlDotData(show: false),

            /*
              belowBarData :
              ---------------
              Remplissage sous la ligne du graphique.
              Ici on met un léger dégradé blanc transparent,
              pour imiter le style des apps bancaires modernes.
            */
            belowBarData: BarAreaData(
              show: true,
              color: Colors.white.withOpacity(0.10),
            ),
          ),
        ],
      ),
    );
  }
}
