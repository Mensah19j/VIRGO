import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:virgo/core/theme/app_colors.dart';

class YearGroupBarChart extends StatelessWidget {
  /// Map of Year Group name (e.g. "Year 7") to average motivation (1-5)
  final Map<String, double> data;

  const YearGroupBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
       return const SizedBox(
        height: 200,
        child: Center(child: Text("No entries yet.")),
      );
    }

    final keys = data.keys.toList();
    
    List<BarChartGroupData> getBarGroups() {
      return List.generate(keys.length, (index) {
        final key = keys[index];
        final value = data[key] ?? 0.0;
        
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value,
              color: AppColors.gold,
              width: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 5,
                color: Theme.of(context).dividerColor.withValues(alpha:0.2),
              ),
            ),
          ],
        );
      });
    }

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          maxY: 5,
          minY: 0,
          barGroups: getBarGroups(),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 24,
                getTitlesWidget: (value, meta) {
                  if (value == 0) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= keys.length) return const SizedBox.shrink();
                  final label = keys[value.toInt()].replaceAll('Year ', 'Y');
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      label,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
