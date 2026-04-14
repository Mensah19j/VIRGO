import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:virgo/core/theme/app_colors.dart';

class MotivationLineChart extends StatelessWidget {
  /// Map of Day offsets (e.g. 0 to 6 for a week) vs average motivation (1-5)
  final Map<int, double> dataPoints;

  const MotivationLineChart({super.key, required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    if (dataPoints.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text("Not enough data to graph.")),
      );
    }

    final sortedKeys = dataPoints.keys.toList()..sort();
    final spots = sortedKeys.map((k) => FlSpot(k.toDouble(), dataPoints[k]!)).toList();

    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minY: 1,
          maxY: 5,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Theme.of(context).dividerColor.withValues(alpha:0.5),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  );
                },
                reservedSize: 24,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'D${value.toInt()}',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.wine,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.wine.withValues(alpha:0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
