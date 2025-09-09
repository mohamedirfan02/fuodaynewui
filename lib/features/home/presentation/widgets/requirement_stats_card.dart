import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
   // final totalJobs = dataMap.values.fold(0, (a, b) => a + b).toInt();

    return Container(
      padding: EdgeInsets.all(14.w),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.w,
          color: AppColors.greyColor.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8.r),
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
                fontSize: 14.sp,
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
                      fontSize: 12.sp,
                      color: AppColors.primaryColor,
                    ),
                    Icon(Icons.arrow_forward_ios, size: 12.sp, color: AppColors.primaryColor),
                  ],
                ),
              )
            ],
          ),

          SizedBox(height: 16.h),

          // Donut chart with center text
          Center(
            child: PieChart(
              dataMap: dataMap,
              colorList: colorMap.values.toList(),
              chartType: ChartType.ring,
              chartRadius: 80.r,
              ringStrokeWidth: 12.w,
              chartValuesOptions: const ChartValuesOptions(showChartValues: false),
              legendOptions: const LegendOptions(showLegends: false),
              centerText: "Total Jobs",
              centerTextStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Legend (custom styled)
          Column(
            children: dataMap.entries.map((entry) {
              final label = entry.key;
              final value = entry.value.toInt();
              final color = colorMap[label]!;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: KText(
                        text: label,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: AppColors.titleColor,
                      ),
                    ),
                    KText(
                      text: value.toString(),
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: AppColors.titleColor,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
