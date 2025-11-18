import 'package:flutter/material.dart';
import 'transaction_model.dart';

class TransactionsSection extends StatefulWidget {
  const TransactionsSection({super.key});

  @override
  State<TransactionsSection> createState() => _TransactionsSectionState();
}

class _TransactionsSectionState extends State<TransactionsSection> {
  TransactionType? selectedFilter; // null = "Tout"

  final List<TransactionModel> all = [
    TransactionModel(
      title: "Retrait CHQ GUI N 00000",
      date: "04 Juin 2025",
      amount: -10000,
      type: TransactionType.depense,
      group: "Aujourd’hui",
    ),
    TransactionModel(
      title: "Virement reçu",
      date: "04 Juin 2025",
      amount: 15000,
      type: TransactionType.revenu,
      group: "Aujourd’hui",
    ),
    TransactionModel(
      title: "Virement reçu AXA",
      date: "03 Juin 2025",
      amount: 5405.06,
      type: TransactionType.revenu,
      group: "Hier",
    ),
    TransactionModel(
      title: "Retrait CHQ GUI N 00000",
      date: "03 Juin 2025",
      amount: -10000,
      type: TransactionType.depense,
      group: "Lundi",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Transactions récentes",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0C1A3A),
            ),
          ),

          const SizedBox(height: 16),

          _filters(),

          const SizedBox(height: 16),

          /*
            ..._groupedWidgets()
            ---------------------
            C’est ce qu’on appelle un "spread operator" en Dart.
            Il permet de "déplier" une liste de Widgets dans une autre liste.

            Exemple :
              au lieu de faire :
                children: [
                  Column(...),
                  Column(...),
                ]

              on peut faire :
                children: [
                  ...listeDeColonnes
                ]

            Ici :
            _groupedWidgets() retourne une LISTE de Widgets.
            Le "..." INSÈRE chaque widget de cette liste individuellement
            dans la Column.

            Sans "..." => ERREUR, car Flutter attend une liste de widgets,
            pas une liste DE liste.
          */
          ..._groupedWidgets(),
        ],
      ),
    );
  }

  //---------------------------------------------------------------------------
  // FILTRES
  //---------------------------------------------------------------------------

  Widget _filters() {
    return Row(
      children: [
        _filterButton("Tout", null),
        const SizedBox(width: 8),
        _filterButton("Revenus", TransactionType.revenu),
        const SizedBox(width: 8),
        _filterButton("Dépenses", TransactionType.depense),
      ],
    );
  }

  Widget _filterButton(String text, TransactionType? filterType) {
    final bool active = selectedFilter == filterType;

    Color color;
    IconData? icon;

    if (filterType == TransactionType.revenu) {
      color = const Color(0xFF42C76A);
      icon = Icons.arrow_downward;
    } else if (filterType == TransactionType.depense) {
      color = const Color(0xFFE36161);
      icon = Icons.arrow_upward;
    } else {
      color = const Color(0xFF0C1A3A);
    }

    return GestureDetector(
      onTap: () {
        setState(() => selectedFilter = filterType);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? color.withOpacity(0.15) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? color : const Color(0xFFE3E6EA),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, size: 16, color: active ? color : Colors.grey),
            if (icon != null) const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: active ? color : const Color(0xFF0C1A3A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //---------------------------------------------------------------------------
  // GROUPES DE TRANSACTIONS
  //---------------------------------------------------------------------------

  List<Widget> _groupedWidgets() {
    // filtrage logique
    List<TransactionModel> filtered = selectedFilter == null
        ? all
        : all.where((t) => t.type == selectedFilter).toList();

    // regroupement par "Aujourd’hui", "Hier", etc.
    Map<String, List<TransactionModel>> groups = {};
    for (var t in filtered) {
      groups.putIfAbsent(t.group, () => []);
      groups[t.group]!.add(t);
    }

    // construction UI
    return groups.entries.map((entry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.key,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0C1A3A),
            ),
          ),

          const SizedBox(height: 12),

          /*
            ...entry.value.map(_transactionTile)
            ------------------------------------
            entry.value = liste des transactions du groupe
            map(_transactionTile) transforme CHAQUE transaction
            en widget (la tuile visuelle).

            MAIS :
            - map() retourne un "Iterable"
            - Flutter a besoin d'une vraie LISTE de widgets !

            Donc on fait :  
              ...entry.value.map(_transactionTile)

            → Le "..." déplie chaque widget généré
              et l'insère individuellement dans la Column.

            Exemple simplifié :
              map() génère : [WidgetA, WidgetB]
              ...map() devient : WidgetA, WidgetB
          */
          ...entry.value.map(_transactionTile),

          const SizedBox(height: 24),
        ],
      );
    }).toList();
  }

  //---------------------------------------------------------------------------
  // TILE D'UNE TRANSACTION
  //---------------------------------------------------------------------------

  Widget _transactionTile(TransactionModel t) {
    final bool isIncome = t.type == TransactionType.revenu;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // cercle icône
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (isIncome ? Colors.green : Colors.red).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),

          const SizedBox(width: 12),

          // titre + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Color(0xFF0C1A3A),
                  ),
                ),
                Text(
                  t.date,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          // montant
          Text(
            "${t.amount > 0 ? '+' : ''}${t.amount.toStringAsFixed(2)} DZD",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
