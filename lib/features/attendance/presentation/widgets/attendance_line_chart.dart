import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AttendanceLineChart extends StatelessWidget {
  final List<double> attendanceValues;
  final List<String> months;

  const AttendanceLineChart({
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
        width: months.length * 60, // Dynamic width based on months
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 40,
                  showTitles: true,
                  getTitlesWidget: (value, _) => Text('${value.toInt()}'),
                ),
              ),
              bottomTitles: AxisTitles(
                axisNameWidget: const SizedBox.shrink(),
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 36, // 👈 Add this to give enough space
                  getTitlesWidget: (value, _) {
                    final index = value.toInt();
                    if (index >= 0 && index < months.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        // 👈 Extra top padding
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

              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  attendanceValues.length,
                  (index) => FlSpot(index.toDouble(), attendanceValues[index]),
                ),
                isCurved: true,
                color: Colors.indigo,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.indigo.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
