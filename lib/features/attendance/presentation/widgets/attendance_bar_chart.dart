import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AttendanceBarChart extends StatelessWidget {
  final List<double> attendanceValues; // Present days
  final List<String> months;

  const AttendanceBarChart({
    super.key,
    required this.attendanceValues,
    required this.months,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
        width: months.length * 60, // Adjust width per month
        height: 300,
        child: BarChart(
          BarChartData(
            maxY: 10,
            // Show 10 days on the right side (Y-axis)
            borderData: FlBorderData(show: true),
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 40,
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, _) => Text('${value.toInt()}'),
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 36,
                  getTitlesWidget: (value, _) {
                    final index = value.toInt();
                    if (index >= 0 && index < months.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          months[index],
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            barGroups: List.generate(
              attendanceValues.length,
              (index) => BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: attendanceValues[index],
                    width: 20,
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
