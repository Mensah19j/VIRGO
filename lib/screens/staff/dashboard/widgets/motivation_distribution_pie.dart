import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:virgo/core/theme/app_colors.dart';
import 'package:virgo/core/constants/app_constants.dart';

class MotivationDistributionPie extends StatelessWidget {
  final Map<int, int> distribution;

  const MotivationDistributionPie({super.key, required this.distribution});

  @override
  Widget build(BuildContext context) {
    if (distribution.values.every((element) => element == 0)) {
       return const SizedBox(
        height: 200,
        child: Center(child: Text("No entries yet to distribute.")),
      );
    }

    final total = distribution.values.reduce((a, b) => a + b);

    List<PieChartSectionData> getSections() {
      return List.generate(5, (i) {
        final level = i + 1;
        final count = distribution[level] ?? 0;
        final percentage = total > 0 ? (count / total) * 100 : 0.0;
        final color = AppColors.getMotivationColor(level);

        return PieChartSectionData(
          color: color,
          value: count.toDouble(),
          title: count > 0 ? '${percentage.toStringAsFixed(0)}%' : '',
          radius: 60,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          badgeWidget: count > 0 ? Text(AppConstants.motivationEmojis[level]!) : null,
          badgePositionPercentageOffset: 1.3,
        );
      });
    }

    return SizedBox(
      height: 250,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: getSections(),
        ),
      ),
    );
  }
}
