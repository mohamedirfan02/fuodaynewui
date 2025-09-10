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
    final totalJobs = dataMap.values.fold<double>(0, (a, b) => a + b).toInt();

    return Container(
      width: 327.w, // ✅ Outer card width
      height: 315.45.h, // ✅ Outer card height
      padding: EdgeInsets.all(18.47.w), // ✅ Padding from Figma
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.77.w, // ✅ Border width
          color: AppColors.greyColor.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(7.69.r), // ✅ Border radius
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
                fontSize: 16.sp,
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
                      fontSize: 11.sp,
                      color: AppColors.subTitleColor,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12.sp,
                      color: AppColors.titleColor,
                    ),
                  ],
                ),
              )
            ],
          ),

          SizedBox(height: 16.h),

          // Pie chart with circular center (from Figma data)
          Center(
            child: SizedBox(
              width: 151.62.w,
              height: 149.97.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Donut chart
                  PieChart(
                    dataMap: dataMap,
                    colorList: colorMap.values.toList(),
                    chartType: ChartType.ring,
                    ringStrokeWidth: 20.w,

                    chartValuesOptions:
                    const ChartValuesOptions(showChartValues: false),
                    legendOptions: const LegendOptions(showLegends: false),
                    chartLegendSpacing: 12.w,  // Adds gap between slices
                  ),

                  // inner circle
                  Positioned(
                    top: 39.83.h,  // from Figma
                    left: 32.83.w, // from Figma
                    child: Container(
                      width: 86.2.w,
                      height: 86.2.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // rgba(0,0,0,0.1)
                            blurRadius: 33.14.r, // spread softness
                            offset: Offset(0, 4.14.h), // X=0, Y=4.14
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
                            fontSize: 14.sp,
                            color: AppColors.titleColor,
                          ),
                          SizedBox(height: 2.h),
                          KText(
                            text: "Total Jobs",
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: AppColors.subTitleColor,
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),



          SizedBox(height: 16.93.h), //  gap before legend

          // ✅ Legend section sized
          SizedBox(
            width: 296.99.w,
            height: 78.54.h,
            child: Column(
              children: dataMap.entries.map((entry) {
                final label = entry.key;
                final value = entry.value.toInt();
                final color = colorMap[label]!;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.77.h / 2), // ✅ gap / 2
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
          ),
        ],
      ),
    );
  }
}
