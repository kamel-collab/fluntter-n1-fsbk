// lib/transaction_model.dart
enum TransactionType { revenu, depense }

class TransactionModel {
  final String title;
  final String date; // ex: 04 Juin 2025
  final double amount;
  final TransactionType type; // revenu / dépense
  final String group; // ex: "Aujourd’hui", "Hier", "Lundi"

  TransactionModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.group,
  });
}
