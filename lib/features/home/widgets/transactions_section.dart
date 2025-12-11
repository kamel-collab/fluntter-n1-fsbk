import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionsSection extends StatelessWidget {
  TransactionsSection({super.key});

  final List<TransactionModel> all = const [
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
    final Map<String, List<TransactionModel>> groups = {};

    for (var t in all) {
      groups.putIfAbsent(t.group, () => []);
      groups[t.group]!.add(t);
    }

    return ListView(
      shrinkWrap: true,

      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Transactions récentes",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        for (var entry in groups.entries) ...[
          Text(entry.key, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),

          for (var t in entry.value)
            ListTile(
              title: Text("aaa"),
              subtitle: Text(t.date),
              trailing: Text(
                "${t.amount > 0 ? '+' : ''}${t.amount.toStringAsFixed(2)} DZD",
              ),
            ),

          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
