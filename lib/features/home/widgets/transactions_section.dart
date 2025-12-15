import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/transactions/transactions_bloc.dart';
import '../../../blocs/transactions/transactions_event.dart';
import '../../../blocs/transactions/transactions_state.dart';
import '../models/transaction.dart';

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          children: [
            const Text(
              "Transactions récentes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            _filters(context, state),
            const SizedBox(height: 16),

            for (var entry in state.grouped.entries) ...[
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              for (var t in entry.value) _transactionCard(t),

              const SizedBox(height: 24),
            ],
          ],
        );
      },
    );
  }

  // ───────────────── FILTERS ─────────────────
  Widget _filters(BuildContext context, TransactionsState state) {
    return Row(
      children: [
        _filterButton(context, "Tout", null, state),
        const SizedBox(width: 8),
        _filterButton(context, "Revenus", TransactionType.revenu, state),
        const Spacer(),
        _filterButton(context, "Dépenses", TransactionType.depense, state),
      ],
    );
  }

  Widget _filterButton(
    BuildContext context,
    String text,
    TransactionType? filter,
    TransactionsState state,
  ) {
    final bool active = state.selectedFilter == filter;

    Color color;
    IconData? icon;

    if (filter == TransactionType.revenu) {
      color = const Color(0xFF42C76A);
      icon = Icons.arrow_downward;
    } else if (filter == TransactionType.depense) {
      color = const Color(0xFFE36161);
      icon = Icons.arrow_upward;
    } else {
      color = const Color(0xFF0C1A3A);
    }

    return GestureDetector(
      onTap: () => context.read<TransactionsBloc>().add(
        TransactionsFilterChanged(filter),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? color.withOpacity(0.15) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: active ? color : const Color(0xFFE3E6EA)),
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

  // ───────────────── CARD ─────────────────
  Widget _transactionCard(TransactionModel t) {
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
