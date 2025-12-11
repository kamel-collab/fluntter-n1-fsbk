import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AccountGraph extends StatelessWidget {
  const AccountGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 8,
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 1),
              FlSpot(1, 3),
              FlSpot(2, 1),
              FlSpot(3, 4),
              FlSpot(4, 3),
              FlSpot(5, 8),
              FlSpot(6, 4),
            ],
            isCurved: true,
            color: Colors.white54,
            barWidth: 3,
            dotData: FlDotData(show: false),
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
