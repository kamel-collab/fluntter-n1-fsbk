import 'package:flutter/material.dart';
import '../../../core/widgets/circle_icon_button.dart';
import '../../../core/widgets/graph_widget.dart';
import '../models/account.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mockAccount = Account(label: "Compte Principal", balance: 1500.00);

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleIconButton(icon: Icons.menu, onTap: () {}),
              const SizedBox(width: 12),
              Text(
                mockAccount.label,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "${mockAccount.balance} DZD",
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
          const SizedBox(height: 16),
          const AccountGraph(),
        ],
      ),
    );
  }
}
