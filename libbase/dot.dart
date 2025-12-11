import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final bool isActive;
  const Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 10 : 6,
      height: isActive ? 10 : 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
    );
  }
}
