import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class RequirementStatsCard extends StatelessWidget {
  final Map<String, double> dataMap;
  final Map<String, Color> colorMap;

  const RequirementStatsCard({
    super.key,
    required this.dataMap,
    required this.colorMap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final totalJobs = dataMap.values.fold<double>(0, (a, b) => a + b).toInt();

    // Scale factor for adaptive UI
    final scale = screenWidth / 375; // 375 is base iPhone width from Figma

    return Container(
      width: screenWidth * 0.87, // ≈ 327 from 375
      height: screenHeight * 0.45, // adaptive height
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.8 * scale,
          color: AppColors.greyColor.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8 * scale),
        color: AppColors.secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KText(
                text: "Total Requirement",
                fontWeight: FontWeight.w600,
                fontSize: 16 * scale,
                color: AppColors.titleColor,
              ),
              InkWell(
                onTap: () {
                  // TODO: navigate to full screen
                },
                child: Row(
                  children: [
                    KText(
                      text: "See all",
                      fontWeight: FontWeight.w500,
                      fontSize: 11 * scale,
                      color: AppColors.subTitleColor,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12 * scale,
                      color: AppColors.titleColor,
                    ),
                  ],
                ),
              )
            ],
          ),

          SizedBox(height: 16 * scale),

          // Pie chart
          Center(
            child: SizedBox(
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    dataMap: dataMap,
                    colorList: colorMap.values.toList(),
                    chartType: ChartType.ring,
                    ringStrokeWidth: 20 * scale,
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValues: false,
                    ),
                    legendOptions: const LegendOptions(showLegends: false),
                    chartLegendSpacing: 12 * scale,
                  ),

                  // Inner circle
                  Container(
                    width: screenWidth * 0.22,
                    height: screenWidth * 0.22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30 * scale,
                          offset: Offset(0, 4 * scale),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KText(
                          text: totalJobs.toString(),
                          fontWeight: FontWeight.w700,
                          fontSize: 14 * scale,
                          color: AppColors.titleColor,
                        ),
                        SizedBox(height: 2 * scale),
                        KText(
                          text: "Total Jobs",
                          fontWeight: FontWeight.w500,
                          fontSize: 10 * scale,
                          color: AppColors.subTitleColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16 * scale),

          // ✅ Legend section
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dataMap.entries.map((entry) {
                final label = entry.key;
                final value = entry.value.toInt();
                final color = colorMap[label]!;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5 * scale),
                  child: Row(
                    children: [
                      Container(
                        width: 10 * scale,
                        height: 10 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      ),
                      SizedBox(width: 8 * scale),
                      Expanded(
                        child: KText(
                          text: label,
                          fontWeight: FontWeight.w500,
                          fontSize: 12 * scale,
                          color: AppColors.titleColor,
                        ),
                      ),
                      KText(
                        text: value.toString(),
                        fontWeight: FontWeight.w600,
                        fontSize: 12 * scale,
                        color: AppColors.titleColor,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
