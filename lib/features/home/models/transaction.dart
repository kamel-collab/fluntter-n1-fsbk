enum TransactionType { revenu, depense }

class TransactionModel {
  final String title;
  final String date;
  final double amount;
  final TransactionType type;
  final String group;

  const TransactionModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.group,
  });
}
